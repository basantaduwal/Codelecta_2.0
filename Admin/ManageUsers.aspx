<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="Codelecta_2._0.Admin.ManageUsers" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PageTitleContent" runat="server">
    Manage Users
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ==================== TOP STATS ROW ==================== -->
    <div style="display:grid; grid-template-columns:repeat(4,1fr); gap:20px; margin-bottom:28px;">

        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background:rgba(108,92,231,0.12); color:#6C5CE7;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                    <circle cx="9" cy="7" r="4"></circle>
                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                    <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">Total Users</span>
                <span class="stat-value"><asp:Label ID="lblTotalUsers" runat="server" Text="0" /></span>
            </div>
        </div>

        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background:rgba(16,185,129,0.12); color:#10B981;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                    <polyline points="22 4 12 14.01 9 11.01"></polyline>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">Onboarded</span>
                <span class="stat-value"><asp:Label ID="lblOnboarded" runat="server" Text="0" /></span>
            </div>
        </div>

        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background:rgba(245,158,11,0.12); color:#F59E0B;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
                    <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">Active Enrollments</span>
                <span class="stat-value"><asp:Label ID="lblEnrollments" runat="server" Text="0" /></span>
            </div>
        </div>

        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background:rgba(239,68,68,0.12); color:#EF4444;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">Admin Accounts</span>
                <span class="stat-value"><asp:Label ID="lblAdmins" runat="server" Text="0" /></span>
            </div>
        </div>

    </div>

    <!-- ==================== STATUS MESSAGE ==================== -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false"
        style="margin-bottom:18px; padding:13px 20px; border-radius:10px; font-weight:600; font-size:0.9rem;">
        <asp:Label ID="lblActionMessage" runat="server" />
    </asp:Panel>

    <!-- ==================== FILTER BAR ==================== -->
    <div class="admin-table-card" style="margin-bottom:20px; padding:16px 22px;">
        <div style="display:flex; align-items:center; gap:12px; flex-wrap:wrap;">

            <div style="flex:1; min-width:200px; position:relative;">
                <svg style="position:absolute; left:11px; top:50%; transform:translateY(-50%); color:#94A3B8; pointer-events:none;"
                    xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by name or email..."
                    style="width:100%; padding:9px 14px 9px 34px; border:1px solid #EDE9FE; border-radius:8px; font-size:0.88rem; font-family:inherit; color:#1E1B4B; background:#FAFAFA; box-sizing:border-box;" />
            </div>

            <asp:DropDownList ID="ddlFilter" runat="server"
                style="padding:9px 14px; border:1px solid #EDE9FE; border-radius:8px; font-size:0.88rem; font-family:inherit; color:#475569; background:#FAFAFA; cursor:pointer;">
                <asp:ListItem Value="all"          Text="All Users" />
                <asp:ListItem Value="beginner"     Text="Beginners" />
                <asp:ListItem Value="intermediate" Text="Intermediate" />
                <asp:ListItem Value="professional" Text="Professional" />
                <asp:ListItem Value="pending"      Text="Not Onboarded" />
            </asp:DropDownList>

            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                style="padding:9px 22px; background:linear-gradient(135deg,#6C5CE7,#A855F7); color:#fff; border:none; border-radius:8px; font-weight:700; font-size:0.88rem; cursor:pointer; font-family:inherit;" />

            <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click"
                style="padding:9px 18px; background:#F5F3FF; color:#6C5CE7; border:1px solid #DDD6FE; border-radius:8px; font-weight:600; font-size:0.88rem; cursor:pointer; font-family:inherit;" />
        </div>
    </div>

    <!-- ==================== USERS TABLE ==================== -->
    <div class="admin-table-card">

        <div style="padding:18px 22px 0; display:flex; align-items:center; justify-content:space-between;">
            <h3 style="font-size:1rem; font-weight:700; color:#1E1B4B; margin:0;">
                Registered Users
                <span style="margin-left:10px; padding:3px 11px; background:#F3F0FF; color:#6C5CE7; border-radius:20px; font-size:0.75rem; font-weight:800;">
                    <asp:Label ID="lblUserCount" runat="server" Text="0" /> total
                </span>
            </h3>
        </div>

        <div style="overflow-x:auto; margin-top:14px;">
            <asp:Repeater ID="rptUsers" runat="server" OnItemCommand="rptUsers_ItemCommand">
                <HeaderTemplate>
                    <table style="width:100%; border-collapse:collapse; font-size:0.88rem;">
                        <thead>
                            <tr style="background:#F8F7FF; border-bottom:2px solid #EDE9FE;">
                                <th style="padding:11px 20px; text-align:left; font-weight:700; color:#475569; font-size:0.75rem; letter-spacing:0.5px; text-transform:uppercase; white-space:nowrap;">User</th>
                                <th style="padding:11px 16px; text-align:left; font-weight:700; color:#475569; font-size:0.75rem; letter-spacing:0.5px; text-transform:uppercase; white-space:nowrap;">Email</th>
                                <th style="padding:11px 16px; text-align:left; font-weight:700; color:#475569; font-size:0.75rem; letter-spacing:0.5px; text-transform:uppercase; white-space:nowrap;">Level</th>
                                <th style="padding:11px 16px; text-align:left; font-weight:700; color:#475569; font-size:0.75rem; letter-spacing:0.5px; text-transform:uppercase; white-space:nowrap;">Courses</th>
                                <th style="padding:11px 16px; text-align:left; font-weight:700; color:#475569; font-size:0.75rem; letter-spacing:0.5px; text-transform:uppercase; white-space:nowrap;">Onboarding</th>
                                <th style="padding:11px 16px; text-align:left; font-weight:700; color:#475569; font-size:0.75rem; letter-spacing:0.5px; text-transform:uppercase; white-space:nowrap;">Role</th>
                                <th style="padding:11px 16px; text-align:center; font-weight:700; color:#475569; font-size:0.75rem; letter-spacing:0.5px; text-transform:uppercase; white-space:nowrap;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>

                <ItemTemplate>
                    <tr style='<%# Container.ItemIndex % 2 == 0 ? "background:#FFFFFF;" : "background:#FAFAFA;" %> border-bottom:1px solid #F1F0FB;'>

                        <%-- Avatar + Name --%>
                        <td style="padding:13px 20px; white-space:nowrap;">
                            <div style="display:flex; align-items:center; gap:11px;">
                                <div style='width:36px; height:36px; border-radius:50%; background:<%# GetAvatarColor(Eval("UserId").ToString()) %>; display:flex; align-items:center; justify-content:center; color:#fff; font-weight:800; font-size:0.95rem; flex-shrink:0;'>
                                    <%# GetInitial(Eval("FullName").ToString(), Eval("Email").ToString()) %>
                                </div>
                                <div>
                                    <div style="font-weight:700; color:#1E1B4B; font-size:0.9rem; max-width:150px; overflow:hidden; text-overflow:ellipsis;">
                                        <%# !string.IsNullOrWhiteSpace(Eval("FullName").ToString()) ? Server.HtmlEncode(Eval("FullName").ToString()) : "<span style='color:#94A3B8;'>—</span>" %>
                                    </div>
                                    <div style="font-size:0.72rem; color:#94A3B8; font-family:'Fira Code',monospace;">
                                        <%# Eval("UserId").ToString().Substring(0, 8) %>…
                                    </div>
                                </div>
                            </div>
                        </td>

                        <%-- Email --%>
                        <td style="padding:13px 16px; color:#475569; max-width:200px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                            <%# Server.HtmlEncode(Eval("Email").ToString()) %>
                        </td>

                        <%-- Level badge --%>
                        <td style="padding:13px 16px;">
                            <%# GetLevelBadge(Eval("ExperienceLevel").ToString()) %>
                        </td>

                        <%-- Enrolled count --%>
                        <td style="padding:13px 16px;">
                            <span style="display:inline-flex; align-items:center; gap:5px; font-weight:700; color:#6C5CE7; font-size:0.9rem;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                                    <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
                                </svg>
                                <%# Eval("EnrolledCount") %>
                            </span>
                        </td>

                        <%-- Onboarding badge --%>
                        <td style="padding:13px 16px;">
                            <%# GetOnboardingBadge((bool)Eval("OnboardingCompleted")) %>
                        </td>

                        <%-- Role badge --%>
                        <td style="padding:13px 16px;">
                            <%# GetRoleBadge((bool)Eval("IsAdmin")) %>
                        </td>

                        <%-- Action button --%>
                        <td style="padding:13px 16px; text-align:center;">
                            <asp:LinkButton ID="lbtnToggleAdmin" runat="server"
                                CommandName='<%# (bool)Eval("IsAdmin") ? "RemoveAdmin" : "MakeAdmin" %>'
                                CommandArgument='<%# Eval("UserId") %>'
                                OnClientClick="return confirm('Are you sure you want to change this user\'s role?');"
                                style='<%# (bool)Eval("IsAdmin")
                                    ? "padding:5px 13px; background:#FEF2F2; color:#EF4444; border:1px solid #FECACA; border-radius:6px; font-size:0.78rem; font-weight:700; text-decoration:none; white-space:nowrap;"
                                    : "padding:5px 13px; background:#F3F0FF; color:#6C5CE7; border:1px solid #DDD6FE; border-radius:6px; font-size:0.78rem; font-weight:700; text-decoration:none; white-space:nowrap;" %>'>
                                <%# (bool)Eval("IsAdmin") ? "Revoke Admin" : "Make Admin" %>
                            </asp:LinkButton>
                        </td>

                    </tr>
                </ItemTemplate>

                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <%-- Empty state --%>
            <asp:Panel ID="pnlEmpty" runat="server" Visible="false"
                style="text-align:center; padding:60px 20px; color:#94A3B8;">
                <svg xmlns="http://www.w3.org/2000/svg" width="44" height="44" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom:12px; opacity:0.35;">
                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                    <circle cx="9" cy="7" r="4"></circle>
                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                    <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                </svg>
                <p style="font-weight:600; font-size:0.95rem; margin:0;">No users found matching your search.</p>
            </asp:Panel>
        </div>
    </div>

</asp:Content>
