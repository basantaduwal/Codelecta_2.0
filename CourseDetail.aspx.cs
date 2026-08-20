using System;
using System.Linq;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Codelecta_2._0.Models;

namespace Codelecta_2._0
{
    public partial class CourseDetail : Page
    {
        public bool IsEnrolled { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourse();
            }
        }

        private int GetCourseId()
        {
            int id;
            if (int.TryParse(Request.QueryString["id"], out id))
                return id;
            return 0;
        }

        private void LoadCourse()
        {
            int courseId = GetCourseId();
            if (courseId == 0)
            {
                Response.Redirect("Courses.aspx");
                return;
            }

            using (var db = new ApplicationDbContext())
            {
                var course = db.Courses.FirstOrDefault(c => c.Id == courseId);
                if (course == null)
                {
                    Response.Redirect("Courses.aspx");
                    return;
                }

                lblTitle.Text = course.Title;
                lblDescription.Text = course.Description;

                // Get instructor name
                var instructor = db.Users.FirstOrDefault(u => u.Id == course.InstructorId);
                lblInstructor.Text = instructor != null ? instructor.UserName : "Unknown";

                // Load lessons
                var lessons = db.Lessons
                    .Where(l => l.CourseId == courseId)
                    .OrderBy(l => l.OrderIndex)
                    .ToList();

                lblLessonCount.Text = lessons.Count.ToString();

                if (lessons.Count > 0)
                {
                    rptLessons.DataSource = lessons;
                    rptLessons.DataBind();
                    rptLessons.Visible = true;
                    lblNoLessons.Visible = false;
                }
                else
                {
                    rptLessons.Visible = false;
                    lblNoLessons.Visible = true;
                }

                // Check enrollment status
                if (User.Identity.IsAuthenticated)
                {
                    string userId = User.Identity.GetUserId();
                    IsEnrolled = db.UserCourses.Any(uc => uc.UserId == userId && uc.CourseId == courseId);

                    if (IsEnrolled)
                    {
                        lblEnrolled.Visible = true;
                        pnlEnroll.Visible = false;
                    }
                    else
                    {
                        pnlEnroll.Visible = true;
                    }
                }
                else
                {
                    lblLoginPrompt.Visible = true;
                }
            }
        }

        protected void btnEnroll_Click(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                return;

            int courseId = GetCourseId();
            string userId = User.Identity.GetUserId();

            using (var db = new ApplicationDbContext())
            {
                // Check if already enrolled
                bool alreadyEnrolled = db.UserCourses.Any(uc => uc.UserId == userId && uc.CourseId == courseId);
                if (!alreadyEnrolled)
                {
                    var enrollment = new UserCourse
                    {
                        UserId = userId,
                        CourseId = courseId,
                        EnrollmentDate = DateTime.Now
                    };
                    db.UserCourses.Add(enrollment);
                    db.SaveChanges();
                }
            }

            // Reload the page to reflect enrollment
            Response.Redirect("CourseDetail.aspx?id=" + courseId);
        }
    }
}
