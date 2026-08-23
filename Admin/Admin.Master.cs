using System;
using System.Security.Claims;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

namespace Codelecta_2._0
{
    public partial class AdminMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Enforce admin authorization server-side
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            if (!Context.User.IsInRole("Admin"))
            {
                Response.Redirect("~/");
                return;
            }
        }

        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
        }

        public string GetAdminDisplayName()
        {
            if (Context.User != null && Context.User.Identity.IsAuthenticated)
            {
                var claimsIdentity = Context.User.Identity as ClaimsIdentity;
                var fullNameClaim = claimsIdentity?.FindFirst("FullName");
                if (fullNameClaim != null && !string.IsNullOrWhiteSpace(fullNameClaim.Value))
                {
                    return fullNameClaim.Value;
                }
                string name = Context.User.Identity.GetUserName();
                if (!string.IsNullOrEmpty(name) && name.Contains("@"))
                {
                    return name.Split('@')[0];
                }
                return name ?? "Administrator";
            }
            return "Administrator";
        }

        public string GetAdminInitial()
        {
            string name = GetAdminDisplayName();
            return !string.IsNullOrEmpty(name) ? name.Substring(0, 1).ToUpper() : "A";
        }
    }
}
