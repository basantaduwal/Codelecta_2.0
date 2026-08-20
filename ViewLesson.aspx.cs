using System;
using System.Linq;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Codelecta_2._0.Models;

namespace Codelecta_2._0
{
    public partial class ViewLesson : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("Account/Login.aspx");
                return;
            }

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
                lblTitle.Text = lesson.Title;
                litContent.Text = lesson.Content.Replace("\n", "<br />");

                // Handle video URL
                if (!string.IsNullOrEmpty(lesson.VideoUrl))
                {
                    pnlVideo.Visible = true;
                    string embedUrl = ConvertToEmbedUrl(lesson.VideoUrl);
                    videoFrame.Attributes["src"] = embedUrl;
                }

                // Check if already completed
                bool isCompleted = db.LessonProgresses.Any(lp => lp.UserId == userId && lp.LessonId == lessonId && lp.IsCompleted);
                if (isCompleted)
                {
                    lblCompleted.Visible = true;
                    btnMarkComplete.Visible = false;
                }

                // Find next lesson
                var nextLesson = db.Lessons
                    .Where(l => l.CourseId == lesson.CourseId && l.OrderIndex > lesson.OrderIndex)
                    .OrderBy(l => l.OrderIndex)
                    .FirstOrDefault();

                if (nextLesson != null)
                {
                    lnkNextLesson.NavigateUrl = "ViewLesson.aspx?id=" + nextLesson.Id;
                    lnkNextLesson.Visible = true;
                }
                else
                {
                    lnkNextLesson.Visible = false;
                }
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

            // Reload
            Response.Redirect("ViewLesson.aspx?id=" + lessonId);
        }

        private string ConvertToEmbedUrl(string url)
        {
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
