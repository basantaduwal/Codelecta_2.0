using System;
using System.Collections.Generic;
using System.Data.Entity;
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
                        }
                    }
                }
                LoadCourses();
            }
        }

        protected void FilterLevel_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            string level = btn.CommandArgument;
            hfCurrentFilter.Value = level;
            SetActiveFilterPill(level);
            pnlRecommendBanner.Visible = false;
            LoadCourses();
        }

        protected void ShowAll_Click(object sender, EventArgs e)
        {
            hfCurrentFilter.Value = "All";
            SetActiveFilterPill("All");
            pnlRecommendBanner.Visible = false;
            LoadCourses();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadCourses();
        }

        protected void btnResetSearch_Click(object sender, EventArgs e)
        {
            txtCourseSearch.Text = "";
            ddlSort.SelectedValue = "popular";
            hfCurrentFilter.Value = "All";
            SetActiveFilterPill("All");
            pnlRecommendBanner.Visible = false;
            LoadCourses();
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadCourses();
        }

        // ─── Main Course Loader ───────────────────────────────────────────────

        private void LoadCourses()
        {
            string levelFilter = hfCurrentFilter.Value;
            string searchTerm = txtCourseSearch.Text.Trim().ToLower();
            string sortOption = ddlSort.SelectedValue;
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

                // Update Hero Summary Stats dynamically
                int allCoursesCount = db.Courses.Count();
                int allLessonsCount = db.Lessons.Count();
                lblTotalCoursesStat.Text = allCoursesCount.ToString();
                lblTotalLessonsStat.Text = allLessonsCount > 0 ? allLessonsCount.ToString() : "0";

                var query = db.Courses.Include(c => c.Lessons).Include(c => c.Enrollments).AsQueryable();

                // Apply Level Filter
                if (levelFilter != "All" && !string.IsNullOrEmpty(levelFilter))
                {
                    query = query.Where(c => c.Level == levelFilter);
                }

                // Apply Keyword Search Filter
                if (!string.IsNullOrEmpty(searchTerm))
                {
                    query = query.Where(c => c.Title.ToLower().Contains(searchTerm) || 
                                             c.Description.ToLower().Contains(searchTerm) ||
                                             c.Level.ToLower().Contains(searchTerm));
                }

                var list = query.ToList();

                // Apply Sorting
                IEnumerable<Course> sortedList;
                switch (sortOption)
                {
                    case "alpha":
                        sortedList = list.OrderBy(c => c.Title);
                        break;
                    case "newest":
                        sortedList = list.OrderByDescending(c => c.CreatedDate);
                        break;
                    case "lessons":
                        sortedList = list.OrderByDescending(c => c.Lessons != null ? c.Lessons.Count : 0);
                        break;
                    case "popular":
                    default:
                        sortedList = list.OrderByDescending(c => c.Enrollments != null ? c.Enrollments.Count : 0);
                        break;
                }

                var viewModels = sortedList.Select(c => new CourseViewModel
                {
                    Id          = c.Id,
                    Title       = c.Title,
                    Description = c.Description,
                    Level       = c.Level ?? "Beginner",
                    ImageTag    = c.ImageTag ?? "📚",
                    BadgeClass  = c.BadgeClass ?? "default-badge",
                    LessonCount = c.Lessons != null ? c.Lessons.Count : 0,
                    IsEnrolled  = enrolledIds.Contains(c.Id)
                }).ToList();

                // Update results count label
                lblCount.Text = viewModels.Count.ToString();
                lblCountPlural.Text = viewModels.Count == 1 ? "" : "s";
                lblFilterLabel.Text = (levelFilter == "All" || string.IsNullOrEmpty(levelFilter))
                    ? "" : $" — {levelFilter} level";

                if (viewModels.Count > 0)
                {
                    rptCourses.DataSource = viewModels;
                    rptCourses.DataBind();
                    rptCourses.Visible = true;
                    pnlEmptyState.Visible = false;
                }
                else
                {
                    rptCourses.Visible = false;
                    pnlEmptyState.Visible = true;
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
