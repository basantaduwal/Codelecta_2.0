using System;
using System.Web.UI;

namespace Codelecta_2._0
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlSuccess.Visible = false;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In a university project context, simulate processing the contact request
                // Clear the form fields
                txtName.Text = string.Empty;
                txtEmail.Text = string.Empty;
                txtSubject.Text = string.Empty;
                txtMessage.Text = string.Empty;

                pnlSuccess.Visible = true;
            }
        }
    }
}
