using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Codelecta_2._0.Models;

namespace Codelecta_2._0.Admin
{
    public partial class ManageQuizzes : Page
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
                LoadCoursesDropdown();
                LoadStats();
                BindQuizzes();
            }
        }

        private void LoadCoursesDropdown()
        {
            using (var db = new ApplicationDbContext())
            {
                var courses = db.Courses.OrderBy(c => c.Title).ToList();
                ddlCourses.DataSource = courses;
                ddlCourses.DataTextField = "Title";
                ddlCourses.DataValueField = "Id";
                ddlCourses.DataBind();

                if (courses.Count == 0)
                {
                    ddlCourses.Items.Add(new ListItem("No courses found", "0"));
                    btnCreateQuiz.Enabled = false;
                }
            }
        }

        private void LoadStats()
        {
            using (var db = new ApplicationDbContext())
            {
                int totalQuizzes = db.Quizzes.Count();
                int totalQuestions = db.QuizQuestions.Count();
                int totalAttempts = db.QuizAttempts.Count();
                int passedAttempts = db.QuizAttempts.Count(a => a.IsPassed);

                lblTotalQuizzes.Text = totalQuizzes.ToString();
                lblTotalQuestions.Text = totalQuestions.ToString();
                lblTotalAttempts.Text = totalAttempts.ToString();

                int passRate = totalAttempts > 0 ? (int)Math.Round(((double)passedAttempts / totalAttempts) * 100) : 0;
                lblPassRate.Text = passRate + "%";
            }
        }

        private void BindQuizzes()
        {
            using (var db = new ApplicationDbContext())
            {
                var quizzes = db.Quizzes
                    .Include(q => q.Course)
                    .Include(q => q.Questions)
                    .Include(q => q.Attempts)
                    .OrderByDescending(q => q.CreatedDate)
                    .ToList()
                    .Select(q => new
                    {
                        Id = q.Id,
                        Title = q.Title,
                        Description = !string.IsNullOrWhiteSpace(q.Description) ? q.Description : "No description provided.",
                        CourseTitle = q.Course != null ? q.Course.Title : "Unknown",
                        PassingScorePercent = q.PassingScorePercent,
                        QuestionCount = q.Questions != null ? q.Questions.Count : 0,
                        AttemptCount = q.Attempts != null ? q.Attempts.Count : 0
                    })
                    .ToList();

                lblQuizCount.Text = quizzes.Count.ToString();

                if (quizzes.Count > 0)
                {
                    rptQuizzes.DataSource = quizzes;
                    rptQuizzes.DataBind();
                    rptQuizzes.Visible = true;
                    pnlNoQuizzes.Visible = false;
                }
                else
                {
                    rptQuizzes.Visible = false;
                    pnlNoQuizzes.Visible = true;
                }
            }
        }

        protected void btnCreateQuiz_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtQuizTitle.Text))
            {
                ShowMessage("Please enter a quiz title.", false);
                return;
            }

            int courseId = int.Parse(ddlCourses.SelectedValue);
            int passingScore = 70;
            int.TryParse(txtPassingScore.Text, out passingScore);

            using (var db = new ApplicationDbContext())
            {
                var quiz = new Quiz
                {
                    CourseId = courseId,
                    Title = txtQuizTitle.Text.Trim(),
                    Description = txtQuizDescription.Text.Trim(),
                    PassingScorePercent = passingScore,
                    CreatedDate = DateTime.Now
                };

                db.Quizzes.Add(quiz);
                db.SaveChanges();

                // Add default seed questions for immediate usability
                AddDefaultQuestions(db, quiz.Id, quiz.Title);
            }

            txtQuizTitle.Text = "";
            txtQuizDescription.Text = "";
            ShowMessage("✓ Quiz created successfully with 3 default assessment questions!", true);

            LoadStats();
            BindQuizzes();
        }

        private void AddDefaultQuestions(ApplicationDbContext db, int quizId, string quizTitle)
        {
            var q1 = new QuizQuestion
            {
                QuizId = quizId,
                OrderIndex = 1,
                QuestionText = "What is the primary purpose of a variable in programming?",
                OptionA = "To store data that can be used and manipulated",
                OptionB = "To connect to a database",
                OptionC = "To compile machine code",
                OptionD = "To design visual UI components",
                CorrectOption = "A",
                Explanation = "Variables are storage locations in memory used to hold data during program execution."
            };

            var q2 = new QuizQuestion
            {
                QuizId = quizId,
                OrderIndex = 2,
                QuestionText = "Which conditional statement is used to execute code only if a specified condition evaluates to true?",
                OptionA = "loop",
                OptionB = "if",
                OptionC = "class",
                OptionD = "import",
                CorrectOption = "B",
                Explanation = "The 'if' statement evaluates a boolean expression and executes its code block if true."
            };

            var q3 = new QuizQuestion
            {
                QuizId = quizId,
                OrderIndex = 3,
                QuestionText = "What does DRY stand for in software engineering?",
                OptionA = "Do Repeat Yourself",
                OptionB = "Don't Repeat Yourself",
                OptionC = "Data Redundancy Yield",
                OptionD = "Dynamic Runtime Yield",
                CorrectOption = "B",
                Explanation = "DRY stands for Don't Repeat Yourself, aiming to reduce repetition of software patterns."
            };

            db.QuizQuestions.Add(q1);
            db.QuizQuestions.Add(q2);
            db.QuizQuestions.Add(q3);
            db.SaveChanges();
        }

        protected void rptQuizzes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteQuiz")
            {
                int quizId = int.Parse(e.CommandArgument.ToString());
                using (var db = new ApplicationDbContext())
                {
                    var quiz = db.Quizzes.Include(q => q.Questions).Include(q => q.Attempts).FirstOrDefault(q => q.Id == quizId);
                    if (quiz != null)
                    {
                        db.QuizQuestions.RemoveRange(quiz.Questions);
                        db.QuizAttempts.RemoveRange(quiz.Attempts);
                        db.Quizzes.Remove(quiz);
                        db.SaveChanges();
                        ShowMessage("✓ Quiz deleted successfully.", true);
                    }
                }

                LoadStats();
                BindQuizzes();
            }
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
