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
    public partial class TakeQuiz : Page
    {
        private int QuizId
        {
            get
            {
                int id;
                if (int.TryParse(Request.QueryString["quizId"], out id))
                    return id;
                return 0;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("Account/Login.aspx");
                return;
            }

            if (QuizId == 0)
            {
                Response.Redirect("Courses.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadQuizData();
            }
        }

        private void LoadQuizData()
        {
            using (var db = new ApplicationDbContext())
            {
                var quiz = db.Quizzes
                    .Include(q => q.Course)
                    .Include(q => q.Questions)
                    .FirstOrDefault(q => q.Id == QuizId);

                if (quiz == null)
                {
                    Response.Redirect("Courses.aspx");
                    return;
                }

                lblCourseName.Text = quiz.Course != null ? quiz.Course.Title : "Course Assessment";
                lnkBackCourse.HRef = "CourseDetail.aspx?id=" + quiz.CourseId;
                lblQuizTitle.Text = quiz.Title;
                lblQuizDescription.Text = !string.IsNullOrWhiteSpace(quiz.Description) ? quiz.Description : "Answer the following questions to test your knowledge.";
                lblPassingRequirement.Text = quiz.PassingScorePercent + "%";
                lnkRetake.HRef = "TakeQuiz.aspx?quizId=" + QuizId;

                var questions = quiz.Questions.OrderBy(q => q.OrderIndex).ToList();
                rptQuestions.DataSource = questions;
                rptQuestions.DataBind();
            }
        }

        protected void rptQuestions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var question = e.Item.DataItem as QuizQuestion;
                var rbl = e.Item.FindControl("rblOptions") as RadioButtonList;

                if (question != null && rbl != null)
                {
                    rbl.Items[0].Text = "A) " + Server.HtmlEncode(question.OptionA);
                    rbl.Items[1].Text = "B) " + Server.HtmlEncode(question.OptionB);
                    rbl.Items[2].Text = "C) " + Server.HtmlEncode(question.OptionC);
                    rbl.Items[3].Text = "D) " + Server.HtmlEncode(question.OptionD);
                }
            }
        }

        protected void btnSubmitQuiz_Click(object sender, EventArgs e)
        {
            string userId = User.Identity.GetUserId();
            int totalQuestions = rptQuestions.Items.Count;
            int correctCount = 0;

            foreach (RepeaterItem item in rptQuestions.Items)
            {
                var hfCorrect = item.FindControl("hfCorrectOption") as HiddenField;
                var rbl = item.FindControl("rblOptions") as RadioButtonList;

                if (hfCorrect != null && rbl != null)
                {
                    if (rbl.SelectedValue == hfCorrect.Value)
                    {
                        correctCount++;
                    }
                }
            }

            int scorePercent = totalQuestions > 0 ? (int)Math.Round(((double)correctCount / totalQuestions) * 100) : 0;

            using (var db = new ApplicationDbContext())
            {
                var quiz = db.Quizzes.Find(QuizId);
                int passingScore = quiz != null ? quiz.PassingScorePercent : 70;
                bool isPassed = scorePercent >= passingScore;

                var attempt = new QuizAttempt
                {
                    QuizId = QuizId,
                    UserId = userId,
                    TotalQuestions = totalQuestions,
                    CorrectAnswers = correctCount,
                    ScorePercent = scorePercent,
                    IsPassed = isPassed,
                    AttemptDate = DateTime.Now
                };

                db.QuizAttempts.Add(attempt);
                db.SaveChanges();

                // Display Result Card
                pnlResult.Visible = true;
                pnlQuizForm.Visible = false;

                if (isPassed)
                {
                    pnlResult.Style["background"] = "#ECFDF5";
                    pnlResult.Style["border"] = "1.5px solid #6EE7B7";
                    divResultIcon.InnerText = "🎉";
                    divResultIcon.Style["background"] = "#D1FAE5";
                    hResultHeading.InnerText = "Congratulations! You Passed!";
                    hResultHeading.Style["color"] = "#065F46";
                    pResultSub.InnerText = string.Format("You scored {0}% ({1} of {2} questions correct). Minimum required was {3}%.", scorePercent, correctCount, totalQuestions, passingScore);
                    pResultSub.Style["color"] = "#047857";
                }
                else
                {
                    pnlResult.Style["background"] = "#FEF2F2";
                    pnlResult.Style["border"] = "1.5px solid #FECACA";
                    divResultIcon.InnerText = "❌";
                    divResultIcon.Style["background"] = "#FEE2E2";
                    hResultHeading.InnerText = "Assessment Not Passed";
                    hResultHeading.Style["color"] = "#991B1B";
                    pResultSub.InnerText = string.Format("You scored {0}% ({1} of {2} questions correct). You need at least {3}% to pass.", scorePercent, correctCount, totalQuestions, passingScore);
                    pResultSub.Style["color"] = "#B91C1C";
                }
            }
        }
    }
}
