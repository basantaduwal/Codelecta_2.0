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
    <div class="admin-table-card" style="margin-bottom: 32px; border-left: 4px solid var(--primary);">
        <div style="padding: 24px 28px; background: linear-gradient(180deg, #FAF9FF 0%, #FFFFFF 100%); border-bottom: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center;">
            <div style="display: flex; align-items: center; gap: 14px;">
                <div style="width: 42px; height: 42px; border-radius: 12px; background: rgba(108, 92, 231, 0.12); color: #6C5CE7; display: flex; align-items: center; justify-content: center; font-size: 1.25rem;">
                    ✨
                </div>
                <div>
                    <h3 style="font-size: 1.15rem; font-weight: 800; color: #1E1B4B; margin: 0 0 2px 0;">
                        <asp:Label ID="lblFormTitle" runat="server" Text="Create New Course" />
                    </h3>
                    <p style="color: #64748B; font-size: 0.85rem; margin: 0;">Add learning curriculum, badge tags, and difficulty tracks.</p>
                </div>
            </div>
            <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel Edit" Visible="false" OnClick="btnCancelEdit_Click"
                CssClass="admin-btn-action btn-action-secondary" style="cursor: pointer;" />
        </div>

        <div style="padding: 28px;">
            <asp:HiddenField ID="hfEditingCourseId" runat="server" Value="0" />

            <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 20px; margin-bottom: 20px;">
                <div>
                    <label class="admin-form-label">
                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path></svg>
                        Course Title
                    </label>
                    <asp:TextBox ID="txtCourseTitle" runat="server" placeholder="e.g. Advanced C# Architecture"
                        CssClass="admin-form-input" />
                    <asp:RequiredFieldValidator ID="rfvCourseTitle" runat="server" ControlToValidate="txtCourseTitle"
                        ErrorMessage="Course title is required." Display="Dynamic" ValidationGroup="CourseForm"
                        style="color: #DC2626; font-size: 0.78rem; font-weight: 600; margin-top: 5px; display: block;" />
                </div>
                <div>
                    <label class="admin-form-label">
                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                        Difficulty Level
                    </label>
                    <asp:DropDownList ID="ddlCourseLevel" runat="server" CssClass="admin-form-input" style="cursor: pointer;">
                        <asp:ListItem Value="Beginner"     Text="🌱 Beginner" />
                        <asp:ListItem Value="Intermediate" Text="⚡ Intermediate" />
                        <asp:ListItem Value="Professional" Text="🚀 Professional" />
                    </asp:DropDownList>
                </div>
            </div>

            <div style="margin-bottom: 20px;">
                <label class="admin-form-label">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="21" y1="10" x2="3" y2="10"></line><line x1="21" y1="6" x2="3" y2="6"></line><line x1="21" y1="14" x2="3" y2="14"></line><line x1="21" y1="18" x2="3" y2="18"></line></svg>
                    Description
                </label>
                <asp:TextBox ID="txtCourseDescription" runat="server" TextMode="MultiLine" Rows="3" placeholder="What key concepts and skills will students learn?"
                    CssClass="admin-form-input" style="resize: vertical;" />
                <asp:RequiredFieldValidator ID="rfvCourseDescription" runat="server" ControlToValidate="txtCourseDescription"
                    ErrorMessage="Course description is required." Display="Dynamic" ValidationGroup="CourseForm"
                    style="color: #DC2626; font-size: 0.78rem; font-weight: 600; margin-top: 5px; display: block;" />
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 24px;">
                <div>
                    <label class="admin-form-label">
                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path><line x1="7" y1="7" x2="7.01" y2="7"></line></svg>
                        Badge Tag Symbol
                    </label>
                    <asp:TextBox ID="txtImageTag" runat="server" Text="C#" placeholder="e.g. C#, JS, Py, SQL, ⚛️"
                        CssClass="admin-form-input" />
                </div>
                <div>
                    <label class="admin-form-label">
                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><circle cx="12" cy="12" r="4"></circle></svg>
                        Badge Color Theme
                    </label>
                    <asp:DropDownList ID="ddlBadgeClass" runat="server" CssClass="admin-form-input" style="cursor: pointer;">
                        <asp:ListItem Value="csharp-badge"     Text="🟣 Violet / C# Theme" />
                        <asp:ListItem Value="python-badge"     Text="🔵 Amber / Python Theme" />
                        <asp:ListItem Value="js-badge"         Text="🟡 Yellow / JavaScript Theme" />
                        <asp:ListItem Value="react-badge"      Text="🟢 Sky / React Theme" />
                        <asp:ListItem Value="html-badge"       Text="🟠 Orange / HTML & CSS Theme" />
                        <asp:ListItem Value="java-badge"       Text="🔴 Rose / Java Theme" />
                        <asp:ListItem Value="dsa-badge"        Text="🌿 Emerald / DSA Theme" />
                        <asp:ListItem Value="sys-badge"        Text="⚪ Slate / Systems Theme" />
                    </asp:DropDownList>
                </div>
            </div>

            <div style="display: flex; align-items: center; gap: 14px;">
                <asp:Button ID="btnSaveCourse" runat="server" Text="Create Course" OnClick="btnSaveCourse_Click" ValidationGroup="CourseForm"
                    OnClientClick="if (typeof(Page_ClientValidate) === 'function' && !Page_ClientValidate('CourseForm')) return false; this.disabled=true; this.value='Saving Course...'; __doPostBack(this.name, ''); return false;"
                    style="padding: 11px 28px; background: linear-gradient(135deg, #6C5CE7, #A855F7); color: #FFFFFF; border: none; border-radius: 10px; font-weight: 700; font-size: 0.92rem; cursor: pointer; box-shadow: 0 4px 14px rgba(108, 92, 231, 0.28); transition: all 0.2s ease;" />
            </div>
        </div>
    </div>

    <!-- ==================== EXISTING COURSES TABLE ==================== -->
    <div class="admin-table-card">
        <div style="padding: 22px 28px; display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid var(--border); background: #FFFFFF;">
            <div style="display: flex; align-items: center; gap: 12px;">
                <div style="width: 36px; height: 36px; border-radius: 10px; background: #F3F0FF; display: flex; align-items: center; justify-content: center; color: #6C5CE7; font-size: 1.1rem;">
                    📚
                </div>
                <div>
                    <h3 style="font-size: 1.05rem; font-weight: 800; color: #1E1B4B; margin: 0;">
                        All Published Courses
                    </h3>
                    <span style="font-size: 0.8rem; color: #64748B;">Total catalog offerings available to learners</span>
                </div>
            </div>
            <span style="padding: 4px 12px; background: #F3F0FF; color: #6C5CE7; border: 1px solid #DDD6FE; border-radius: 999px; font-size: 0.78rem; font-weight: 800;">
                <asp:Label ID="lblCourseCount" runat="server" Text="0" /> courses
            </span>
        </div>

        <div style="overflow-x: auto;">
            <asp:Repeater ID="rptCourses" runat="server" OnItemCommand="rptCourses_ItemCommand">
                <HeaderTemplate>
                    <table style="width: 100%; border-collapse: collapse; font-size: 0.88rem;">
                        <thead>
                            <tr style="background: #F8F7FF; border-bottom: 2px solid #EDE9FE;">
                                <th style="padding: 13px 24px; text-align: left; font-weight: 700; color: #475569; font-size: 0.75rem; letter-spacing: 0.6px; text-transform: uppercase;">Course</th>
                                <th style="padding: 13px 18px; text-align: left; font-weight: 700; color: #475569; font-size: 0.75rem; letter-spacing: 0.6px; text-transform: uppercase;">Level</th>
                                <th style="padding: 13px 18px; text-align: left; font-weight: 700; color: #475569; font-size: 0.75rem; letter-spacing: 0.6px; text-transform: uppercase;">Lessons</th>
                                <th style="padding: 13px 18px; text-align: left; font-weight: 700; color: #475569; font-size: 0.75rem; letter-spacing: 0.6px; text-transform: uppercase;">Enrollments</th>
                                <th style="padding: 13px 18px; text-align: left; font-weight: 700; color: #475569; font-size: 0.75rem; letter-spacing: 0.6px; text-transform: uppercase;">Created</th>
                                <th style="padding: 13px 20px; text-align: center; font-weight: 700; color: #475569; font-size: 0.75rem; letter-spacing: 0.6px; text-transform: uppercase;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr style='<%# Container.ItemIndex % 2 == 0 ? "background:#FFFFFF;" : "background:#FAFAFC;" %> border-bottom: 1px solid #F1F0FB; transition: background 0.15s ease;'>
                        
                        <td style="padding: 15px 24px;">
                            <div style="display: flex; align-items: center; gap: 14px;">
                                <div style="width: 42px; height: 42px; border-radius: 10px; background: #F3F0FF; display: flex; align-items: center; justify-content: center; font-weight: 800; color: #6C5CE7; font-size: 0.95rem; flex-shrink: 0; border: 1px solid #EDE9FE; box-shadow: 0 2px 6px rgba(108, 92, 231, 0.08);">
                                    <%# Eval("ImageTag") %>
                                </div>
                                <div>
                                    <div style="font-weight: 700; color: #1E1B4B; font-size: 0.94rem;"><%# Eval("Title") %></div>
                                    <div style="font-size: 0.8rem; color: #64748B; max-width: 320px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; margin-top: 2px;"><%# Eval("Description") %></div>
                                </div>
                            </div>
                        </td>

                        <td style="padding: 15px 18px;">
                            <span style='<%# Eval("Level").ToString() == "Beginner" ? "background:#ECFDF5; color:#065F46; border:1px solid #A7F3D0;" : Eval("Level").ToString() == "Intermediate" ? "background:#F5F3FF; color:#5B21B6; border:1px solid #DDD6FE;" : "background:#FFFBEB; color:#92400E; border:1px solid #FDE68A;" %> padding: 4px 11px; border-radius: 999px; font-weight: 700; font-size: 0.74rem;'>
                                <%# Eval("Level") %>
                            </span>
                        </td>

                        <td style="padding: 15px 18px; font-weight: 700; color: #1E1B4B;">
                            <span style="display: inline-flex; align-items: center; gap: 6px;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                                <%# Eval("LessonCount") %> lessons
                            </span>
                        </td>

                        <td style="padding: 15px 18px; color: #475569; font-weight: 600;">
                            <%# Eval("EnrollmentCount") %> students
                        </td>

                        <td style="padding: 15px 18px; color: #94A3B8; font-size: 0.82rem;">
                            <%# Eval("CreatedDate", "{0:MMM dd, yyyy}") %>
                        </td>

                        <td style="padding: 15px 20px; text-align: center;">
                            <div style="display: inline-flex; gap: 8px; align-items: center;">
                                <a href='ManageLessons.aspx?courseId=<%# Eval("Id") %>' class="admin-btn-action btn-action-primary">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/></svg>
                                    Lessons
                                </a>

                                <asp:LinkButton ID="lbtnEditCourse" runat="server" CommandName="EditCourse" CommandArgument='<%# Eval("Id") %>'
                                    CssClass="admin-btn-action btn-action-secondary">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path></svg>
                                    Edit
                                </asp:LinkButton>

                                <asp:LinkButton ID="lbtnDeleteCourse" runat="server" CommandName="DeleteCourse" CommandArgument='<%# Eval("Id") %>'
                                    OnClientClick="return confirm('Are you sure you want to delete this course and all associated lessons/quizzes?');"
                                    CssClass="admin-btn-action btn-action-danger">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
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
