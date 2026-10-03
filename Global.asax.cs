using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Codelecta_2._0.Models;

namespace Codelecta_2._0
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        void Application_PostAuthenticateRequest(object sender, EventArgs e)
        {
            var context = HttpContext.Current;
            if (context == null || !context.Request.IsAuthenticated)
                return;

            string path = context.Request.AppRelativeCurrentExecutionFilePath
                              ?.ToLowerInvariant() ?? string.Empty;

            var exemptPrefixes = new[]
            {
                "~/onboarding",
                "~/account/",
                "~/webresource.axd",
                "~/scriptresource.axd",
                "~/favicon.ico",
                "~/content/",
                "~/scripts/",
                "~/logo.png"
            };

            bool isExempt = exemptPrefixes.Any(prefix => path.StartsWith(prefix));
            if (isExempt) return;

            try
            {
                string userId = context.User.Identity.GetUserId();
                if (string.IsNullOrEmpty(userId)) return;

                var userManager = context.GetOwinContext()
                                         .GetUserManager<ApplicationUserManager>();
                if (userManager == null) return;

                var user = userManager.FindById(userId) as ApplicationUser;
                if (user != null && !user.OnboardingCompleted)
                {
                    context.Response.Redirect("~/Onboarding", endResponse: false);
                    context.ApplicationInstance.CompleteRequest();
                }
            }
            catch { }
        }
    }
}