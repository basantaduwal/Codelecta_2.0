<%@ Page Title="Manage Courses" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageCourses.aspx.cs" Inherits="Codelecta_2._0.Admin.ManageCourses" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PageTitleContent" runat="server">
    Manage Courses
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ==================== TOP METRICS ==================== -->
    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 28px;">
        <div class="admin-stat-card">
            <div class="stat-icon-wrap" style="background: rgba(108, 92, 231, 0.12); color: #6C5CE7;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                    <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
                </svg>
            </div>
            <div class="stat-body">
                <span class="stat-label">Total Courses</span>
                <span class="stat-value"><asp:Label ID="lblTotalCourses" runat="server" Text="0" /></span>
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
                <span class="stat-label">Total Lessons</span>
                <span class="stat-value"><asp:Label ID="lblTotalLessons" runat="server" Text="0" /></span>
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
                <span class="stat-label">Total Enrollments</span>
                <span class="stat-value"><asp:Label ID="lblTotalEnrollments" runat="server" Text="0" /></span>
            </div>
        </div>
    </div>

    <!-- ==================== STATUS FEEDBACK ==================== -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" style="margin-bottom: 24px; padding: 13px 20px; border-radius: 10px; font-weight: 600; font-size: 0.9rem;">
        <asp:Label ID="lblActionMessage" runat="server" />
    </asp:Panel>

    <!-- ==================== CREATE / EDIT COURSE CARD ==================== -->
    <div class="admin-table-card" style="margin-bottom: 32px; padding: 32px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 22px;">
            <div>
                <h3 style="font-size: 1.15rem; font-weight: 800; color: #1E1B4B; margin: 0 0 4px 0;">
                    <asp:Label ID="lblFormTitle" runat="server" Text="Create New Course" />
                </h3>
                <p style="color: #64748B; font-size: 0.88rem; margin: 0;">Add learning curriculum, badge tags, and difficulty tracks.</p>
            </div>
            <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel Edit" Visible="false" OnClick="btnCancelEdit_Click"
                style="padding: 8px 16px; background: #F8FAFC; color: #64748B; border: 1px solid #E2E8F0; border-radius: 8px; font-weight: 600; font-size: 0.82rem; cursor: pointer;" />
        </div>

        <asp:HiddenField ID="hfEditingCourseId" runat="server" Value="0" />

        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 20px; margin-bottom: 18px;">
            <div>
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Course Title</label>
                <asp:TextBox ID="txtCourseTitle" runat="server" placeholder="e.g. Advanced C# Architecture"
                    style="width: 100%; padding: 10px 14px; border: 1.5px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
            </div>
            <div>
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Difficulty Level</label>
                <asp:DropDownList ID="ddlCourseLevel" runat="server"
                    style="width: 100%; padding: 10px 14px; border: 1.5px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; cursor: pointer;">
                    <asp:ListItem Value="Beginner"     Text="Beginner" />
                    <asp:ListItem Value="Intermediate" Text="Intermediate" />
                    <asp:ListItem Value="Professional" Text="Professional" />
                </asp:DropDownList>
            </div>
        </div>

        <div style="margin-bottom: 18px;">
            <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Description</label>
            <asp:TextBox ID="txtCourseDescription" runat="server" TextMode="MultiLine" Rows="3" placeholder="What key concepts and skills will students learn?"
                style="width: 100%; padding: 10px 14px; border: 1.5px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 24px;">
            <div>
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Badge Tag Symbol</label>
                <asp:TextBox ID="txtImageTag" runat="server" Text="C#" placeholder="e.g. C#, JS, Py, SQL, ⚛️"
                    style="width: 100%; padding: 10px 14px; border: 1.5px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
            </div>
            <div>
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Badge Color Theme</label>
                <asp:DropDownList ID="ddlBadgeClass" runat="server"
                    style="width: 100%; padding: 10px 14px; border: 1.5px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; cursor: pointer;">
                    <asp:ListItem Value="csharp-badge"     Text="🟣 Violet / C# Theme" />
                    <asp:ListItem Value="python-badge"     Text="🔵 Blue / Python Theme" />
                    <asp:ListItem Value="js-badge"         Text="🟡 Amber / JavaScript Theme" />
                    <asp:ListItem Value="react-badge"      Text="🟢 Emerald / React Theme" />
                </asp:DropDownList>
            </div>
        </div>

        <asp:Button ID="btnSaveCourse" runat="server" Text="Create Course" OnClick="btnSaveCourse_Click"
            style="padding: 11px 28px; background: linear-gradient(135deg, #6C5CE7, #A855F7); color: #FFFFFF; border: none; border-radius: 8px; font-weight: 700; font-size: 0.92rem; cursor: pointer; box-shadow: 0 4px 14px rgba(108, 92, 231, 0.25);" />
    </div>

    <!-- ==================== EXISTING COURSES TABLE ==================== -->
    <div class="admin-table-card">
        <div style="padding: 20px 24px 0; display: flex; align-items: center; justify-content: space-between;">
            <h3 style="font-size: 1.05rem; font-weight: 700; color: #1E1B4B; margin: 0;">
                All Published Courses
                <span style="margin-left: 10px; padding: 3px 11px; background: #F3F0FF; color: #6C5CE7; border-radius: 20px; font-size: 0.75rem; font-weight: 800;">
                    <asp:Label ID="lblCourseCount" runat="server" Text="0" /> courses
                </span>
            </h3>
        </div>

        <div style="overflow-x: auto; margin-top: 14px;">
            <asp:Repeater ID="rptCourses" runat="server" OnItemCommand="rptCourses_ItemCommand">
                <HeaderTemplate>
                    <table style="width: 100%; border-collapse: collapse; font-size: 0.88rem;">
                        <thead>
                            <tr style="background: #F8F7FF; border-bottom: 2px solid #EDE9FE;">
                                <th style="padding: 12px 20px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Course</th>
                                <th style="padding: 12px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Level</th>
                                <th style="padding: 12px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Lessons</th>
                                <th style="padding: 12px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Enrollments</th>
                                <th style="padding: 12px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Created</th>
                                <th style="padding: 12px 16px; text-align: center; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr style='<%# Container.ItemIndex % 2 == 0 ? "background:#FFFFFF;" : "background:#FAFAFA;" %> border-bottom: 1px solid #F1F0FB;'>
                        
                        <td style="padding: 14px 20px;">
                            <div style="display: flex; align-items: center; gap: 12px;">
                                <div style="width: 38px; height: 38px; border-radius: 8px; background: #F3F0FF; display: flex; align-items: center; justify-content: center; font-weight: 800; color: #6C5CE7; font-size: 0.9rem; flex-shrink: 0; border: 1px solid #EDE9FE;">
                                    <%# Eval("ImageTag") %>
                                </div>
                                <div>
                                    <div style="font-weight: 700; color: #1E1B4B; font-size: 0.92rem;"><%# Eval("Title") %></div>
                                    <div style="font-size: 0.78rem; color: #94A3B8; max-width: 320px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%# Eval("Description") %></div>
                                </div>
                            </div>
                        </td>

                        <td style="padding: 14px 16px;">
                            <span style="padding: 3px 10px; background: #FAF9FF; color: #6C5CE7; border: 1px solid #DDD6FE; border-radius: 20px; font-weight: 700; font-size: 0.75rem;">
                                <%# Eval("Level") %>
                            </span>
                        </td>

                        <td style="padding: 14px 16px; font-weight: 700; color: #1E1B4B;">
                            <%# Eval("LessonCount") %> lessons
                        </td>

                        <td style="padding: 14px 16px; color: #475569;">
                            <%# Eval("EnrollmentCount") %> students
                        </td>

                        <td style="padding: 14px 16px; color: #94A3B8; font-size: 0.82rem;">
                            <%# Eval("CreatedDate", "{0:MMM dd, yyyy}") %>
                        </td>

                        <td style="padding: 14px 16px; text-align: center;">
                            <div style="display: inline-flex; gap: 6px; align-items: center;">
                                <a href='ManageLessons.aspx?courseId=<%# Eval("Id") %>'
                                    style="padding: 5px 12px; background: #F3F0FF; color: #6C5CE7; border: 1px solid #DDD6FE; border-radius: 6px; font-size: 0.78rem; font-weight: 700; text-decoration: none;">
                                    Lessons
                                </a>

                                <asp:LinkButton ID="lbtnEditCourse" runat="server" CommandName="EditCourse" CommandArgument='<%# Eval("Id") %>'
                                    style="padding: 5px 12px; background: #FAF9FF; color: #475569; border: 1px solid #CBD5E1; border-radius: 6px; font-size: 0.78rem; font-weight: 700; text-decoration: none;">
                                    Edit
                                </asp:LinkButton>

                                <asp:LinkButton ID="lbtnDeleteCourse" runat="server" CommandName="DeleteCourse" CommandArgument='<%# Eval("Id") %>'
                                    OnClientClick="return confirm('Are you sure you want to delete this course and all associated lessons/quizzes?');"
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

            <asp:Panel ID="pnlNoCourses" runat="server" Visible="false" style="text-align: center; padding: 60px 20px; color: #94A3B8;">
                <p style="font-weight: 600; font-size: 0.95rem; margin: 0;">No courses created yet. Use the form above to add your first course.</p>
            </asp:Panel>
        </div>
    </div>

</asp:Content>
