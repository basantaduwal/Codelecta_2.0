<%@ Page Title="Manage Enrollments" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageEnrollments.aspx.cs" Inherits="Codelecta_2._0.Admin.ManageEnrollments" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PageTitleContent" runat="server">
    Manage Enrollments
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ==================== TOP STATS ROW ==================== -->
    <div style="display:grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 28px;">
        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background: rgba(108, 92, 231, 0.12); color: #6C5CE7;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
                    <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">Total Enrollments</span>
                <span class="stat-value"><asp:Label ID="lblTotalEnrollments" runat="server" Text="0" /></span>
            </div>
        </div>

        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background: rgba(16, 185, 129, 0.12); color: #10B981;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                    <polyline points="22 4 12 14.01 9 11.01"></polyline>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">100% Completed</span>
                <span class="stat-value"><asp:Label ID="lblCompletedCount" runat="server" Text="0" /></span>
            </div>
        </div>

        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background: rgba(245, 158, 11, 0.12); color: #F59E0B;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10"></circle>
                    <polyline points="12 6 12 12 16 14"></polyline>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">In Progress</span>
                <span class="stat-value"><asp:Label ID="lblInProgressCount" runat="server" Text="0" /></span>
            </div>
        </div>

        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background: rgba(59, 130, 246, 0.12); color: #3B82F6;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                    <circle cx="9" cy="7" r="4"></circle>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">Unique Students</span>
                <span class="stat-value"><asp:Label ID="lblUniqueStudents" runat="server" Text="0" /></span>
            </div>
        </div>
    </div>

    <!-- ==================== STATUS MESSAGE ==================== -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" style="margin-bottom: 20px; padding: 13px 20px; border-radius: 10px; font-weight: 600; font-size: 0.9rem;">
        <asp:Label ID="lblActionMessage" runat="server" />
    </asp:Panel>

    <!-- ==================== MANUAL ENROLLMENT CARD ==================== -->
    <div class="admin-table-card" style="margin-bottom: 28px; padding: 26px;">
        <h3 style="font-size: 1.05rem; font-weight: 800; color: #1E1B4B; margin: 0 0 18px 0;">Manually Enroll Student</h3>
        
        <div style="display: grid; grid-template-columns: 1fr 1fr auto; gap: 16px; align-items: flex-end;">
            <div>
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Select Student</label>
                <asp:DropDownList ID="ddlUsers" runat="server"
                    style="width: 100%; padding: 10px 14px; border: 1px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA;" />
            </div>
            <div>
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Select Course</label>
                <asp:DropDownList ID="ddlCourses" runat="server"
                    style="width: 100%; padding: 10px 14px; border: 1px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA;" />
            </div>
            <div>
                <asp:Button ID="btnEnrollStudent" runat="server" Text="Enroll Student" OnClick="btnEnrollStudent_Click"
                    style="padding: 10px 24px; background: linear-gradient(135deg, #6C5CE7, #A855F7); color: #FFFFFF; border: none; border-radius: 8px; font-weight: 700; font-size: 0.9rem; cursor: pointer; box-shadow: 0 4px 14px rgba(108, 92, 231, 0.25);" />
            </div>
        </div>
    </div>

    <!-- ==================== SEARCH & FILTER ==================== -->
    <div class="admin-table-card" style="margin-bottom: 20px; padding: 16px 22px;">
        <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
            <div style="flex: 1; min-width: 220px; position: relative;">
                <svg style="position: absolute; left: 11px; top: 50%; transform: translateY(-50%); color: #94A3B8; pointer-events: none;"
                    xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by student name, email, or course..."
                    style="width: 100%; padding: 9px 14px 9px 34px; border: 1px solid #EDE9FE; border-radius: 8px; font-size: 0.88rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
            </div>

            <asp:DropDownList ID="ddlFilterStatus" runat="server"
                style="padding: 9px 14px; border: 1px solid #EDE9FE; border-radius: 8px; font-size: 0.88rem; font-family: inherit; color: #475569; background: #FAFAFA;">
                <asp:ListItem Value="all" Text="All Statuses" />
                <asp:ListItem Value="completed" Text="Completed (100%)" />
                <asp:ListItem Value="inprogress" Text="In Progress" />
            </asp:DropDownList>

            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                style="padding: 9px 22px; background: linear-gradient(135deg, #6C5CE7, #A855F7); color: #fff; border: none; border-radius: 8px; font-weight: 700; font-size: 0.88rem; cursor: pointer;" />
            <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click"
                style="padding: 9px 18px; background: #F5F3FF; color: #6C5CE7; border: 1px solid #DDD6FE; border-radius: 8px; font-weight: 600; font-size: 0.88rem; cursor: pointer;" />
        </div>
    </div>

    <!-- ==================== ENROLLMENTS TABLE ==================== -->
    <div class="admin-table-card">
        <div style="padding: 18px 22px 0; display: flex; align-items: center; justify-content: space-between;">
            <h3 style="font-size: 1rem; font-weight: 700; color: #1E1B4B; margin: 0;">
                All Student Enrollments
                <span style="margin-left: 10px; padding: 3px 11px; background: #F3F0FF; color: #6C5CE7; border-radius: 20px; font-size: 0.75rem; font-weight: 800;">
                    <asp:Label ID="lblFilteredCount" runat="server" Text="0" /> records
                </span>
            </h3>
        </div>

        <div style="overflow-x: auto; margin-top: 14px;">
            <asp:Repeater ID="rptEnrollments" runat="server" OnItemCommand="rptEnrollments_ItemCommand">
                <HeaderTemplate>
                    <table style="width: 100%; border-collapse: collapse; font-size: 0.88rem;">
                        <thead>
                            <tr style="background: #F8F7FF; border-bottom: 2px solid #EDE9FE;">
                                <th style="padding: 11px 20px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Student</th>
                                <th style="padding: 11px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Course</th>
                                <th style="padding: 11px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Progress</th>
                                <th style="padding: 11px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Enrolled Date</th>
                                <th style="padding: 11px 16px; text-align: center; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr style='<%# Container.ItemIndex % 2 == 0 ? "background: #FFFFFF;" : "background: #FAFAFA;" %> border-bottom: 1px solid #F1F0FB;'>
                        <td style="padding: 13px 20px;">
                            <div style="font-weight: 700; color: #1E1B4B;"><%# Eval("StudentName") %></div>
                            <div style="font-size: 0.78rem; color: #94A3B8;"><%# Eval("StudentEmail") %></div>
                        </td>
                        <td style="padding: 13px 16px;">
                            <span style="font-weight: 700; color: #6C5CE7;"><%# Eval("CourseTitle") %></span>
                            <div style="font-size: 0.75rem; color: #94A3B8;"><%# Eval("CourseLevel") %></div>
                        </td>
                        <td style="padding: 13px 16px;">
                            <div style="display: flex; align-items: center; gap: 8px;">
                                <div style="width: 80px; height: 6px; background: #E2E8F0; border-radius: 6px; overflow: hidden;">
                                    <div style='width: <%# Eval("ProgressPercent") %>%; height: 100%; background: <%# (int)Eval("ProgressPercent") == 100 ? "#10B981" : "#6C5CE7" %>;'></div>
                                </div>
                                <span style="font-weight: 700; font-size: 0.82rem; color: <%# (int)Eval("ProgressPercent") == 100 ? "#059669" : "#1E1B4B" %>;">
                                    <%# Eval("ProgressPercent") %>%
                                </span>
                            </div>
                            <div style="font-size: 0.75rem; color: #94A3B8; margin-top: 2px;">
                                <%# Eval("CompletedLessons") %> of <%# Eval("TotalLessons") %> lessons
                            </div>
                        </td>
                        <td style="padding: 13px 16px; color: #475569;">
                            <%# Eval("EnrollmentDate", "{0:MMM dd, yyyy}") %>
                        </td>
                        <td style="padding: 13px 16px; text-align: center;">
                            <asp:LinkButton ID="lbtnDropEnrollment" runat="server" CommandName="DropEnrollment" CommandArgument='<%# Eval("EnrollmentId") %>'
                                OnClientClick="return confirm('Are you sure you want to drop this student enrollment?');"
                                style="padding: 5px 12px; background: #FEF2F2; color: #EF4444; border: 1px solid #FECACA; border-radius: 6px; font-size: 0.78rem; font-weight: 700; text-decoration: none;">
                                Drop
                            </asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlNoEnrollments" runat="server" Visible="false" style="text-align: center; padding: 50px 20px; color: #94A3B8;">
                <p style="font-weight: 600; font-size: 0.95rem; margin: 0;">No enrollments found matching your filter criteria.</p>
            </asp:Panel>
        </div>
    </div>

</asp:Content>
