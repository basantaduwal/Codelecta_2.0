using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using Codelecta_2._0.Models;

namespace Codelecta_2._0.Account
{
    public partial class Register : Page
    {
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var user = new ApplicationUser() 
            { 
                UserName = Email.Text, 
                Email = Email.Text,
                FullName = FullName.Text.Trim()
            };

            // Prevent duplicate usernames/emails
            var existingUser = manager.FindByName(Email.Text);
            if (existingUser != null)
            {
                ErrorMessage.Text = "An account with that email already exists.";
                return;
            }

            IdentityResult result;
            try
            {
                result = manager.Create(user, Password.Text);
            }
            catch (System.Data.Entity.Infrastructure.DbUpdateException)
            {
                // Unique constraint violation at the database level (race or duplicate)
                ErrorMessage.Text = "An account with that email already exists.";
                return;
            }

            if (result.Succeeded)
            {
                signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                // New accounts always need to complete onboarding first
                Response.Redirect("~/Onboarding");
            }
            else 
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }
    }
}