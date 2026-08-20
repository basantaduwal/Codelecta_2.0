using System;
using System.Linq;
using Microsoft.AspNet.Identity;
using Codelecta_2._0.Models;

namespace Codelecta_2._0.Admin
{
    public partial class ManageCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourses();
            }
        }

        private void LoadCourses()
        {
            string userId = User.Identity.GetUserId();
            using (var db = new ApplicationDbContext())
            {
                var courses = db.Courses
                    .Where(c => c.InstructorId == userId)
                    .OrderByDescending(c => c.CreatedDate)
                    .ToList();
                
                if (courses.Count > 0)
                {
                    rptCourses.DataSource = courses;
                    rptCourses.DataBind();
                    rptCourses.Visible = true;
                    lblNoCourses.Visible = false;
                }
                else
                {
                    rptCourses.Visible = false;
                    lblNoCourses.Visible = true;
                }
            }
        }

        protected void btnCreateCourse_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtCourseTitle.Text))
            {
                lblMessage.Text = "Title is required.";
                lblMessage.ForeColor = System.Drawing.ColorTranslator.FromHtml("#F59E0B"); // Warning color
                return;
            }

            using (var db = new ApplicationDbContext())
            {
                var course = new Course
                {
                    Title = txtCourseTitle.Text.Trim(),
                    Description = txtCourseDescription.Text.Trim(),
                    CreatedDate = DateTime.Now,
                    InstructorId = User.Identity.GetUserId()
                };

                db.Courses.Add(course);
                db.SaveChanges();
            }

            txtCourseTitle.Text = "";
            txtCourseDescription.Text = "";
            lblMessage.Text = "Course created successfully!";
            lblMessage.ForeColor = System.Drawing.ColorTranslator.FromHtml("#10B981"); // Success color

            LoadCourses(); // Refresh the list
        }
    }
}
