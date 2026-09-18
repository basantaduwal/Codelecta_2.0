using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Codelecta_2._0
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataBind();
            }
        }

        public string GetDashboardUrl()
        {
            if (User != null && User.IsInRole("Admin"))
            {
                return ResolveUrl("~/Admin/Dashboard");
            }
            return ResolveUrl("~/Dashboard");
        }
    }
}