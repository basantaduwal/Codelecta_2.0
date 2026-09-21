using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Codelecta_2._0.Models;

namespace Codelecta_2._0
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            string userId = User.Identity.GetUserId();

            using (var db = new ApplicationDbContext())
            {
                var currentUser = db.Users.Find(userId);
                if (currentUser != null && !string.IsNullOrWhiteSpace(currentUser.FullName))
                {
                    lblUserName.Text = currentUser.FullName;
                }
                else
                {
                    string name = User.Identity.GetUserName();
                    lblUserName.Text = (!string.IsNullOrEmpty(name) && name.Contains("@")) ? name.Split('@')[0] : (name ?? "Learner");
                }
                // Fetch enrolled courses for this student
                var userCourses = db.UserCourses
                    .Where(uc => uc.UserId == userId)
                    .Include(uc => uc.Course)
                    .Include(uc => uc.Course.Lessons)
                    .OrderByDescending(uc => uc.EnrollmentDate)
                    .ToList();

                // Fetch IDs of all lessons completed by this student
                var completedLessonIds = new HashSet<int>(
                    db.LessonProgresses
                        .Where(lp => lp.UserId == userId && lp.IsCompleted)
                        .Select(lp => lp.LessonId)
                        .ToList()
                );

                int totalLessonsAcrossAll = 0;
                int totalCompletedLessonsAcrossAll = 0;

                var dashboardItems = new List<DashboardCourseViewModel>();

                foreach (var uc in userCourses)
                {
                    var course = uc.Course;
                    if (course == null) continue;

                    var sortedLessons = course.Lessons.OrderBy(l => l.OrderIndex).ToList();
                    int totalInCourse = sortedLessons.Count;
                    int completedInCourse = sortedLessons.Count(l => completedLessonIds.Contains(l.Id));

                    totalLessonsAcrossAll += totalInCourse;
                    totalCompletedLessonsAcrossAll += completedInCourse;

                    int progressPercent = totalInCourse > 0
                        ? (int)Math.Round(((double)completedInCourse / totalInCourse) * 100)
                        : 0;

                    // Next lesson to continue: the first incomplete lesson, or the first lesson
                    var nextLesson = sortedLessons.FirstOrDefault(l => !completedLessonIds.Contains(l.Id))
                                  ?? sortedLessons.FirstOrDefault();

                    // Instructor name
                    string instructorName = "Admin";
                    if (!string.IsNullOrEmpty(course.InstructorId))
                    {
                        var instructor = db.Users.FirstOrDefault(u => u.Id == course.InstructorId);
                        if (instructor != null)
                        {
                            instructorName = instructor.UserName;
                        }
                    }

                    dashboardItems.Add(new DashboardCourseViewModel
                    {
                        CourseId = course.Id,
                        CourseTitle = course.Title,
                        CourseDescription = course.Description,
                        EnrollmentDate = uc.EnrollmentDate,
                        InstructorName = instructorName,
                        TotalLessons = totalInCourse,
                        CompletedLessons = completedInCourse,
                        ProgressPercent = progressPercent,
                        NextLessonId = nextLesson != null ? nextLesson.Id : 0
                    });
                }

                // Summary Stats
                lblTotalEnrolled.Text = userCourses.Count.ToString();
                lblCompletedLessons.Text = totalCompletedLessonsAcrossAll.ToString();

                int overallProgress = totalLessonsAcrossAll > 0
                    ? (int)Math.Round(((double)totalCompletedLessonsAcrossAll / totalLessonsAcrossAll) * 100)
                    : 0;
                lblCompletionRate.Text = overallProgress + "%";

                // Bind Repeater or show Empty State
                if (dashboardItems.Count > 0)
                {
                    rptEnrolledCourses.DataSource = dashboardItems;
                    rptEnrolledCourses.DataBind();
                    rptEnrolledCourses.Visible = true;
                    pnlNoCourses.Visible = false;
                }
                else
                {
                    rptEnrolledCourses.Visible = false;
                    pnlNoCourses.Visible = true;
                }

                // Load Quiz Assessment History
                var userAttempts = db.QuizAttempts
                    .Where(qa => qa.UserId == userId)
                    .Include(qa => qa.Quiz)
                    .Include(qa => qa.Quiz.Course)
                    .OrderByDescending(qa => qa.AttemptDate)
                    .ToList()
                    .Select(qa => new
                    {
                        QuizId = qa.QuizId,
                        QuizTitle = qa.Quiz != null ? qa.Quiz.Title : "Assessment",
                        CourseTitle = (qa.Quiz != null && qa.Quiz.Course != null) ? qa.Quiz.Course.Title : "General",
                        ScorePercent = qa.ScorePercent,
                        CorrectAnswers = qa.CorrectAnswers,
                        TotalQuestions = qa.TotalQuestions,
                        IsPassed = qa.IsPassed,
                        AttemptDate = qa.AttemptDate
                    })
                    .ToList();

                if (userAttempts.Count > 0)
                {
                    rptQuizHistory.DataSource = userAttempts;
                    rptQuizHistory.DataBind();
                    pnlQuizHistory.Visible = true;
                }
                else
                {
                    pnlQuizHistory.Visible = false;
                }
            }

            // Load 30-day activity heatmap
            LoadDayWiseProgress(userId);
        }

        // ─── Day-wise progress heatmap ────────────────────────────────────────
        private void LoadDayWiseProgress(string userId)
        {
            var today = DateTime.Today;
            var from  = today.AddDays(-29);

            using (var db = new ApplicationDbContext())
            {
                var rawActivity = db.LessonProgresses
                    .Where(lp => lp.UserId == userId
                              && lp.IsCompleted
                              && lp.CompletedDate.HasValue
                              && lp.CompletedDate >= from)
                    .Select(lp => new { lp.CompletedDate })
                    .ToList();

                var activityMap = rawActivity
                    .GroupBy(x => x.CompletedDate.Value.Date)
                    .ToDictionary(g => g.Key, g => g.Count());

                var cells = new List<DayActivityCell>();
                for (int i = 29; i >= 0; i--)
                {
                    var day   = today.AddDays(-i);
                    int count = activityMap.ContainsKey(day) ? activityMap[day] : 0;
                    cells.Add(new DayActivityCell
                    {
                        Date        = day,
                        LessonCount = count,
                        DayLabel    = day.ToString("MMM d"),
                        IsToday     = (day == today)
                    });
                }

                // Streak: consecutive days with lessons, counting back from today
                int streak = 0;
                for (int i = 0; i <= 29; i++)
                {
                    var day = today.AddDays(-i);
                    if (activityMap.ContainsKey(day) && activityMap[day] > 0)
                        streak++;
                    else
                        break;
                }

                lblCurrentStreak.Text     = streak.ToString();
                lblActivityDaysCount.Text = activityMap.Count.ToString();

                rptDayActivity.DataSource = cells;
                rptDayActivity.DataBind();
            }
        }
    }

    public class DashboardCourseViewModel
    {
        public int    CourseId          { get; set; }
        public string CourseTitle       { get; set; }
        public string CourseDescription { get; set; }
        public DateTime EnrollmentDate  { get; set; }
        public string InstructorName    { get; set; }
        public int    TotalLessons      { get; set; }
        public int    CompletedLessons  { get; set; }
        public int    ProgressPercent   { get; set; }
        public int    NextLessonId      { get; set; }
    }

    public class DayActivityCell
    {
        public DateTime Date        { get; set; }
        public int      LessonCount { get; set; }
        public string   DayLabel    { get; set; }
        public bool     IsToday     { get; set; }

        public string CellBg
        {
            get
            {
                if (LessonCount == 0) return "#EDE9FE";
                if (LessonCount == 1) return "#A78BFA";
                if (LessonCount == 2) return "#7C3AED";
                return "#4C1D95";
            }
        }

        public string CellOpacity => LessonCount == 0 ? "0.35" : "1";

        public string Tooltip => LessonCount == 0
            ? DayLabel + ": No lessons"
            : DayLabel + ": " + LessonCount + " lesson" + (LessonCount > 1 ? "s" : "");
    }
}
