<%@ Page Title="Manage Quizzes" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageQuizzes.aspx.cs" Inherits="Codelecta_2._0.Admin.ManageQuizzes" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PageTitleContent" runat="server">
    Manage Quizzes
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ==================== TOP STATS ROW ==================== -->
    <div style="display:grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 28px;">
        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background: rgba(108, 92, 231, 0.12); color: #6C5CE7;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10"></circle>
                    <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
                    <line x1="12" y1="17" x2="12.01" y2="17"></line>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">Total Quizzes</span>
                <span class="stat-value"><asp:Label ID="lblTotalQuizzes" runat="server" Text="0" /></span>
            </div>
        </div>

        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background: rgba(16, 185, 129, 0.12); color: #10B981;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                    <polyline points="14 2 14 8 20 8"></polyline>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">Total Questions</span>
                <span class="stat-value"><asp:Label ID="lblTotalQuestions" runat="server" Text="0" /></span>
            </div>
        </div>

        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background: rgba(245, 158, 11, 0.12); color: #F59E0B;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
                    <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">Student Attempts</span>
                <span class="stat-value"><asp:Label ID="lblTotalAttempts" runat="server" Text="0" /></span>
            </div>
        </div>

        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background: rgba(59, 130, 246, 0.12); color: #3B82F6;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="8" r="7"></circle>
                    <polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">Pass Rate</span>
                <span class="stat-value"><asp:Label ID="lblPassRate" runat="server" Text="0%" /></span>
            </div>
        </div>
    </div>

    <!-- ==================== STATUS FEEDBACK ==================== -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" style="margin-bottom: 20px; padding: 13px 20px; border-radius: 10px; font-weight: 600; font-size: 0.9rem;">
        <asp:Label ID="lblActionMessage" runat="server" />
    </asp:Panel>

    <!-- ==================== CREATE / EDIT QUIZ FORM ==================== -->
    <div class="admin-table-card" style="margin-bottom: 28px; padding: 28px;">
        <h3 style="font-size: 1.1rem; font-weight: 800; color: #1E1B4B; margin: 0 0 20px 0;">Create New Quiz</h3>
        
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 16px;">
            <div>
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Course</label>
                <asp:DropDownList ID="ddlCourses" runat="server"
                    style="width: 100%; padding: 10px 14px; border: 1px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA;" />
            </div>
            <div>
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Quiz Title</label>
                <asp:TextBox ID="txtQuizTitle" runat="server" placeholder="e.g. Python Basics Mastery Quiz"
                    style="width: 100%; padding: 10px 14px; border: 1px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
            </div>
        </div>

        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 20px; margin-bottom: 24px;">
            <div>
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Description</label>
                <asp:TextBox ID="txtQuizDescription" runat="server" placeholder="Test your fundamental knowledge..." TextMode="MultiLine" Rows="2"
                    style="width: 100%; padding: 10px 14px; border: 1px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
            </div>
            <div>
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Passing Score (%)</label>
                <asp:TextBox ID="txtPassingScore" runat="server" Text="70" TextMode="Number"
                    style="width: 100%; padding: 10px 14px; border: 1px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
            </div>
        </div>

        <asp:Button ID="btnCreateQuiz" runat="server" Text="Create Quiz" OnClick="btnCreateQuiz_Click"
            style="padding: 11px 28px; background: linear-gradient(135deg, #6C5CE7, #A855F7); color: #FFFFFF; border: none; border-radius: 8px; font-weight: 700; font-size: 0.92rem; cursor: pointer; box-shadow: 0 4px 14px rgba(108, 92, 231, 0.25);" />
    </div>

    <!-- ==================== EXISTING QUIZZES LIST ==================== -->
    <div class="admin-table-card">
        <div style="padding: 20px 24px 0; display: flex; align-items: center; justify-content: space-between;">
            <h3 style="font-size: 1.05rem; font-weight: 700; color: #1E1B4B; margin: 0;">
                All Published Quizzes
                <span style="margin-left: 10px; padding: 3px 11px; background: #F3F0FF; color: #6C5CE7; border-radius: 20px; font-size: 0.75rem; font-weight: 800;">
                    <asp:Label ID="lblQuizCount" runat="server" Text="0" /> quizzes
                </span>
            </h3>
        </div>

        <div style="overflow-x: auto; margin-top: 14px;">
            <asp:Repeater ID="rptQuizzes" runat="server" OnItemCommand="rptQuizzes_ItemCommand">
                <HeaderTemplate>
                    <table style="width: 100%; border-collapse: collapse; font-size: 0.88rem;">
                        <thead>
                            <tr style="background: #F8F7FF; border-bottom: 2px solid #EDE9FE;">
                                <th style="padding: 11px 20px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Quiz Title</th>
                                <th style="padding: 11px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Course</th>
                                <th style="padding: 11px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Questions</th>
                                <th style="padding: 11px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Passing Req</th>
                                <th style="padding: 11px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Attempts</th>
                                <th style="padding: 11px 16px; text-align: center; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr style='<%# Container.ItemIndex % 2 == 0 ? "background:#FFFFFF;" : "background:#FAFAFA;" %> border-bottom: 1px solid #F1F0FB;'>
                        <td style="padding: 14px 20px;">
                            <div style="font-weight: 700; color: #1E1B4B; font-size: 0.92rem;"><%# Eval("Title") %></div>
                            <div style="font-size: 0.78rem; color: #94A3B8;"><%# Eval("Description") %></div>
                        </td>
                        <td style="padding: 14px 16px;">
                            <span style="padding: 3px 10px; background: #F3F0FF; color: #6C5CE7; border: 1px solid #DDD6FE; border-radius: 20px; font-weight: 700; font-size: 0.78rem;">
                                <%# Eval("CourseTitle") %>
                            </span>
                        </td>
                        <td style="padding: 14px 16px; font-weight: 700; color: #1E1B4B;">
                            <%# Eval("QuestionCount") %> questions
                        </td>
                        <td style="padding: 14px 16px;">
                            <span style="font-weight: 700; color: #10B981;"><%# Eval("PassingScorePercent") %>%</span>
                        </td>
                        <td style="padding: 14px 16px; color: #475569;">
                            <%# Eval("AttemptCount") %> submissions
                        </td>
                        <td style="padding: 14px 16px; text-align: center;">
                            <div style="display: inline-flex; gap: 8px; align-items: center;">
                                <a href='../TakeQuiz.aspx?quizId=<%# Eval("Id") %>' target="_blank"
                                    style="padding: 5px 12px; background: #ECFDF5; color: #059669; border: 1px solid #A7F3D0; border-radius: 6px; font-size: 0.78rem; font-weight: 700; text-decoration: none;">
                                    Preview
                                </a>
                                <asp:LinkButton ID="lbtnDeleteQuiz" runat="server" CommandName="DeleteQuiz" CommandArgument='<%# Eval("Id") %>'
                                    OnClientClick="return confirm('Are you sure you want to delete this quiz?');"
                                    style="padding: 5px 12px; background: #FEF2F2; color: #EF4444; border: 1px solid #FECACA; border-radius: 6px; font-size: 0.78rem; font-weight: 700; text-decoration: none;">
                                    Delete
                                </asp:LinkButton>
                            </div>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlNoQuizzes" runat="server" Visible="false" style="text-align: center; padding: 60px 20px; color: #94A3B8;">
                <svg xmlns="http://www.w3.org/2000/svg" width="44" height="44" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 12px; opacity: 0.35;">
                    <circle cx="12" cy="12" r="10"></circle>
                    <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
                    <line x1="12" y1="17" x2="12.01" y2="17"></line>
                </svg>
                <p style="font-weight: 600; font-size: 0.95rem; margin: 0;">No quizzes created yet. Use the form above to add your first quiz.</p>
            </asp:Panel>
        </div>
    </div>

</asp:Content>
