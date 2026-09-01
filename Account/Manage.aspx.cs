using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Codelecta_2._0.Models;

namespace Codelecta_2._0.Account
{
    public partial class Manage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            string userId = User.Identity.GetUserId();

            using (var db = new ApplicationDbContext())
            {
                var user = db.Users.Find(userId);
                if (user == null) return;

                string displayName = !string.IsNullOrWhiteSpace(user.FullName) ? user.FullName : user.UserName;
                lblProfileHeading.Text = displayName;
                lblEmailAddress.Text = user.Email;

                lblAvatarInitial.Text = !string.IsNullOrWhiteSpace(displayName) 
                    ? displayName.Substring(0, 1).ToUpper() 
                    : "U";

                txtFullName.Text = user.FullName ?? "";

                if (!string.IsNullOrEmpty(user.ExperienceLevel) && ddlExperienceLevel.Items.FindByValue(user.ExperienceLevel) != null)
                {
                    ddlExperienceLevel.SelectedValue = user.ExperienceLevel;
                }

                // Check Admin role
                bool isAdmin = User.IsInRole("Admin");
                lblAccountRole.Text = isAdmin ? "Administrator" : "Student";
                lblAccountRole.Style["background"] = isAdmin ? "#FEF2F2" : "#F3F0FF";
                lblAccountRole.Style["color"] = isAdmin ? "#991B1B" : "#6C5CE7";

                // Enrolled courses count
                int enrolledCount = db.UserCourses.Count(uc => uc.UserId == userId);
                lblStatCourses.Text = enrolledCount.ToString();

                // Completed certificates count
                var userCourses = db.UserCourses.Where(uc => uc.UserId == userId).Include(uc => uc.Course.Lessons).ToList();
                var completedLessonIds = new HashSet<int>(db.LessonProgresses.Where(lp => lp.UserId == userId && lp.IsCompleted).Select(lp => lp.LessonId).ToList());

                int certificatesEarned = 0;
                foreach (var uc in userCourses)
                {
                    if (uc.Course != null && uc.Course.Lessons != null && uc.Course.Lessons.Count > 0)
                    {
                        if (uc.Course.Lessons.All(l => completedLessonIds.Contains(l.Id)))
                        {
                            certificatesEarned++;
                        }
                    }
                }

                lblStatCertificates.Text = certificatesEarned.ToString();
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            string userId = User.Identity.GetUserId();

            using (var db = new ApplicationDbContext())
            {
                var user = db.Users.Find(userId);
                if (user != null)
                {
                    user.FullName = txtFullName.Text.Trim();
                    user.ExperienceLevel = ddlExperienceLevel.SelectedValue;
                    db.SaveChanges();

                    ShowStatus("✓ Profile details updated successfully!", true);
                }
            }

            LoadUserProfile();
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string currentPass = txtCurrentPassword.Text;
            string newPass = txtNewPassword.Text;
            string confirmPass = txtConfirmPassword.Text;

            if (string.IsNullOrWhiteSpace(currentPass) || string.IsNullOrWhiteSpace(newPass))
            {
                ShowStatus("Please fill in all password fields.", false);
                return;
            }

            if (newPass != confirmPass)
            {
                ShowStatus("New password and confirmation password do not match.", false);
                return;
            }

            if (newPass.Length < 6)
            {
                ShowStatus("New password must be at least 6 characters long.", false);
                return;
            }

            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var result = manager.ChangePassword(User.Identity.GetUserId(), currentPass, newPass);

            if (result.Succeeded)
            {
                var user = manager.FindById(User.Identity.GetUserId());
                var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
                if (user != null && signInManager != null)
                {
                    signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                }

                txtCurrentPassword.Text = "";
                txtNewPassword.Text = "";
                txtConfirmPassword.Text = "";
                ShowStatus("✓ Password changed successfully!", true);
            }
            else
            {
                string errorMsg = string.Join("; ", result.Errors);
                ShowStatus(errorMsg, false);
            }
        }

        private void ShowStatus(string message, bool isSuccess)
        {
            lblStatusMessage.Text = message;
            pnlStatusMessage.Visible = true;
            pnlStatusMessage.Style["background"] = isSuccess ? "#ECFDF5" : "#FEF2F2";
            pnlStatusMessage.Style["color"] = isSuccess ? "#065F46" : "#991B1B";
            pnlStatusMessage.Style["border"] = isSuccess ? "1.5px solid #6EE7B7" : "1.5px solid #FECACA";
        }
    }
}
