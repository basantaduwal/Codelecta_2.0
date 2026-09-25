<%@ Page Title="Manage Lessons" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageLessons.aspx.cs" Inherits="Codelecta_2._0.Admin.ManageLessons" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PageTitleContent" runat="server">
    Manage Lessons
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ==================== TOP NAVIGATION / BREADCRUMB ==================== -->
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; flex-wrap: wrap; gap: 14px;">
        <div>
            <a href="ManageCourses.aspx" style="color: #6C5CE7; text-decoration: none; font-size: 0.9rem; font-weight: 700; display: inline-flex; align-items: center; gap: 6px;">
                &larr; Back to Courses
            </a>
            <h2 style="font-size: 1.6rem; font-weight: 800; color: #1E1B4B; margin: 8px 0 2px 0; letter-spacing: -0.02em;">
                <asp:Label ID="lblCourseTitle" runat="server"></asp:Label>
            </h2>
            <p style="color: #64748B; font-size: 0.9rem; margin: 0;">Create, edit, reorder, and manage lesson curriculum and video walkthroughs.</p>
        </div>
        <div style="background: #F3F0FF; padding: 6px 16px; border-radius: 20px; border: 1px solid #DDD6FE;">
            <span style="font-size: 0.85rem; font-weight: 800; color: #6C5CE7;"><asp:Label ID="lblLessonCountHeader" runat="server" Text="0" /> lessons</span>
        </div>
    </div>

    <!-- ==================== STATUS FEEDBACK ==================== -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" style="margin-bottom: 24px; padding: 13px 20px; border-radius: 10px; font-weight: 600; font-size: 0.9rem;">
        <asp:Label ID="lblActionMessage" runat="server" />
    </asp:Panel>

    <!-- ==================== ADD / EDIT LESSON FORM ==================== -->
    <div class="admin-table-card" style="margin-bottom: 32px; padding: 32px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <div>
                <h3 style="font-size: 1.15rem; font-weight: 800; color: #1E1B4B; margin: 0 0 4px 0;">
                    <asp:Label ID="lblFormHeading" runat="server" Text="Add New Lesson" />
                </h3>
                <p style="color: #64748B; font-size: 0.88rem; margin: 0;">Provide detailed explanations, code samples, and optional video tutorials.</p>
            </div>
            <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel Edit" Visible="false" OnClick="btnCancelEdit_Click"
                style="padding: 8px 16px; background: #F8FAFC; color: #64748B; border: 1px solid #E2E8F0; border-radius: 8px; font-weight: 600; font-size: 0.82rem; cursor: pointer;" />
        </div>

        <asp:HiddenField ID="hfEditingLessonId" runat="server" Value="0" />

        <div style="display: grid; grid-template-columns: 3fr 1fr; gap: 20px; margin-bottom: 18px;">
            <div>
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Lesson Title</label>
                <asp:TextBox ID="txtLessonTitle" runat="server" placeholder="e.g. Understanding Variables & Memory Allocation"
                    style="width: 100%; padding: 10px 14px; border: 1.5px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
                <asp:RequiredFieldValidator ID="rfvLessonTitle" runat="server" ControlToValidate="txtLessonTitle"
                    ErrorMessage="Lesson title is required." Display="Dynamic" ValidationGroup="LessonForm"
                    style="color: #DC2626; font-size: 0.78rem; font-weight: 600; margin-top: 4px; display: block;" />
            </div>
            <div>
                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Order Index</label>
                <asp:TextBox ID="txtOrder" runat="server" TextMode="Number" Text="1"
                    style="width: 100%; padding: 10px 14px; border: 1.5px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
            </div>
        </div>

        <div style="margin-bottom: 18px;">
            <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Video Tutorial URL (YouTube or direct embed URL - optional)</label>
            <asp:TextBox ID="txtVideoUrl" runat="server" placeholder="e.g. https://www.youtube.com/watch?v=dQw4w9WgXcQ"
                style="width: 100%; padding: 10px 14px; border: 1.5px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
            <span style="display: block; font-size: 0.76rem; color: #6C5CE7; margin-top: 4px; font-weight: 600;">
                💡 Interactive Chapters: You can list custom chapter timestamps in the content box (e.g., 00:00 - Overview, 02:30 - Concepts), or structured chapters will be automatically generated.
            </span>
        </div>

        <div style="margin-bottom: 24px;">
            <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Lesson Content & Code Samples</label>
            <asp:TextBox ID="txtLessonContent" runat="server" TextMode="MultiLine" Rows="8" placeholder="Write comprehensive markdown/text lesson content here..."
                style="width: 100%; padding: 12px 14px; border: 1.5px solid #EDE9FE; border-radius: 8px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box; line-height: 1.6;" />
            <asp:RequiredFieldValidator ID="rfvLessonContent" runat="server" ControlToValidate="txtLessonContent"
                ErrorMessage="Lesson content is required." Display="Dynamic" ValidationGroup="LessonForm"
                style="color: #DC2626; font-size: 0.78rem; font-weight: 600; margin-top: 4px; display: block;" />
        </div>

        <asp:Button ID="btnSaveLesson" runat="server" Text="Add Lesson" OnClick="btnSaveLesson_Click" ValidationGroup="LessonForm"
            OnClientClick="if (typeof(Page_ClientValidate) === 'function' && !Page_ClientValidate('LessonForm')) return false; this.disabled=true; this.value='Saving Lesson...'; __doPostBack(this.name, ''); return false;"
            style="padding: 11px 28px; background: linear-gradient(135deg, #6C5CE7, #A855F7); color: #FFFFFF; border: none; border-radius: 8px; font-weight: 700; font-size: 0.92rem; cursor: pointer; box-shadow: 0 4px 14px rgba(108, 92, 231, 0.25);" />
    </div>

    <!-- ==================== LESSONS LIST ==================== -->
    <div class="admin-table-card">
        <div style="padding: 20px 24px 0; display: flex; align-items: center; justify-content: space-between;">
            <h3 style="font-size: 1.05rem; font-weight: 700; color: #1E1B4B; margin: 0;">
                Curriculum Lessons
                <span style="margin-left: 10px; padding: 3px 11px; background: #F3F0FF; color: #6C5CE7; border-radius: 20px; font-size: 0.75rem; font-weight: 800;">
                    <asp:Label ID="lblTableCount" runat="server" Text="0" /> lessons
                </span>
            </h3>
        </div>

        <div style="overflow-x: auto; margin-top: 14px;">
            <asp:Repeater ID="rptLessons" runat="server" OnItemCommand="rptLessons_ItemCommand">
                <HeaderTemplate>
                    <table style="width: 100%; border-collapse: collapse; font-size: 0.88rem;">
                        <thead>
                            <tr style="background: #F8F7FF; border-bottom: 2px solid #EDE9FE;">
                                <th style="padding: 12px 20px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Order</th>
                                <th style="padding: 12px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Lesson Title</th>
                                <th style="padding: 12px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Video</th>
                                <th style="padding: 12px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Content Preview</th>
                                <th style="padding: 12px 16px; text-align: center; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Reorder</th>
                                <th style="padding: 12px 16px; text-align: center; font-weight: 700; color: #475569; font-size: 0.78rem; text-transform: uppercase;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr style='<%# Container.ItemIndex % 2 == 0 ? "background:#FFFFFF;" : "background:#FAFAFA;" %> border-bottom: 1px solid #F1F0FB;'>
                        
                        <!-- Order Badge -->
                        <td style="padding: 14px 20px;">
                            <span style="width: 30px; height: 30px; border-radius: 50%; background: #F3F0FF; color: #6C5CE7; display: inline-flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.85rem; border: 1px solid #DDD6FE;">
                                <%# Eval("OrderIndex") %>
                            </span>
                        </td>

                        <!-- Title -->
                        <td style="padding: 14px 16px; font-weight: 700; color: #1E1B4B; font-size: 0.92rem;">
                            <%# Eval("Title") %>
                        </td>

                        <!-- Video Pill -->
                        <td style="padding: 14px 16px;">
                            <%# !string.IsNullOrWhiteSpace(Convert.ToString(Eval("VideoUrl"))) 
                                ? "<span style='padding: 3px 10px; background: #ECFDF5; color: #059669; border: 1px solid #A7F3D0; border-radius: 20px; font-size: 0.75rem; font-weight: 700;'>🎬 Video Attached</span>"
                                : "<span style='color: #94A3B8; font-size: 0.78rem;'>-</span>" %>
                        </td>

                        <!-- Content Preview -->
                        <td style="padding: 14px 16px; color: #64748B; font-size: 0.82rem; max-width: 280px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                            <%# Eval("Content") %>
                        </td>

                        <!-- Reorder Up / Down -->
                        <td style="padding: 14px 16px; text-align: center;">
                            <div style="display: inline-flex; gap: 4px;">
                                <asp:LinkButton ID="lbtnMoveUp" runat="server" CommandName="MoveUp" CommandArgument='<%# Eval("Id") %>'
                                    title="Move Up" style="padding: 4px 8px; background: #F8FAFC; border: 1px solid #E2E8F0; border-radius: 6px; color: #475569; text-decoration: none; font-size: 0.8rem; font-weight: 700;">
                                    ▲
                                </asp:LinkButton>
                                <asp:LinkButton ID="lbtnMoveDown" runat="server" CommandName="MoveDown" CommandArgument='<%# Eval("Id") %>'
                                    title="Move Down" style="padding: 4px 8px; background: #F8FAFC; border: 1px solid #E2E8F0; border-radius: 6px; color: #475569; text-decoration: none; font-size: 0.8rem; font-weight: 700;">
                                    ▼
                                </asp:LinkButton>
                            </div>
                        </td>

                        <!-- Actions -->
                        <td style="padding: 14px 16px; text-align: center;">
                            <div style="display: inline-flex; gap: 6px; align-items: center;">
                                <a href='../ViewLesson.aspx?id=<%# Eval("Id") %>' target="_blank"
                                    style="padding: 5px 12px; background: #ECFDF5; color: #059669; border: 1px solid #A7F3D0; border-radius: 6px; font-size: 0.78rem; font-weight: 700; text-decoration: none;">
                                    Preview
                                </a>

                                <asp:LinkButton ID="lbtnEditLesson" runat="server" CommandName="EditLesson" CommandArgument='<%# Eval("Id") %>'
                                    style="padding: 5px 12px; background: #FAF9FF; color: #475569; border: 1px solid #CBD5E1; border-radius: 6px; font-size: 0.78rem; font-weight: 700; text-decoration: none;">
                                    Edit
                                </asp:LinkButton>

                                <asp:LinkButton ID="lbtnDeleteLesson" runat="server" CommandName="DeleteLesson" CommandArgument='<%# Eval("Id") %>'
                                    OnClientClick="return confirm('Are you sure you want to delete this lesson?');"
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

            <asp:Panel ID="pnlNoLessons" runat="server" Visible="false" style="text-align: center; padding: 60px 20px; color: #94A3B8;">
                <p style="font-weight: 600; font-size: 0.95rem; margin: 0;">No lessons created yet for this course. Use the form above to add your first lesson.</p>
            </asp:Panel>
        </div>
    </div>

</asp:Content>
