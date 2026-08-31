using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using Microsoft.AspNet.Identity;
using Codelecta_2._0.Models;

namespace Codelecta_2._0
{
    public partial class ViewLesson : Page
    {
        public int CurrentLessonId { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("Account/Login.aspx");
                return;
            }

            CurrentLessonId = GetLessonId();

            if (!IsPostBack)
            {
                LoadLesson();
            }
        }

        private int GetLessonId()
        {
            int id;
            if (int.TryParse(Request.QueryString["id"], out id))
                return id;
            return 0;
        }

        private void LoadLesson()
        {
            int lessonId = GetLessonId();
            if (lessonId == 0)
            {
                Response.Redirect("Courses.aspx");
                return;
            }

            string userId = User.Identity.GetUserId();

            using (var db = new ApplicationDbContext())
            {
                var lesson = db.Lessons.FirstOrDefault(l => l.Id == lessonId);
                if (lesson == null)
                {
                    Response.Redirect("Courses.aspx");
                    return;
                }

                // Verify user is enrolled in this course
                bool isEnrolled = db.UserCourses.Any(uc => uc.UserId == userId && uc.CourseId == lesson.CourseId);
                if (!isEnrolled)
                {
                    Response.Redirect("CourseDetail.aspx?id=" + lesson.CourseId);
                    return;
                }

                // Set back link
                lnkBack.HRef = "CourseDetail.aspx?id=" + lesson.CourseId;

                // Display lesson info
                lblOrder.Text = lesson.OrderIndex.ToString();
                lblOrderSubtitle.Text = lesson.OrderIndex.ToString();
                lblTitle.Text = lesson.Title;
                litContent.Text = lesson.Content.Replace("\n", "<br />");

                // Handle video URL
                if (!string.IsNullOrEmpty(lesson.VideoUrl))
                {
                    pnlVideo.Visible = true;
                    string embedUrl = ConvertToEmbedUrl(lesson.VideoUrl);
                    videoFrame.Attributes["src"] = embedUrl;
                }
                else
                {
                    pnlVideo.Visible = false;
                }

                // Check if already completed
                bool isCompleted = db.LessonProgresses.Any(lp => lp.UserId == userId && lp.LessonId == lessonId && lp.IsCompleted);
                if (isCompleted)
                {
                    pnlBadgeCompleted.Visible = true;
                    pnlBadgeIncomplete.Visible = false;
                    btnMarkComplete.Visible = false;
                    btnMarkIncomplete.Visible = true;
                }
                else
                {
                    pnlBadgeCompleted.Visible = false;
                    pnlBadgeIncomplete.Visible = true;
                    btnMarkComplete.Visible = true;
                    btnMarkIncomplete.Visible = false;
                }

                // All course lessons for progress and quick list
                var allLessons = db.Lessons
                    .Where(l => l.CourseId == lesson.CourseId)
                    .OrderBy(l => l.OrderIndex)
                    .ToList();

                var completedLessonIds = new HashSet<int>(
                    db.LessonProgresses
                        .Where(lp => lp.UserId == userId && lp.IsCompleted)
                        .Select(lp => lp.LessonId)
                        .ToList()
                );

                int totalLessons = allLessons.Count;
                int completedCount = allLessons.Count(l => completedLessonIds.Contains(l.Id));
                int progressPercent = totalLessons > 0
                    ? (int)Math.Round(((double)completedCount / totalLessons) * 100)
                    : 0;

                lblCourseProgressPct.Text = progressPercent + "%";
                divProgressFill.Style["width"] = progressPercent + "%";

                // Previous lesson button
                var prevLesson = allLessons
                    .Where(l => l.OrderIndex < lesson.OrderIndex)
                    .OrderByDescending(l => l.OrderIndex)
                    .FirstOrDefault();

                if (prevLesson != null)
                {
                    lnkPrevLesson.NavigateUrl = "ViewLesson.aspx?id=" + prevLesson.Id;
                    lnkPrevLesson.Visible = true;
                }
                else
                {
                    lnkPrevLesson.Visible = false;
                }

                // Next lesson button
                var nextLesson = allLessons
                    .Where(l => l.OrderIndex > lesson.OrderIndex)
                    .OrderBy(l => l.OrderIndex)
                    .FirstOrDefault();

                if (nextLesson != null)
                {
                    lnkNextLesson.NavigateUrl = "ViewLesson.aspx?id=" + nextLesson.Id;
                    lnkNextLesson.Visible = true;
                    lnkFinishCourse.Visible = false;
                }
                else
                {
                    lnkNextLesson.Visible = false;
                    lnkFinishCourse.NavigateUrl = "Dashboard.aspx";
                    lnkFinishCourse.Visible = true;
                }

                // Bind other lessons list at the bottom
                var lessonViewModels = allLessons.Select(l => new
                {
                    Id = l.Id,
                    OrderIndex = l.OrderIndex,
                    Title = l.Title,
                    IsCompleted = completedLessonIds.Contains(l.Id)
                }).ToList();

                rptOtherLessons.DataSource = lessonViewModels;
                rptOtherLessons.DataBind();
            }
        }

        protected void btnMarkComplete_Click(object sender, EventArgs e)
        {
            int lessonId = GetLessonId();
            string userId = User.Identity.GetUserId();

            using (var db = new ApplicationDbContext())
            {
                var existing = db.LessonProgresses.FirstOrDefault(lp => lp.UserId == userId && lp.LessonId == lessonId);
                if (existing == null)
                {
                    var progress = new LessonProgress
                    {
                        UserId = userId,
                        LessonId = lessonId,
                        IsCompleted = true,
                        CompletedDate = DateTime.Now
                    };
                    db.LessonProgresses.Add(progress);
                }
                else
                {
                    existing.IsCompleted = true;
                    existing.CompletedDate = DateTime.Now;
                }
                db.SaveChanges();
            }

            // Reload page to reflect new state
            Response.Redirect("ViewLesson.aspx?id=" + lessonId);
        }

        protected void btnMarkIncomplete_Click(object sender, EventArgs e)
        {
            int lessonId = GetLessonId();
            string userId = User.Identity.GetUserId();

            using (var db = new ApplicationDbContext())
            {
                var existing = db.LessonProgresses.FirstOrDefault(lp => lp.UserId == userId && lp.LessonId == lessonId);
                if (existing != null)
                {
                    existing.IsCompleted = false;
                    existing.CompletedDate = null;
                    db.SaveChanges();
                }
            }

            // Reload page to reflect new state
            Response.Redirect("ViewLesson.aspx?id=" + lessonId);
        }

        private string ConvertToEmbedUrl(string url)
        {
            if (string.IsNullOrWhiteSpace(url)) return url;

            // Convert YouTube watch URL to embed URL
            if (url.Contains("youtube.com/watch"))
            {
                var uri = new Uri(url);
                var query = System.Web.HttpUtility.ParseQueryString(uri.Query);
                string videoId = query["v"];
                if (!string.IsNullOrEmpty(videoId))
                    return "https://www.youtube.com/embed/" + videoId;
            }
            else if (url.Contains("youtu.be/"))
            {
                string videoId = url.Split(new[] { "youtu.be/" }, StringSplitOptions.None).Last().Split('?')[0];
                return "https://www.youtube.com/embed/" + videoId;
            }
            return url;
        }
    }
}
