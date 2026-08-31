using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Codelecta_2._0.Models;

namespace Codelecta_2._0.Admin
{
    public partial class ManageEnrollments : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated || !User.IsInRole("Admin"))
            {
                Response.Redirect("~/");
                return;
            }

            if (!IsPostBack)
            {
                LoadDropdowns();
                LoadStats();
                BindEnrollments();
            }
        }

        private void LoadDropdowns()
        {
            using (var db = new ApplicationDbContext())
            {
                var users = db.Users.OrderBy(u => u.FullName ?? u.UserName).ToList().Select(u => new
                {
                    Id = u.Id,
                    DisplayText = !string.IsNullOrWhiteSpace(u.FullName) ? string.Format("{0} ({1})", u.FullName, u.Email) : u.Email
                }).ToList();

                ddlUsers.DataSource = users;
                ddlUsers.DataTextField = "DisplayText";
                ddlUsers.DataValueField = "Id";
                ddlUsers.DataBind();

                var courses = db.Courses.OrderBy(c => c.Title).ToList();
                ddlCourses.DataSource = courses;
                ddlCourses.DataTextField = "Title";
                ddlCourses.DataValueField = "Id";
                ddlCourses.DataBind();
            }
        }

        private void LoadStats()
        {
            using (var db = new ApplicationDbContext())
            {
                int totalEnrollments = db.UserCourses.Count();
                int uniqueStudents = db.UserCourses.Select(uc => uc.UserId).Distinct().Count();

                var allEnrollments = db.UserCourses.Include(uc => uc.Course.Lessons).ToList();
                var allCompletedLessonProgresses = db.LessonProgresses.Where(lp => lp.IsCompleted).ToList();

                int completed100Count = 0;
                int inProgressCount = 0;

                foreach (var uc in allEnrollments)
                {
                    int totalLessons = uc.Course != null && uc.Course.Lessons != null ? uc.Course.Lessons.Count : 0;
                    if (totalLessons == 0) continue;

                    int userCompleted = allCompletedLessonProgresses.Count(lp => lp.UserId == uc.UserId && uc.Course.Lessons.Any(l => l.Id == lp.LessonId));
                    if (userCompleted >= totalLessons)
                        completed100Count++;
                    else
                        inProgressCount++;
                }

                lblTotalEnrollments.Text = totalEnrollments.ToString();
                lblCompletedCount.Text = completed100Count.ToString();
                lblInProgressCount.Text = inProgressCount.ToString();
                lblUniqueStudents.Text = uniqueStudents.ToString();
            }
        }

        private void BindEnrollments()
        {
            string searchTerm = txtSearch.Text.Trim().ToLower();
            string filterStatus = ddlFilterStatus.SelectedValue;

            using (var db = new ApplicationDbContext())
            {
                var enrollments = db.UserCourses
                    .Include(uc => uc.User)
                    .Include(uc => uc.Course)
                    .Include(uc => uc.Course.Lessons)
                    .OrderByDescending(uc => uc.EnrollmentDate)
                    .ToList();

                var completedLessonIds = db.LessonProgresses
                    .Where(lp => lp.IsCompleted)
                    .Select(lp => new { lp.UserId, lp.LessonId })
                    .ToList();

                var enrollmentViewModels = new List<EnrollmentViewModel>();

                foreach (var uc in enrollments)
                {
                    string studentName = uc.User != null && !string.IsNullOrWhiteSpace(uc.User.FullName) ? uc.User.FullName : "Student";
                    string studentEmail = uc.User != null ? uc.User.Email : "";
                    string courseTitle = uc.Course != null ? uc.Course.Title : "";
                    string courseLevel = uc.Course != null ? uc.Course.Level : "All Levels";

                    // Check search query
                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        bool matches = studentName.ToLower().Contains(searchTerm) ||
                                       studentEmail.ToLower().Contains(searchTerm) ||
                                       courseTitle.ToLower().Contains(searchTerm);
                        if (!matches) continue;
                    }

                    int totalLessons = uc.Course != null && uc.Course.Lessons != null ? uc.Course.Lessons.Count : 0;
                    int completedLessons = totalLessons > 0
                        ? uc.Course.Lessons.Count(l => completedLessonIds.Any(c => c.UserId == uc.UserId && c.LessonId == l.Id))
                        : 0;

                    int progressPct = totalLessons > 0 ? (int)Math.Round(((double)completedLessons / totalLessons) * 100) : 0;

                    // Filter by status
                    if (filterStatus == "completed" && progressPct < 100) continue;
                    if (filterStatus == "inprogress" && progressPct == 100) continue;

                    enrollmentViewModels.Add(new EnrollmentViewModel
                    {
                        EnrollmentId = uc.Id,
                        StudentName = studentName,
                        StudentEmail = studentEmail,
                        CourseTitle = courseTitle,
                        CourseLevel = courseLevel,
                        TotalLessons = totalLessons,
                        CompletedLessons = completedLessons,
                        ProgressPercent = progressPct,
                        EnrollmentDate = uc.EnrollmentDate
                    });
                }

                lblFilteredCount.Text = enrollmentViewModels.Count.ToString();

                if (enrollmentViewModels.Count > 0)
                {
                    rptEnrollments.DataSource = enrollmentViewModels;
                    rptEnrollments.DataBind();
                    rptEnrollments.Visible = true;
                    pnlNoEnrollments.Visible = false;
                }
                else
                {
                    rptEnrollments.Visible = false;
                    pnlNoEnrollments.Visible = true;
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindEnrollments();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlFilterStatus.SelectedValue = "all";
            BindEnrollments();
        }

        protected void btnEnrollStudent_Click(object sender, EventArgs e)
        {
            if (ddlUsers.Items.Count == 0 || ddlCourses.Items.Count == 0) return;

            string userId = ddlUsers.SelectedValue;
            int courseId = int.Parse(ddlCourses.SelectedValue);

            using (var db = new ApplicationDbContext())
            {
                bool alreadyEnrolled = db.UserCourses.Any(uc => uc.UserId == userId && uc.CourseId == courseId);
                if (alreadyEnrolled)
                {
                    ShowMessage("This student is already enrolled in the selected course.", false);
                    return;
                }

                var enrollment = new UserCourse
                {
                    UserId = userId,
                    CourseId = courseId,
                    EnrollmentDate = DateTime.Now
                };

                db.UserCourses.Add(enrollment);
                db.SaveChanges();
                ShowMessage("✓ Student enrolled in course successfully!", true);
            }

            LoadStats();
            BindEnrollments();
        }

        protected void rptEnrollments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DropEnrollment")
            {
                int enrollmentId = int.Parse(e.CommandArgument.ToString());
                using (var db = new ApplicationDbContext())
                {
                    var enrollment = db.UserCourses.Find(enrollmentId);
                    if (enrollment != null)
                    {
                        db.UserCourses.Remove(enrollment);
                        db.SaveChanges();
                        ShowMessage("✓ Enrollment dropped successfully.", true);
                    }
                }

                LoadStats();
                BindEnrollments();
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblActionMessage.Text = message;
            pnlMessage.Visible = true;
            pnlMessage.Style["background"] = isSuccess ? "#ECFDF5" : "#FEF2F2";
            pnlMessage.Style["color"] = isSuccess ? "#065F46" : "#991B1B";
            pnlMessage.Style["border"] = isSuccess ? "1px solid #6EE7B7" : "1px solid #FECACA";
        }
    }

    public class EnrollmentViewModel
    {
        public int EnrollmentId { get; set; }
        public string StudentName { get; set; }
        public string StudentEmail { get; set; }
        public string CourseTitle { get; set; }
        public string CourseLevel { get; set; }
        public int TotalLessons { get; set; }
        public int CompletedLessons { get; set; }
        public int ProgressPercent { get; set; }
        public DateTime EnrollmentDate { get; set; }
    }
}
