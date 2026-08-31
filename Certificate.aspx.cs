using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Codelecta_2._0.Models;

namespace Codelecta_2._0
{
    public partial class Certificate : Page
    {
        private int CourseId
        {
            get
            {
                int id;
                if (int.TryParse(Request.QueryString["courseId"], out id))
                    return id;
                return 0;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login");
                return;
            }

            if (CourseId == 0)
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCertificate();
            }
        }

        private void LoadCertificate()
        {
            string userId = User.Identity.GetUserId();

            using (var db = new ApplicationDbContext())
            {
                var course = db.Courses.Include(c => c.Lessons).FirstOrDefault(c => c.Id == CourseId);
                if (course == null)
                {
                    Response.Redirect("Dashboard.aspx");
                    return;
                }

                // Check if user is enrolled
                bool isEnrolled = db.UserCourses.Any(uc => uc.UserId == userId && uc.CourseId == CourseId);
                if (!isEnrolled)
                {
                    Response.Redirect("CourseDetail.aspx?id=" + CourseId);
                    return;
                }

                // Verify user has completed 100% of lessons in this course
                var completedLessonIds = new HashSet<int>(
                    db.LessonProgresses
                        .Where(lp => lp.UserId == userId && lp.IsCompleted)
                        .Select(lp => lp.LessonId)
                        .ToList()
                );

                int totalLessons = course.Lessons.Count;
                int completedCount = course.Lessons.Count(l => completedLessonIds.Contains(l.Id));

                // If course has lessons but user hasn't finished all of them, redirect back
                if (totalLessons > 0 && completedCount < totalLessons)
                {
                    Response.Redirect("CourseDetail.aspx?id=" + CourseId);
                    return;
                }

                // User details
                var user = db.Users.Find(userId);
                string studentName = "Valued Learner";
                if (user != null)
                {
                    if (!string.IsNullOrWhiteSpace(user.FullName))
                        studentName = user.FullName;
                    else if (!string.IsNullOrWhiteSpace(user.UserName))
                        studentName = user.UserName.Contains("@") ? user.UserName.Split('@')[0] : user.UserName;
                }

                lblStudentName.Text = studentName;
                lblCourseTitle.Text = course.Title;
                lblIssueDate.Text = DateTime.Now.ToString("MMMM dd, yyyy");

                // Generate deterministic / official verification code (e.g. CDL-2026-XXXX)
                string hashSeed = string.Format("{0}-{1}", userId.Substring(0, Math.Min(8, userId.Length)), CourseId);
                int hash = Math.Abs(hashSeed.GetHashCode()) % 900000 + 100000;
                lblCertificateId.Text = string.Format("CDL-{0}-{1}", DateTime.Now.Year, hash);
            }
        }
    }
}
