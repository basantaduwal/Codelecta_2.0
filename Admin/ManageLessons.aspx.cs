using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Codelecta_2._0.Models;

namespace Codelecta_2._0.Admin
{
    public partial class ManageLessons : Page
    {
        public int CourseId
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
            if (!User.Identity.IsAuthenticated || !User.IsInRole("Admin"))
            {
                Response.Redirect("~/");
                return;
            }

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
            using (var db = new ApplicationDbContext())
            {
                var course = db.Courses.Find(CourseId);
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

                lblLessonCountHeader.Text = lessons.Count.ToString();
                lblTableCount.Text = lessons.Count.ToString();

                if (lessons.Count > 0)
                {
                    rptLessons.DataSource = lessons;
                    rptLessons.DataBind();
                    rptLessons.Visible = true;
                    pnlNoLessons.Visible = false;

                    // Pre-fill next order index if not editing
                    if (hfEditingLessonId.Value == "0")
                    {
                        txtOrder.Text = (lessons.Max(l => l.OrderIndex) + 1).ToString();
                    }
                }
                else
                {
                    rptLessons.Visible = false;
                    pnlNoLessons.Visible = true;
                    txtOrder.Text = "1";
                }
            }
        }

        protected void btnSaveLesson_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtLessonTitle.Text))
            {
                ShowMessage("Lesson title is required.", false);
                return;
            }

            int order = 1;
            int.TryParse(txtOrder.Text, out order);

            int lessonId = int.Parse(hfEditingLessonId.Value);

            using (var db = new ApplicationDbContext())
            {
                if (lessonId == 0)
                {
                    // Create Lesson
                    var lesson = new Lesson
                    {
                        CourseId = CourseId,
                        Title = txtLessonTitle.Text.Trim(),
                        Content = txtLessonContent.Text.Trim(),
                        VideoUrl = txtVideoUrl.Text.Trim(),
                        OrderIndex = order
                    };

                    db.Lessons.Add(lesson);
                    db.SaveChanges();
                    ShowMessage("✓ Lesson added successfully!", true);
                }
                else
                {
                    // Update Lesson
                    var existing = db.Lessons.FirstOrDefault(l => l.Id == lessonId && l.CourseId == CourseId);
                    if (existing != null)
                    {
                        existing.Title = txtLessonTitle.Text.Trim();
                        existing.Content = txtLessonContent.Text.Trim();
                        existing.VideoUrl = txtVideoUrl.Text.Trim();
                        existing.OrderIndex = order;
                        db.SaveChanges();
                        ShowMessage("✓ Lesson updated successfully!", true);
                    }
                }
            }

            ResetForm();
            LoadLessons();
        }

        protected void rptLessons_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int lessonId = int.Parse(e.CommandArgument.ToString());

            using (var db = new ApplicationDbContext())
            {
                if (e.CommandName == "EditLesson")
                {
                    var lesson = db.Lessons.FirstOrDefault(l => l.Id == lessonId && l.CourseId == CourseId);
                    if (lesson != null)
                    {
                        hfEditingLessonId.Value = lesson.Id.ToString();
                        txtLessonTitle.Text = lesson.Title;
                        txtLessonContent.Text = lesson.Content;
                        txtVideoUrl.Text = lesson.VideoUrl;
                        txtOrder.Text = lesson.OrderIndex.ToString();

                        lblFormHeading.Text = "Edit Lesson: " + lesson.Title;
                        btnSaveLesson.Text = "Save Changes";
                        btnCancelEdit.Visible = true;
                    }
                }
                else if (e.CommandName == "DeleteLesson")
                {
                    var lesson = db.Lessons.FirstOrDefault(l => l.Id == lessonId && l.CourseId == CourseId);
                    if (lesson != null)
                    {
                        // Remove progresses first
                        var progresses = db.LessonProgresses.Where(lp => lp.LessonId == lessonId).ToList();
                        db.LessonProgresses.RemoveRange(progresses);

                        db.Lessons.Remove(lesson);
                        db.SaveChanges();
                        ShowMessage("✓ Lesson deleted successfully.", true);
                    }
                    ResetForm();
                    LoadLessons();
                }
                else if (e.CommandName == "MoveUp")
                {
                    var allLessons = db.Lessons.Where(l => l.CourseId == CourseId).OrderBy(l => l.OrderIndex).ToList();
                    var current = allLessons.FirstOrDefault(l => l.Id == lessonId);
                    if (current != null)
                    {
                        int index = allLessons.IndexOf(current);
                        if (index > 0)
                        {
                            var previous = allLessons[index - 1];
                            int temp = current.OrderIndex;
                            current.OrderIndex = previous.OrderIndex;
                            previous.OrderIndex = temp;
                            db.SaveChanges();
                        }
                    }
                    LoadLessons();
                }
                else if (e.CommandName == "MoveDown")
                {
                    var allLessons = db.Lessons.Where(l => l.CourseId == CourseId).OrderBy(l => l.OrderIndex).ToList();
                    var current = allLessons.FirstOrDefault(l => l.Id == lessonId);
                    if (current != null)
                    {
                        int index = allLessons.IndexOf(current);
                        if (index < allLessons.Count - 1)
                        {
                            var next = allLessons[index + 1];
                            int temp = current.OrderIndex;
                            current.OrderIndex = next.OrderIndex;
                            next.OrderIndex = temp;
                            db.SaveChanges();
                        }
                    }
                    LoadLessons();
                }
            }
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            ResetForm();
            LoadLessons();
        }

        private void ResetForm()
        {
            hfEditingLessonId.Value = "0";
            txtLessonTitle.Text = "";
            txtLessonContent.Text = "";
            txtVideoUrl.Text = "";
            lblFormHeading.Text = "Add New Lesson";
            btnSaveLesson.Text = "Add Lesson";
            btnCancelEdit.Visible = false;
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblActionMessage.Text = message;
            pnlMessage.Visible = true;
            pnlMessage.Style["background"] = isSuccess ? "#ECFDF5" : "#FEF2F2";
            pnlMessage.Style["color"] = isSuccess ? "#065F46" : "#991B1B";
            pnlMessage.Style["border"] = isSuccess ? "1px solid #6EE7B7" : "1px solid #FECACA";
        }
    }
}
