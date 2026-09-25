using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text.RegularExpressions;
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
                pnlLessonMain.Visible = false;
                pnlLessonError.Visible = true;
                lblErrorMessage.Text = "No lesson ID was provided. Please choose a course from the catalog to begin learning.";
                lnkErrorAction.HRef = "Courses.aspx";
                lnkErrorAction.InnerText = "← Browse All Courses";
                return;
            }

            string userId = User.Identity.GetUserId();

            using (var db = new ApplicationDbContext())
            {
                var lesson = db.Lessons
                    .Include(l => l.Course)
                    .FirstOrDefault(l => l.Id == lessonId);

                if (lesson == null)
                {
                    pnlLessonMain.Visible = false;
                    pnlLessonError.Visible = true;
                    lblErrorMessage.Text = "The requested lesson could not be found. It may have been relocated or updated.";
                    lnkErrorAction.HRef = "Courses.aspx";
                    lnkErrorAction.InnerText = "← Browse All Courses";
                    return;
                }

                // Verify user is enrolled in this course
                bool isEnrolled = db.UserCourses.Any(uc => uc.UserId == userId && uc.CourseId == lesson.CourseId);
                if (!isEnrolled)
                {
                    pnlLessonMain.Visible = false;
                    pnlLessonError.Visible = true;
                    string cTitle = lesson.Course != null ? Server.HtmlEncode(lesson.Course.Title) : "this course";
                    lblErrorMessage.Text = "You are not enrolled in <strong>" + cTitle + "</strong> yet. Enroll to access this structured lesson, code playground, and self-assessments.";
                    lnkErrorAction.HRef = "CourseDetail.aspx?id=" + lesson.CourseId;
                    lnkErrorAction.InnerText = "View Course & Enroll →";
                    return;
                }

                pnlLessonMain.Visible = true;
                pnlLessonError.Visible = false;

                // Set back link
                lnkBack.HRef = "CourseDetail.aspx?id=" + lesson.CourseId;

                // Display lesson info
                lblOrder.Text = lesson.OrderIndex.ToString();
                lblOrderSubtitle.Text = lesson.OrderIndex.ToString();
                lblTitle.Text = lesson.Title;
                litContent.Text = FormatLessonContent(lesson.Content);

                // Handle video URL and chapters
                string videoUrl = lesson.VideoUrl;
                if (string.IsNullOrWhiteSpace(videoUrl) && lesson.Course != null)
                {
                    videoUrl = GetDefaultVideoForCourse(lesson.Course.Title, lesson.Course.BadgeClass);
                }

                if (!string.IsNullOrWhiteSpace(videoUrl))
                {
                    pnlVideo.Visible = true;
                    string embedUrl = ConvertToEmbedUrl(videoUrl);
                    videoFrame.Attributes["src"] = embedUrl;

                    // Load & bind video chapters
                    var chapters = ParseOrGenerateChapters(lesson);
                    lblTotalChapters.Text = chapters.Count + " Chapters";
                    rptVideoChapters.DataSource = chapters;
                    rptVideoChapters.DataBind();
                    pnlChapters.Visible = true;
                }
                else
                {
                    pnlVideo.Visible = false;
                    pnlChapters.Visible = false;
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

            string videoId = null;
            if (url.Contains("youtube.com/watch"))
            {
                var uri = new Uri(url);
                var query = System.Web.HttpUtility.ParseQueryString(uri.Query);
                videoId = query["v"];
            }
            else if (url.Contains("youtu.be/"))
            {
                videoId = url.Split(new[] { "youtu.be/" }, StringSplitOptions.None).Last().Split('?')[0];
            }
            else if (url.Contains("youtube.com/embed/"))
            {
                videoId = url.Split(new[] { "youtube.com/embed/" }, StringSplitOptions.None).Last().Split('?')[0];
            }

            if (!string.IsNullOrEmpty(videoId))
            {
                return "https://www.youtube.com/embed/" + videoId + "?enablejsapi=1&rel=0";
            }

            return url;
        }

        private string GetDefaultVideoForCourse(string courseTitle, string badgeClass)
        {
            string search = ((courseTitle ?? "") + " " + (badgeClass ?? "")).ToLowerInvariant();

            if (search.Contains("python"))
                return "https://www.youtube.com/watch?v=_uQrJ0TkZlc";
            if (search.Contains("javascript") || search.Contains("js"))
                return "https://www.youtube.com/watch?v=W6NZfCO5SIk";
            if (search.Contains("csharp") || search.Contains("c#"))
                return "https://www.youtube.com/watch?v=gfkTfcpWqAY";
            if (search.Contains("react"))
                return "https://www.youtube.com/watch?v=bMknfKXIFA8";
            if (search.Contains("java"))
                return "https://www.youtube.com/watch?v=eIrMbAQSU34";
            if (search.Contains("html") || search.Contains("css") || search.Contains("web"))
                return "https://www.youtube.com/watch?v=kUMe1FH4CHE";
            if (search.Contains("dsa") || search.Contains("algorithm") || search.Contains("structure"))
                return "https://www.youtube.com/watch?v=8hly31xKli0";

            return "https://www.youtube.com/watch?v=zOjov-2OZ0E";
        }

        private string FormatLessonContent(string rawContent)
        {
            if (string.IsNullOrWhiteSpace(rawContent)) return "";

            string formatted = rawContent;

            // 1. Parse fenced code blocks ```csharp ... ``` or ``` ... ```
            formatted = Regex.Replace(formatted, @"```(?<lang>[a-zA-Z0-9#+]*)\r?\n(?<code>[\s\S]*?)```", m =>
            {
                string lang = m.Groups["lang"].Value.Trim();
                if (string.IsNullOrEmpty(lang)) lang = "Code";
                string code = System.Web.HttpUtility.HtmlEncode(m.Groups["code"].Value.Trim());
                return string.Format(
                    "<div class=\"lesson-code-block\"><div class=\"lesson-code-header\"><span class=\"lesson-code-lang\">{0}</span><button type=\"button\" class=\"lesson-copy-btn\" onclick=\"copyCodeSnippet(this)\">📋 Copy</button></div><pre><code class=\"language-{1}\">{2}</code></pre></div>",
                    lang.ToUpper(), lang.ToLower(), code);
            });

            // 2. Parse inline code `someCode`
            formatted = Regex.Replace(formatted, @"`([^`\n\r]+)`", m =>
            {
                return "<code class=\"inline-code\">" + System.Web.HttpUtility.HtmlEncode(m.Groups[1].Value) + "</code>";
            });

            // 3. Parse headers: ### Subheading and ## Section
            formatted = Regex.Replace(formatted, @"(?m)^###\s+(.+)$", "<h4 class=\"lesson-subheading\">$1</h4>");
            formatted = Regex.Replace(formatted, @"(?m)^##\s+(.+)$", "<h3 class=\"lesson-heading\">$1</h3>");

            // 4. Parse callouts / blockquotes: > Note: or > Important:
            formatted = Regex.Replace(formatted, @"(?m)^>\s*(?:<strong>)?(Note|Tip|Important|Warning|Best Practice)?:?\s*(?:</strong>)?\s*(.+)$",
                "<div class=\"lesson-callout\"><div class=\"callout-tag\">💡 $1</div><p class=\"callout-text\">$2</p></div>");

            // 5. Parse bullet points: - item or * item
            formatted = Regex.Replace(formatted, @"(?m)^[\-\*]\s+(.+)$", "<li class=\"lesson-bullet\">$1</li>");
            formatted = Regex.Replace(formatted, @"(<li class=""lesson-bullet"">[\s\S]*?</li>)+", "<ul class=\"lesson-list\">$0</ul>");

            // 6. Bold **text**
            formatted = Regex.Replace(formatted, @"\*\*([^*]+)\*\*", "<strong>$1</strong>");

            // 7. Line breaks outside of code blocks
            formatted = formatted.Replace("\r\n", "\n").Replace("\n", "<br />");
            formatted = Regex.Replace(formatted, @"(<br\s*/?>\s*)+(<(?:div|h3|h4|ul|pre|blockquote))", "$2");
            formatted = Regex.Replace(formatted, @"(</(?:div|h3|h4|ul|pre|blockquote)>)(\s*<br\s*/?>)+", "$1");

            return formatted;
        }

        private List<VideoChapterViewModel> ParseOrGenerateChapters(Lesson lesson)
        {
            var chapters = new List<VideoChapterViewModel>();

            // 1. Try parsing explicit timestamp lines from lesson.Content
            if (!string.IsNullOrWhiteSpace(lesson.Content))
            {
                var lines = lesson.Content.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                var regex = new Regex(@"(?:\[|\()?(?<time>\d{1,2}:\d{2})(?:\]|\))?\s*[-:]?\s*(?<title>.+)", RegexOptions.Compiled);

                int idx = 1;
                foreach (var line in lines)
                {
                    var match = regex.Match(line.Trim());
                    if (match.Success)
                    {
                        string timeStr = match.Groups["time"].Value;
                        string titleStr = match.Groups["title"].Value.Trim();
                        int seconds = ParseTimestampToSeconds(timeStr);

                        chapters.Add(new VideoChapterViewModel
                        {
                            Index = idx++,
                            Timestamp = timeStr,
                            Seconds = seconds,
                            Title = titleStr,
                            Description = "Jump to " + titleStr + " at " + timeStr
                        });
                    }
                }
            }

            // 2. If at least 2 explicit chapters were found, return them
            if (chapters.Count >= 2)
            {
                return chapters;
            }

            // 3. Otherwise, generate structured milestones tailored to this lesson
            string lTitle = !string.IsNullOrWhiteSpace(lesson.Title) ? lesson.Title : "Lesson Topic";
            return new List<VideoChapterViewModel>
            {
                new VideoChapterViewModel
                {
                    Index = 1,
                    Timestamp = "00:00",
                    Seconds = 0,
                    Title = "Introduction & Learning Roadmap",
                    Description = "Getting started, core objectives, and prerequisites for " + lTitle + "."
                },
                new VideoChapterViewModel
                {
                    Index = 2,
                    Timestamp = "02:15",
                    Seconds = 135,
                    Title = "Core Concepts & Syntax Fundamentals",
                    Description = "Deep dive into language syntax, data flow, and essential structure."
                },
                new VideoChapterViewModel
                {
                    Index = 3,
                    Timestamp = "05:40",
                    Seconds = 340,
                    Title = "Hands-on Code Walkthrough",
                    Description = "Real-world code demonstration, compiling logic, and output validation."
                },
                new VideoChapterViewModel
                {
                    Index = 4,
                    Timestamp = "08:50",
                    Seconds = 530,
                    Title = "Common Pitfalls & Best Practices",
                    Description = "Debugging guidelines, performance tips, and clean code principles."
                },
                new VideoChapterViewModel
                {
                    Index = 5,
                    Timestamp = "11:30",
                    Seconds = 690,
                    Title = "Summary & Key Takeaways",
                    Description = "Recap of essential concepts before moving to interactive practice."
                }
            };
        }

        private int ParseTimestampToSeconds(string timeStr)
        {
            try
            {
                var parts = timeStr.Split(':');
                if (parts.Length == 2)
                {
                    int m = int.Parse(parts[0]);
                    int s = int.Parse(parts[1]);
                    return (m * 60) + s;
                }
            }
            catch { }
            return 0;
        }
    }

    public class VideoChapterViewModel
    {
        public int    Index       { get; set; }
        public string Timestamp   { get; set; }
        public int    Seconds     { get; set; }
        public string Title       { get; set; }
        public string Description { get; set; }
    }
}

