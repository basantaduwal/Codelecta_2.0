using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Codelecta_2._0.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace Codelecta_2._0.Admin
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        // ─── DTO used to bind the Repeater ───────────────────────────────────
        public class UserRow
        {
            public string UserId            { get; set; }
            public string FullName          { get; set; }
            public string Email             { get; set; }
            public string ExperienceLevel   { get; set; }
            public bool   OnboardingCompleted { get; set; }
            public bool   IsAdmin           { get; set; }
            public int    EnrolledCount     { get; set; }
        }

        // ─── Page Load ───────────────────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated || !Context.User.IsInRole("Admin"))
            {
                Response.Redirect("~/");
                return;
            }

            if (!IsPostBack)
            {
                LoadStats();
                BindUsers(null, "all");
            }
        }

        // ─── Load top summary cards ──────────────────────────────────────────
        private void LoadStats()
        {
            using (var db = new ApplicationDbContext())
            {
                var roleStore = new RoleStore<IdentityRole>(db);
                var roleMgr   = new RoleManager<IdentityRole>(roleStore);

                var adminRole = roleMgr.FindByName("Admin");
                var adminIds  = adminRole != null
                    ? adminRole.Users.Select(u => u.UserId).ToList()
                    : new List<string>();

                var users = db.Users.ToList();

                lblTotalUsers.Text  = users.Count.ToString();
                lblOnboarded.Text   = users.Count(u => u.OnboardingCompleted).ToString();
                lblEnrollments.Text = db.UserCourses.Count().ToString();
                lblAdmins.Text      = adminIds.Count.ToString();
            }
        }

        // ─── Bind the repeater with optional search + filter ─────────────────
        private void BindUsers(string searchTerm, string filter)
        {
            using (var db = new ApplicationDbContext())
            {
                var roleStore = new RoleStore<IdentityRole>(db);
                var roleMgr   = new RoleManager<IdentityRole>(roleStore);

                var adminRole = roleMgr.FindByName("Admin");
                var adminIds  = adminRole != null
                    ? adminRole.Users.Select(u => u.UserId).ToHashSet()
                    : new HashSet<string>();

                // Enrollment counts per user
                var enrollCounts = db.UserCourses
                    .GroupBy(uc => uc.UserId)
                    .Select(g => new { UserId = g.Key, Count = g.Count() })
                    .ToDictionary(x => x.UserId, x => x.Count);

                IQueryable<ApplicationUser> query = db.Users;

                // Apply search
                if (!string.IsNullOrWhiteSpace(searchTerm))
                {
                    var term = searchTerm.Trim().ToLower();
                    query = query.Where(u =>
                        u.Email.ToLower().Contains(term) ||
                        u.FullName.ToLower().Contains(term));
                }

                // Apply filter
                if (filter == "beginner")
                    query = query.Where(u => u.ExperienceLevel == "Beginner");
                else if (filter == "intermediate")
                    query = query.Where(u => u.ExperienceLevel == "Intermediate");
                else if (filter == "professional")
                    query = query.Where(u => u.ExperienceLevel == "Professional");
                else if (filter == "pending")
                    query = query.Where(u => !u.OnboardingCompleted);

                var rows = query.OrderBy(u => u.FullName).ToList().Select(u => new UserRow
                {
                    UserId              = u.Id,
                    FullName            = u.FullName ?? "",
                    Email               = u.Email ?? "",
                    ExperienceLevel     = u.ExperienceLevel ?? "",
                    OnboardingCompleted = u.OnboardingCompleted,
                    IsAdmin             = adminIds.Contains(u.Id),
                    EnrolledCount       = enrollCounts.ContainsKey(u.Id) ? enrollCounts[u.Id] : 0
                }).ToList();

                lblUserCount.Text = rows.Count.ToString();

                if (rows.Count == 0)
                {
                    rptUsers.DataSource = null;
                    rptUsers.DataBind();
                    pnlEmpty.Visible = true;
                }
                else
                {
                    pnlEmpty.Visible = false;
                    rptUsers.DataSource = rows;
                    rptUsers.DataBind();
                }
            }
        }

        // ─── Search / Reset handlers ─────────────────────────────────────────
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindUsers(txtSearch.Text, ddlFilter.SelectedValue);
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlFilter.SelectedValue = "all";
            BindUsers(null, "all");
            pnlMessage.Visible = false;
        }

        // ─── Repeater item command: toggle admin role ─────────────────────────
        protected void rptUsers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string userId = e.CommandArgument.ToString();
            if (string.IsNullOrWhiteSpace(userId)) return;

            using (var db = new ApplicationDbContext())
            {
                var userStore = new UserStore<ApplicationUser>(db);
                var userMgr   = new UserManager<ApplicationUser>(userStore);

                bool inAdmin = userMgr.IsInRole(userId, "Admin");

                if (e.CommandName == "MakeAdmin" && !inAdmin)
                {
                    userMgr.AddToRole(userId, "Admin");
                    ShowMessage("✓ User has been granted Admin access.", true);
                }
                else if (e.CommandName == "RemoveAdmin" && inAdmin)
                {
                    // Prevent removing own admin
                    string currentId = Context.User.Identity.GetUserId();
                    if (userId == currentId)
                    {
                        ShowMessage("✗ You cannot revoke your own Admin role.", false);
                    }
                    else
                    {
                        userMgr.RemoveFromRole(userId, "Admin");
                        ShowMessage("✓ Admin access has been revoked.", true);
                    }
                }
            }

            LoadStats();
            BindUsers(txtSearch.Text, ddlFilter.SelectedValue);
        }

        // ─── Helper: show feedback message ───────────────────────────────────
        private void ShowMessage(string text, bool success)
        {
            lblActionMessage.Text = text;
            pnlMessage.Visible    = true;
            pnlMessage.Style["background"]    = success ? "#ECFDF5" : "#FEF2F2";
            pnlMessage.Style["color"]         = success ? "#065F46" : "#991B1B";
            pnlMessage.Style["border"]        = success ? "1px solid #6EE7B7" : "1px solid #FECACA";
        }

        // ─── Helpers called from markup ───────────────────────────────────────

        public string GetInitial(string fullName, string email)
        {
            if (!string.IsNullOrWhiteSpace(fullName)) return fullName.Substring(0, 1).ToUpper();
            if (!string.IsNullOrWhiteSpace(email))    return email.Substring(0, 1).ToUpper();
            return "U";
        }

        public string GetAvatarColor(string userId)
        {
            // Deterministic colour from user ID hash
            string[] palette = {
                "linear-gradient(135deg,#6C5CE7,#A855F7)",
                "linear-gradient(135deg,#0284C7,#06B6D4)",
                "linear-gradient(135deg,#10B981,#059669)",
                "linear-gradient(135deg,#F59E0B,#D97706)",
                "linear-gradient(135deg,#EC4899,#DB2777)",
                "linear-gradient(135deg,#8B5CF6,#7C3AED)",
            };
            int idx = Math.Abs(userId.GetHashCode()) % palette.Length;
            return palette[idx];
        }

        public string GetLevelBadge(string level)
        {
            switch ((level ?? "").ToLower())
            {
                case "beginner":
                    return "<span style='padding:3px 10px; background:#F0FDF4; color:#166534; border:1px solid #BBF7D0; border-radius:20px; font-size:0.75rem; font-weight:700;'>Beginner</span>";
                case "intermediate":
                    return "<span style='padding:3px 10px; background:#FFFBEB; color:#92400E; border:1px solid #FDE68A; border-radius:20px; font-size:0.75rem; font-weight:700;'>Intermediate</span>";
                case "professional":
                    return "<span style='padding:3px 10px; background:#EFF6FF; color:#1E40AF; border:1px solid #BFDBFE; border-radius:20px; font-size:0.75rem; font-weight:700;'>Professional</span>";
                default:
                    return "<span style='padding:3px 10px; background:#F8F7FF; color:#94A3B8; border:1px solid #EDE9FE; border-radius:20px; font-size:0.75rem; font-weight:600;'>—</span>";
            }
        }

        public string GetOnboardingBadge(bool completed)
        {
            return completed
                ? "<span style='padding:3px 10px; background:#ECFDF5; color:#065F46; border:1px solid #6EE7B7; border-radius:20px; font-size:0.75rem; font-weight:700;'>✓ Done</span>"
                : "<span style='padding:3px 10px; background:#FEF3C7; color:#92400E; border:1px solid #FDE68A; border-radius:20px; font-size:0.75rem; font-weight:700;'>Pending</span>";
        }

        public string GetRoleBadge(bool isAdmin)
        {
            return isAdmin
                ? "<span style='padding:3px 10px; background:#FEF2F2; color:#991B1B; border:1px solid #FECACA; border-radius:20px; font-size:0.75rem; font-weight:800;'>Admin</span>"
                : "<span style='padding:3px 10px; background:#F3F0FF; color:#5B4BD8; border:1px solid #DDD6FE; border-radius:20px; font-size:0.75rem; font-weight:700;'>Student</span>";
        }
    }
}
