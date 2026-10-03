using System;
using System.Linq;
using System.Web;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Owin;
using Codelecta_2._0.Models;

namespace Codelecta_2._0.Account
{
    public partial class RegisterExternalLogin : System.Web.UI.Page
    {
        protected string ProviderName
        {
            get { return (string)ViewState["ProviderName"] ?? String.Empty; }
            private set { ViewState["ProviderName"] = value; }
        }

        protected string ProviderAccountKey
        {
            get { return (string)ViewState["ProviderAccountKey"] ?? String.Empty; }
            private set { ViewState["ProviderAccountKey"] = value; }
        }

        private void RedirectOnFail()
        {
            Response.Redirect((User.Identity.IsAuthenticated) ? "~/Account/Manage" : "~/Account/Login");
        }

        protected void Page_Load()
        {
            // If the provider returned an error (e.g. user canceled: error=access_denied), redirect back cleanly
            if (!String.IsNullOrEmpty(Request.QueryString["error"]))
            {
                RedirectOnFail();
                return;
            }

            // Process the result from an auth provider in the request
            ProviderName = IdentityHelper.GetProviderNameFromRequest(Request);
            if (String.IsNullOrEmpty(ProviderName))
            {
                RedirectOnFail();
                return;
            }
            if (!IsPostBack)
            {
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
                var loginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo();
                if (loginInfo == null)
                {
                    RedirectOnFail();
                    return;
                }
                var user = manager.Find(loginInfo.Login);
                if (user != null)
                {
                    signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                    if (!user.OnboardingCompleted)
                    {
                        Response.Redirect("~/Onboarding");
                    }
                    else
                    {
                        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                    }
                }
                else if (User.Identity.IsAuthenticated)
                {
                    // Apply Xsrf check when linking
                    var verifiedloginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo(IdentityHelper.XsrfKey, User.Identity.GetUserId());
                    if (verifiedloginInfo == null)
                    {
                        RedirectOnFail();
                        return;
                    }

                    var result = manager.AddLogin(User.Identity.GetUserId(), verifiedloginInfo.Login);
                    if (result.Succeeded)
                    {
                        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                    }
                    else
                    {
                        AddErrors(result);
                        return;
                    }
                }
                else
                {
                    email.Text = loginInfo.Email;
                    // Attempt to pre-fill FullName from external claims if available
                    if (!String.IsNullOrEmpty(loginInfo.DefaultUserName))
                    {
                        fullName.Text = loginInfo.DefaultUserName;
                    }
                }
            }
        }        
        
        protected void LogIn_Click(object sender, EventArgs e)
        {
            CreateAndLoginUser();
        }

        private void CreateAndLoginUser()
        {
            if (!IsValid)
            {
                return;
            }
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();

            // Check if user already exists with this email/username
            var existingUser = manager.FindByEmail(email.Text.Trim()) ?? manager.FindByName(email.Text.Trim());
            var loginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo();
            if (loginInfo == null)
            {
                RedirectOnFail();
                return;
            }

            if (existingUser != null)
            {
                // Link external login to the existing user account
                var addLoginResult = manager.AddLogin(existingUser.Id, loginInfo.Login);
                if (addLoginResult.Succeeded || existingUser.Logins.Any(l => l.LoginProvider == loginInfo.Login.LoginProvider && l.ProviderKey == loginInfo.Login.ProviderKey))
                {
                    signInManager.SignIn(existingUser, isPersistent: false, rememberBrowser: false);
                    if (!existingUser.OnboardingCompleted)
                    {
                        Response.Redirect("~/Onboarding");
                    }
                    else
                    {
                        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                    }
                    return;
                }
                else
                {
                    AddErrors(addLoginResult);
                    return;
                }
            }

            var user = new ApplicationUser() 
            { 
                UserName = email.Text.Trim(), 
                Email = email.Text.Trim(),
                FullName = fullName.Text.Trim()
            };

            IdentityResult result = manager.Create(user);
            if (result.Succeeded)
            {
                result = manager.AddLogin(user.Id, loginInfo.Login);
                if (result.Succeeded)
                {
                    signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                    Response.Redirect("~/Onboarding");
                    return;
                }
            }
            AddErrors(result);
        }

        private void AddErrors(IdentityResult result) 
        {
            foreach (var error in result.Errors) 
            {
                ModelState.AddModelError("", error);
            }
        }
    }
}
