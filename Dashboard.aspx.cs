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
        }
    }

    public class DashboardCourseViewModel
    {
        public int CourseId { get; set; }
        public string CourseTitle { get; set; }
        public string CourseDescription { get; set; }
        public DateTime EnrollmentDate { get; set; }
        public string InstructorName { get; set; }
        public int TotalLessons { get; set; }
        public int CompletedLessons { get; set; }
        public int ProgressPercent { get; set; }
        public int NextLessonId { get; set; }
    }
}
