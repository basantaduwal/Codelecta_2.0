using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Codelecta_2._0.Models;

namespace Codelecta_2._0
{
    public partial class Courses : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // On first load: if user has an experience level set, default to showing their level
                if (User.Identity.IsAuthenticated)
                {
                    string userId = User.Identity.GetUserId();
                    using (var db = new ApplicationDbContext())
                    {
                        var user = db.Users.Find(userId) as ApplicationUser;
                        if (user != null && !string.IsNullOrEmpty(user.ExperienceLevel))
                        {
                            hfCurrentFilter.Value = user.ExperienceLevel;
                            SetActiveFilterPill(user.ExperienceLevel);
                            pnlRecommendBanner.Visible = true;
                            lblUserLevel.Text = user.ExperienceLevel;
                            // Show the "View all" banner since we are pre-filtering
                        }
                    }
                }
                LoadCourses(hfCurrentFilter.Value);
            }
        }

        protected void FilterLevel_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            string level = btn.CommandArgument;
            hfCurrentFilter.Value = level;
            SetActiveFilterPill(level);
            pnlRecommendBanner.Visible = false;
            LoadCourses(level);
        }

        protected void ShowAll_Click(object sender, EventArgs e)
        {
            hfCurrentFilter.Value = "All";
            SetActiveFilterPill("All");
            pnlRecommendBanner.Visible = false;
            LoadCourses("All");
        }

        // ─── Helpers ─────────────────────────────────────────────────────────

        private void LoadCourses(string levelFilter)
        {
            string userId = User.Identity.IsAuthenticated ? User.Identity.GetUserId() : null;

            using (var db = new ApplicationDbContext())
            {
                // Enrolled course IDs for this user
                var enrolledIds = new HashSet<int>();
                if (userId != null)
                {
                    enrolledIds = new HashSet<int>(
                        db.UserCourses.Where(uc => uc.UserId == userId).Select(uc => uc.CourseId).ToList()
                    );
                }

                var query = db.Courses.AsQueryable();
                if (levelFilter != "All" && !string.IsNullOrEmpty(levelFilter))
                    query = query.Where(c => c.Level == levelFilter);

                var courses = query
                    .Select(c => new
                    {
                        c.Id,
                        c.Title,
                        c.Description,
                        c.Level,
                        c.ImageTag,
                        c.BadgeClass,
                        LessonCount = c.Lessons.Count()
                    })
                    .OrderBy(c => c.Id)
                    .ToList()
                    .Select(c => new CourseViewModel
                    {
                        Id          = c.Id,
                        Title       = c.Title,
                        Description = c.Description,
                        Level       = c.Level ?? "Beginner",
                        ImageTag    = c.ImageTag ?? "📚",
                        BadgeClass  = c.BadgeClass ?? "default-badge",
                        LessonCount = c.LessonCount,
                        IsEnrolled  = enrolledIds.Contains(c.Id)
                    })
                    .ToList();

                // Update results label
                lblCount.Text = courses.Count.ToString();
                lblCountPlural.Text = courses.Count == 1 ? "" : "s";
                lblFilterLabel.Text = (levelFilter == "All" || string.IsNullOrEmpty(levelFilter))
                    ? "" : $" — {levelFilter} level";

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

        private void SetActiveFilterPill(string level)
        {
            btnAll.CssClass          = "filter-pill";
            btnBeginner.CssClass     = "filter-pill";
            btnIntermediate.CssClass = "filter-pill";
            btnProfessional.CssClass = "filter-pill";

            switch (level)
            {
                case "Beginner":     btnBeginner.CssClass     += " filter-pill-active"; break;
                case "Intermediate": btnIntermediate.CssClass += " filter-pill-active"; break;
                case "Professional": btnProfessional.CssClass += " filter-pill-active"; break;
                default:             btnAll.CssClass          += " filter-pill-active"; break;
            }
        }
    }

    // ─── View Model ──────────────────────────────────────────────────────────

    public class CourseViewModel
    {
        public int    Id          { get; set; }
        public string Title       { get; set; }
        public string Description { get; set; }
        public string Level       { get; set; }
        public string ImageTag    { get; set; }
        public string BadgeClass  { get; set; }
        public int    LessonCount { get; set; }
        public bool   IsEnrolled  { get; set; }
    }
}
