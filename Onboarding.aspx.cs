using System;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Codelecta_2._0.Models;

namespace Codelecta_2._0
{
    public partial class Onboarding : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Must be authenticated to reach this page
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login");
                return;
            }
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            string level = hfSelectedLevel.Value.Trim();

            // Validate – must be one of the three known values
            if (level != "Beginner" && level != "Intermediate" && level != "Professional")
            {
                lblError.Text    = "Please select an experience level before continuing.";
                lblError.Visible = true;
                return;
            }

            SaveOnboarding(experienceLevel: level, completed: true);
            Response.Redirect("~/");
        }

        protected void lnkSkip_Click(object sender, EventArgs e)
        {
            // Skip: do NOT mark OnboardingCompleted — the prompt will appear again next login.
            // We also deliberately do NOT save an ExperienceLevel.
            Response.Redirect("~/");
        }

        // ─── Helpers ───────────────────────────────────────────────────────────
        private void SaveOnboarding(string experienceLevel, bool completed)
        {
            string userId = User.Identity.GetUserId();

            using (var db = new ApplicationDbContext())
            {
                var user = db.Users.Find(userId) as ApplicationUser;
                if (user == null) return;

                user.ExperienceLevel    = experienceLevel;
                user.OnboardingCompleted = completed;
                db.SaveChanges();
            }
        }
    }
}
