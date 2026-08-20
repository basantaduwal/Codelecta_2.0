using System;
using System.Linq;
using System.Web.UI;
using Codelecta_2._0.Models;

namespace Codelecta_2._0
{
    public partial class Courses : Page
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
            using (var db = new ApplicationDbContext())
            {
                var courses = db.Courses
                    .Select(c => new
                    {
                        c.Id,
                        c.Title,
                        c.Description,
                        LessonCount = c.Lessons.Count()
                    })
                    .OrderByDescending(c => c.Id)
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
    }
}
