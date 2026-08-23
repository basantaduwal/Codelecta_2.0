using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Security.Claims;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Codelecta_2._0.Models;

namespace Codelecta_2._0.Admin
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Server-side admin authorization
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            if (!User.IsInRole("Admin"))
            {
                Response.Redirect("~/");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboardStatistics();
            }
        }

        private void LoadDashboardStatistics()
        {
            string userId = User.Identity.GetUserId();

            using (var db = new ApplicationDbContext())
            {
                // 1. Admin Display Name
                var currentAdmin = db.Users.Find(userId);
                if (currentAdmin != null && !string.IsNullOrWhiteSpace(currentAdmin.FullName))
                {
                    lblAdminName.Text = currentAdmin.FullName;
                }
                else
                {
                    string name = User.Identity.GetUserName();
                    lblAdminName.Text = (!string.IsNullOrEmpty(name) && name.Contains("@")) ? name.Split('@')[0] : (name ?? "Administrator");
                }

                // 2. Statistics Cards
                int totalUsers = db.Users.Count();
                int totalCourses = db.Courses.Count();
                int totalEnrollments = db.UserCourses.Count();
                int totalLessons = db.Lessons.Count();

                lblTotalUsers.Text = totalUsers.ToString();
                lblTotalCourses.Text = totalCourses.ToString();
                lblTotalEnrollments.Text = totalEnrollments.ToString();
                lblActiveCourses.Text = totalCourses.ToString();
                lblTotalLessons.Text = totalLessons.ToString();

                // 3. Course Distribution Analytics
                int beginnerCount = db.Courses.Count(c => c.Level == "Beginner");
                int intermediateCount = db.Courses.Count(c => c.Level == "Intermediate");
                int professionalCount = db.Courses.Count(c => c.Level == "Professional");

                lblBeginnerCount.Text = beginnerCount.ToString();
                lblIntermediateCount.Text = intermediateCount.ToString();
                lblProfessionalCount.Text = professionalCount.ToString();

                if (totalCourses > 0)
                {
                    int begPct = (int)Math.Round((double)beginnerCount / totalCourses * 100);
                    int intPct = (int)Math.Round((double)intermediateCount / totalCourses * 100);
                    int proPct = (int)Math.Round((double)professionalCount / totalCourses * 100);

                    lblBeginnerPct.Text = begPct + "%";
                    lblIntermediatePct.Text = intPct + "%";
                    lblProfessionalPct.Text = proPct + "%";

                    barBeginner.Style["width"] = begPct + "%";
                    barIntermediate.Style["width"] = intPct + "%";
                    barProfessional.Style["width"] = proPct + "%";
                }

                // 4. Enrollment Overview Chart / Trend
                if (totalEnrollments > 0)
                {
                    pnlEnrollmentChart.Visible = true;
                    pnlEnrollmentEmpty.Visible = false;

                    // Group enrollments by course for visual representation
                    var enrollmentsByCourse = db.UserCourses
                        .GroupBy(uc => uc.Course.Title)
                        .Select(g => new { CourseName = g.Key, Count = g.Count() })
                        .OrderByDescending(x => x.Count)
                        .Take(5)
                        .ToList();

                    string barsHtml = "";
                    int maxCount = enrollmentsByCourse.Max(x => x.Count);
                    foreach (var item in enrollmentsByCourse)
                    {
                        int heightPx = maxCount > 0 ? (int)Math.Max(30, ((double)item.Count / maxCount) * 140) : 30;
                        barsHtml += $"<div style='flex: 1; display: flex; flex-direction: column; align-items: center; gap: 8px;'>" +
                                    $"  <span style='font-size: 0.8rem; font-weight: 800; color: var(--primary);'>{item.Count}</span>" +
                                    $"  <div style='width: 100%; height: {heightPx}px; background: var(--gradient-primary); border-radius: 6px;'></div>" +
                                    $"  <span style='font-size: 0.72rem; color: var(--text-secondary); max-width: 70px; text-align: center; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;'>{item.CourseName}</span>" +
                                    $"</div>";
                    }
                    litEnrollmentBars.Text = barsHtml;
                }
                else
                {
                    pnlEnrollmentChart.Visible = false;
                    pnlEnrollmentEmpty.Visible = true;
                }

                // 5. Recent Activity Feed (Built from real DB events)
                var activityList = new List<ActivityViewModel>();

                // User registrations
                var recentUsers = db.Users
                    .OrderByDescending(u => u.Id)
                    .Take(3)
                    .ToList();

                foreach (var u in recentUsers)
                {
                    string displayName = !string.IsNullOrEmpty(u.FullName) ? u.FullName : u.UserName;
                    activityList.Add(new ActivityViewModel
                    {
                        Icon = "<svg width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2.5'><path d='M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2'></path><circle cx='8.5' cy='7' r='4'></circle><line x1='20' y1='8' x2='20' y2='14'></line><line x1='23' y1='11' x2='17' y2='11'></line></svg>",
                        Title = $"New user registered: {displayName}",
                        Subtitle = u.Email,
                        TimeAgo = "Registered"
                    });
                }

                // Recent Courses created
                var recentCourses = db.Courses
                    .OrderByDescending(c => c.CreatedDate)
                    .Take(2)
                    .ToList();

                foreach (var c in recentCourses)
                {
                    activityList.Add(new ActivityViewModel
                    {
                        Icon = "<svg width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2.5'><path d='M4 19.5A2.5 2.5 0 0 1 6.5 17H20'></path><path d='M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z'></path></svg>",
                        Title = $"Course published: {c.Title}",
                        Subtitle = $"{c.Level} level · {c.Lessons?.Count ?? 0} lessons",
                        TimeAgo = c.CreatedDate.ToString("MMM dd, yyyy")
                    });
                }

                if (activityList.Count > 0)
                {
                    rptRecentActivity.DataSource = activityList;
                    rptRecentActivity.DataBind();
                    rptRecentActivity.Visible = true;
                    pnlNoActivity.Visible = false;
                }
                else
                {
                    rptRecentActivity.Visible = false;
                    pnlNoActivity.Visible = true;
                }

                // 6. Recent Enrollments Table
                var enrollments = db.UserCourses
                    .Include(uc => uc.User)
                    .Include(uc => uc.Course)
                    .OrderByDescending(uc => uc.EnrollmentDate)
                    .Take(6)
                    .ToList();

                if (enrollments.Count > 0)
                {
                    var enrollmentVms = enrollments.Select(e => new EnrollmentViewModel
                    {
                        Id = e.Id,
                        CourseId = e.CourseId,
                        StudentName = !string.IsNullOrEmpty(e.User.FullName) ? e.User.FullName : e.User.UserName,
                        StudentEmail = e.User.Email,
                        CourseTitle = e.Course.Title,
                        Level = e.Course.Level ?? "Beginner",
                        EnrolledDateFormatted = e.EnrollmentDate.ToString("MMM dd, yyyy")
                    }).ToList();

                    rptRecentEnrollments.DataSource = enrollmentVms;
                    rptRecentEnrollments.DataBind();
                    rptRecentEnrollments.Visible = true;
                    pnlNoEnrollments.Visible = false;
                }
                else
                {
                    rptRecentEnrollments.Visible = false;
                    pnlNoEnrollments.Visible = true;
                }

                // 7. Course Overview Table
                var courses = db.Courses
                    .Include(c => c.Lessons)
                    .OrderBy(c => c.Id)
                    .ToList();

                if (courses.Count > 0)
                {
                    var courseVms = courses.Select(c => new AdminCourseViewModel
                    {
                        Id = c.Id,
                        Title = c.Title,
                        Description = c.Description,
                        Level = c.Level ?? "Beginner",
                        ImageTag = c.ImageTag ?? "📚",
                        BadgeClass = c.BadgeClass ?? "default-badge",
                        LessonCount = c.Lessons != null ? c.Lessons.Count : 0
                    }).ToList();

                    rptCoursesOverview.DataSource = courseVms;
                    rptCoursesOverview.DataBind();
                    rptCoursesOverview.Visible = true;
                    pnlNoCourses.Visible = false;
                }
                else
                {
                    rptCoursesOverview.Visible = false;
                    pnlNoCourses.Visible = true;
                }
            }
        }
    }

    // ─── View Models for Admin Dashboard ───────────────────────────

    public class ActivityViewModel
    {
        public string Icon { get; set; }
        public string Title { get; set; }
        public string Subtitle { get; set; }
        public string TimeAgo { get; set; }
    }

    public class EnrollmentViewModel
    {
        public int Id { get; set; }
        public int CourseId { get; set; }
        public string StudentName { get; set; }
        public string StudentEmail { get; set; }
        public string CourseTitle { get; set; }
        public string Level { get; set; }
        public string EnrolledDateFormatted { get; set; }
    }

    public class AdminCourseViewModel
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Level { get; set; }
        public string ImageTag { get; set; }
        public string BadgeClass { get; set; }
        public int LessonCount { get; set; }
    }
}
