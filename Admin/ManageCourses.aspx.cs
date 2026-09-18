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
    public partial class ManageCourses : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated || !User.IsInRole("Admin"))
            {
                Response.Redirect("~/");
                return;
            }

            if (!IsPostBack)
            {
                LoadStats();
                LoadCourses();
            }
        }

        private void LoadStats()
        {
            using (var db = new ApplicationDbContext())
            {
                lblTotalCourses.Text = db.Courses.Count().ToString();
                lblTotalLessons.Text = db.Lessons.Count().ToString();
                lblTotalEnrollments.Text = db.UserCourses.Count().ToString();
            }
        }

        private void LoadCourses()
        {
            using (var db = new ApplicationDbContext())
            {
                var courses = db.Courses
                    .Include(c => c.Lessons)
                    .Include(c => c.Enrollments)
                    .OrderByDescending(c => c.CreatedDate)
                    .ToList()
                    .Select(c => new
                    {
                        Id = c.Id,
                        Title = c.Title,
                        Description = !string.IsNullOrWhiteSpace(c.Description) ? c.Description : "No description provided.",
                        Level = c.Level ?? "Beginner",
                        ImageTag = !string.IsNullOrWhiteSpace(c.ImageTag) ? c.ImageTag : "📚",
                        BadgeClass = c.BadgeClass ?? "csharp-badge",
                        CreatedDate = c.CreatedDate,
                        LessonCount = c.Lessons != null ? c.Lessons.Count : 0,
                        EnrollmentCount = c.Enrollments != null ? c.Enrollments.Count : 0
                    })
                    .ToList();

                lblCourseCount.Text = courses.Count.ToString();

                if (courses.Count > 0)
                {
                    rptCourses.DataSource = courses;
                    rptCourses.DataBind();
                    rptCourses.Visible = true;
                    pnlNoCourses.Visible = false;
                }
                else
                {
                    rptCourses.Visible = false;
                    pnlNoCourses.Visible = true;
                }
            }
        }

        protected void btnSaveCourse_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtCourseTitle.Text))
            {
                ShowMessage("Course title is required.", false);
                return;
            }

            int courseId = int.Parse(hfEditingCourseId.Value);

            using (var db = new ApplicationDbContext())
            {
                if (courseId == 0)
                {
                    // Create New Course
                    var course = new Course
                    {
                        Title = txtCourseTitle.Text.Trim(),
                        Description = txtCourseDescription.Text.Trim(),
                        Level = ddlCourseLevel.SelectedValue,
                        ImageTag = !string.IsNullOrWhiteSpace(txtImageTag.Text) ? txtImageTag.Text.Trim() : "📚",
                        BadgeClass = ddlBadgeClass.SelectedValue,
                        CreatedDate = DateTime.Now,
                        InstructorId = User.Identity.GetUserId()
                    };

                    db.Courses.Add(course);
                    db.SaveChanges();
                    ShowMessage("✓ Course created successfully!", true);
                }
                else
                {
                    // Update Existing Course
                    var existing = db.Courses.Find(courseId);
                    if (existing != null)
                    {
                        existing.Title = txtCourseTitle.Text.Trim();
                        existing.Description = txtCourseDescription.Text.Trim();
                        existing.Level = ddlCourseLevel.SelectedValue;
                        existing.ImageTag = !string.IsNullOrWhiteSpace(txtImageTag.Text) ? txtImageTag.Text.Trim() : "📚";
                        existing.BadgeClass = ddlBadgeClass.SelectedValue;
                        db.SaveChanges();
                        ShowMessage("✓ Course updated successfully!", true);
                    }
                }
            }

            ResetForm();
            LoadStats();
            LoadCourses();
        }

        protected void rptCourses_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int courseId = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "EditCourse")
            {
                using (var db = new ApplicationDbContext())
                {
                    var course = db.Courses.Find(courseId);
                    if (course != null)
                    {
                        hfEditingCourseId.Value = course.Id.ToString();
                        txtCourseTitle.Text = course.Title;
                        txtCourseDescription.Text = course.Description;
                        txtImageTag.Text = course.ImageTag;

                        if (ddlCourseLevel.Items.FindByValue(course.Level) != null)
                            ddlCourseLevel.SelectedValue = course.Level;

                        if (ddlBadgeClass.Items.FindByValue(course.BadgeClass) != null)
                            ddlBadgeClass.SelectedValue = course.BadgeClass;

                        lblFormTitle.Text = "Edit Course: " + course.Title;
                        btnSaveCourse.Text = "Save Changes";
                        btnCancelEdit.Visible = true;
                    }
                }
            }
            else if (e.CommandName == "DeleteCourse")
            {
                using (var db = new ApplicationDbContext())
                {
                    var course = db.Courses
                        .Include(c => c.Lessons)
                        .Include(c => c.Enrollments)
                        .Include(c => c.Quizzes)
                        .FirstOrDefault(c => c.Id == courseId);

                    if (course != null)
                    {
                        // Clean up dependent child entities
                        if (course.Quizzes != null && course.Quizzes.Count > 0)
                        {
                            foreach (var q in course.Quizzes.ToList())
                            {
                                var questions = db.QuizQuestions.Where(qq => qq.QuizId == q.Id).ToList();
                                var attempts = db.QuizAttempts.Where(qa => qa.QuizId == q.Id).ToList();
                                db.QuizQuestions.RemoveRange(questions);
                                db.QuizAttempts.RemoveRange(attempts);
                                db.Quizzes.Remove(q);
                            }
                        }

                        if (course.Lessons != null && course.Lessons.Count > 0)
                        {
                            foreach (var l in course.Lessons.ToList())
                            {
                                var progresses = db.LessonProgresses.Where(lp => lp.LessonId == l.Id).ToList();
                                db.LessonProgresses.RemoveRange(progresses);
                                db.Lessons.Remove(l);
                            }
                        }

                        if (course.Enrollments != null && course.Enrollments.Count > 0)
                        {
                            db.UserCourses.RemoveRange(course.Enrollments);
                        }

                        db.Courses.Remove(course);
                        db.SaveChanges();
                        ShowMessage("✓ Course and associated records deleted successfully.", true);
                    }
                }

                ResetForm();
                LoadStats();
                LoadCourses();
            }
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            ResetForm();
        }

        private void ResetForm()
        {
            hfEditingCourseId.Value = "0";
            txtCourseTitle.Text = "";
            txtCourseDescription.Text = "";
            txtImageTag.Text = "C#";
            ddlCourseLevel.SelectedValue = "Beginner";
            ddlBadgeClass.SelectedValue = "csharp-badge";
            lblFormTitle.Text = "Create New Course";
            btnSaveCourse.Text = "Create Course";
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
