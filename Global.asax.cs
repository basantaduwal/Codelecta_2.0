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
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        void Application_PostAuthenticateRequest(object sender, EventArgs e)
        {
            // Only run the guard for authenticated users
            var context = HttpContext.Current;
            if (context == null || !context.Request.IsAuthenticated)
                return;

            // Normalize the path for comparison
            string path = context.Request.AppRelativeCurrentExecutionFilePath
                              ?.ToLowerInvariant() ?? string.Empty;

            // Paths exempt from the onboarding guard:
            //  - The onboarding page itself            (avoid redirect loop)
            //  - Account pages (Login, Register, etc.) (avoid auth loop)
            //  - Static/handler resources
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

            // Look up the user's OnboardingCompleted flag
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
            catch
            {
                // Swallow any Identity/OWIN startup errors so the app doesn't crash
                // before Startup.Auth has fully initialised
            }
        }
    }
}