using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Codelecta_2._0.Models;

namespace Codelecta_2._0
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTopCourses();
                DataBind();
            }
        }

        public string GetDashboardUrl()
        {
            if (User != null && User.IsInRole("Admin"))
            {
                return ResolveUrl("~/Admin/Dashboard");
            }
            return ResolveUrl("~/Dashboard");
        }

        private void LoadTopCourses()
        {
            try
            {
                using (var db = new ApplicationDbContext())
                {
                    var courses = db.Courses
                        .Include(c => c.Lessons)
                        .Include(c => c.Enrollments)
                        .OrderByDescending(c => c.Enrollments.Count)
                        .ThenByDescending(c => c.CreatedDate)
                        .Take(4)
                        .ToList();

                    if (courses != null && courses.Count > 0)
                    {
                        var viewModels = courses.Select(c => new CourseViewModel
                        {
                            Id          = c.Id,
                            Title       = c.Title,
                            Description = c.Description,
                            Level       = c.Level ?? "Beginner",
                            ImageTag    = c.ImageTag ?? "📚",
                            BadgeClass  = c.BadgeClass ?? "default-badge",
                            LessonCount = c.Lessons != null ? c.Lessons.Count : 0
                        }).ToList();

                        rptTopCourses.DataSource = viewModels;
                        rptTopCourses.DataBind();
                        rptTopCourses.Visible = true;
                        pnlFallbackCourses.Visible = false;
                        return;
                    }
                }
            }
            catch
            {
                // Fallback handled below if DB connection has temporary issue
            }

            rptTopCourses.Visible = false;
            pnlFallbackCourses.Visible = true;
        }
    }
}