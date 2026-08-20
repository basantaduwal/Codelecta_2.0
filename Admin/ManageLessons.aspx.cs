using System;
using System.Linq;
using Microsoft.AspNet.Identity;
using Codelecta_2._0.Models;

namespace Codelecta_2._0.Admin
{
    public partial class ManageLessons : System.Web.UI.Page
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
            if (CourseId == 0)
            {
                Response.Redirect("ManageCourses.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCourseInfo();
                LoadLessons();
            }
        }

        private void LoadCourseInfo()
        {
            string userId = User.Identity.GetUserId();
            using (var db = new ApplicationDbContext())
            {
                var course = db.Courses.FirstOrDefault(c => c.Id == CourseId && c.InstructorId == userId);
                if (course == null)
                {
                    Response.Redirect("ManageCourses.aspx");
                    return;
                }
                lblCourseTitle.Text = course.Title;
            }
        }

        private void LoadLessons()
        {
            using (var db = new ApplicationDbContext())
            {
                var lessons = db.Lessons
                    .Where(l => l.CourseId == CourseId)
                    .OrderBy(l => l.OrderIndex)
                    .ToList();

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
            }
        }

        protected void btnAddLesson_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtLessonTitle.Text))
            {
                lblMessage.Text = "Lesson title is required.";
                lblMessage.ForeColor = System.Drawing.ColorTranslator.FromHtml("#F59E0B");
                return;
            }

            int order;
            if (!int.TryParse(txtOrder.Text, out order))
                order = 1;

            using (var db = new ApplicationDbContext())
            {
                var lesson = new Lesson
                {
                    Title = txtLessonTitle.Text.Trim(),
                    Content = txtLessonContent.Text.Trim(),
                    VideoUrl = txtVideoUrl.Text.Trim(),
                    OrderIndex = order,
                    CourseId = CourseId
                };

                db.Lessons.Add(lesson);
                db.SaveChanges();
            }

            txtLessonTitle.Text = "";
            txtLessonContent.Text = "";
            txtVideoUrl.Text = "";
            txtOrder.Text = (int.Parse(txtOrder.Text) + 1).ToString();
            lblMessage.Text = "Lesson added!";
            lblMessage.ForeColor = System.Drawing.ColorTranslator.FromHtml("#10B981");

            LoadLessons();
        }

        protected void rptLessons_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteLesson")
            {
                int lessonId = int.Parse(e.CommandArgument.ToString());
                using (var db = new ApplicationDbContext())
                {
                    var lesson = db.Lessons.FirstOrDefault(l => l.Id == lessonId && l.CourseId == CourseId);
                    if (lesson != null)
                    {
                        db.Lessons.Remove(lesson);
                        db.SaveChanges();
                    }
                }
                LoadLessons();
            }
        }
    }
}
