using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Codelecta_2._0.Models;

namespace Codelecta_2._0
{
    public partial class CourseDetail : Page
    {
        public bool IsEnrolled   { get; private set; }
        public int  ProgressPct  { get; private set; }

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
            return int.TryParse(Request.QueryString["id"], out id) ? id : 0;
        }

        private void LoadCourse()
        {
            int courseId = GetCourseId();
            if (courseId == 0)
            {
                Response.Redirect("Courses");
                return;
            }

            string userId = User.Identity.IsAuthenticated ? User.Identity.GetUserId() : null;

            using (var db = new ApplicationDbContext())
            {
                var course = db.Courses.FirstOrDefault(c => c.Id == courseId);
                if (course == null)
                {
                    Response.Redirect("Courses");
                    return;
                }

                // ── Populate header ───────────────────────────────────────
                Page.Title = course.Title + " — Codelecta";
                lblTitle.Text       = course.Title;
                lblDescription.Text = course.Description;
                litBadgeClass.Text  = course.BadgeClass ?? "default-badge";
                litImageTag.Text    = course.ImageTag ?? "📚";

                // Level pill with colour class
                string lvl = course.Level ?? "Beginner";
                lblLevel.Text     = lvl;
                lblLevel.CssClass = "detail-level-pill level-" + lvl.ToLower();

                // ── Load lessons ──────────────────────────────────────────
                var lessons = db.Lessons
                    .Where(l => l.CourseId == courseId)
                    .OrderBy(l => l.OrderIndex)
                    .ToList();

                lblLessonCount.Text  = lessons.Count.ToString();
                lblLessonCount2.Text = lessons.Count.ToString();

                // ── Enrollment & Progress ─────────────────────────────────
                if (userId != null)
                {
                    IsEnrolled = db.UserCourses.Any(uc => uc.UserId == userId && uc.CourseId == courseId);

                    if (IsEnrolled)
                    {
                        enrolledBadge.Visible = true;

                        // Compute progress
                        var completedIds = new HashSet<int>(
                            db.LessonProgresses
                              .Where(lp => lp.UserId == userId && lp.IsCompleted)
                              .Select(lp => lp.LessonId)
                              .ToList()
                        );

                        int total = lessons.Count;
                        int done  = lessons.Count(l => completedIds.Contains(l.Id));
                        ProgressPct = total > 0 ? (int)Math.Round((double)done / total * 100) : 0;

                        lblProgressPct.Text = ProgressPct + "%";
                        pnlProgress.Visible = true;
                        pnlContinue.Visible = true;
                        pnlEnroll.Visible   = false;

                        // Find next uncompleted lesson for "Continue" button
                        var nextLesson = lessons.FirstOrDefault(l => !completedIds.Contains(l.Id))
                                         ?? lessons.FirstOrDefault();
                        if (nextLesson != null)
                            aStartLesson.HRef = "ViewLesson.aspx?id=" + nextLesson.Id;

                        // Build lesson view models with completion state
                        rptLessons.DataSource = lessons.Select(l => new LessonRowViewModel
                        {
                            Id          = l.Id,
                            Title       = l.Title,
                            OrderIndex  = l.OrderIndex,
                            IsCompleted = completedIds.Contains(l.Id)
                        }).ToList();
                    }
                    else
                    {
                        pnlEnroll.Visible = true;
                        rptLessons.DataSource = lessons.Select(l => new LessonRowViewModel
                        {
                            Id          = l.Id,
                            Title       = l.Title,
                            OrderIndex  = l.OrderIndex,
                            IsCompleted = false
                        }).ToList();
                    }
                }
                else
                {
                    pnlLoginPrompt.Visible = true;
                    rptLessons.DataSource = lessons.Select(l => new LessonRowViewModel
                    {
                        Id          = l.Id,
                        Title       = l.Title,
                        OrderIndex  = l.OrderIndex,
                        IsCompleted = false
                    }).ToList();
                }

                if (lessons.Count > 0)
                {
                    rptLessons.DataBind();
                    rptLessons.Visible   = true;
                    lblNoLessons.Visible = false;
                }
                else
                {
                    rptLessons.Visible   = false;
                    lblNoLessons.Visible = true;
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
                bool alreadyEnrolled = db.UserCourses.Any(uc => uc.UserId == userId && uc.CourseId == courseId);
                if (!alreadyEnrolled)
                {
                    db.UserCourses.Add(new UserCourse
                    {
                        UserId         = userId,
                        CourseId       = courseId,
                        EnrollmentDate = DateTime.Now
                    });
                    db.SaveChanges();
                }
            }

            Response.Redirect("CourseDetail.aspx?id=" + courseId);
        }
    }

    // ─── Lesson Row View Model ────────────────────────────────────────────────
    public class LessonRowViewModel
    {
        public int    Id          { get; set; }
        public string Title       { get; set; }
        public int    OrderIndex  { get; set; }
        public bool   IsCompleted { get; set; }
    }
}
