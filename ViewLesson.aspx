<%@ Page Title="View Lesson" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewLesson.aspx.cs" Inherits="Codelecta_2._0.ViewLesson" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="background: var(--bg-page); min-height: calc(100vh - 76px); padding: 36px 0 80px 0;">
        <div class="container" style="max-width: 960px; margin: 0 auto; padding: 0 20px;">
            
            <!-- Breadcrumbs & Course Progress Overview -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; flex-wrap: wrap; gap: 14px;">
                <a id="lnkBack" runat="server" style="display: inline-flex; align-items: center; gap: 6px; color: var(--primary); font-weight: 700; text-decoration: none; font-size: 0.92rem;">
                    &larr; Back to Course Curriculum
                </a>

                <!-- Lesson Progress Pill & Indicator -->
                <div style="display: inline-flex; align-items: center; gap: 12px; background: #FFFFFF; border: 1px solid var(--border); padding: 6px 16px; border-radius: var(--radius-full); box-shadow: var(--shadow-sm);">
                    <span style="font-size: 0.82rem; font-weight: 700; color: var(--text-secondary);">Course Progress</span>
                    <div style="width: 100px; height: 7px; background: var(--border-light); border-radius: 10px; overflow: hidden;">
                        <div id="divProgressFill" runat="server" style="height: 100%; background: linear-gradient(90deg, #6C5CE7, #10B981); border-radius: 10px; width: 0%;"></div>
                    </div>
                    <asp:Label ID="lblCourseProgressPct" runat="server" Text="0%" style="font-size: 0.82rem; font-weight: 800; color: #1E1B4B;" />
                </div>
            </div>

            <!-- Main Lesson Card -->
            <div class="feature-card" style="background: #FFFFFF; border-radius: 20px; border: 1px solid var(--border); box-shadow: var(--shadow-md); padding: 40px; margin-bottom: 24px;">
                
                <!-- Lesson Header -->
                <div style="display: flex; justify-content: space-between; align-items: flex-start; gap: 20px; margin-bottom: 28px; border-bottom: 1px solid var(--border-light); padding-bottom: 24px; flex-wrap: wrap;">
                    <div style="display: flex; align-items: center; gap: 16px;">
                        <span style="background: var(--gradient-primary); color: white; width: 44px; height: 44px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 1.1rem; flex-shrink: 0; box-shadow: var(--shadow-sm);">
                            <asp:Label ID="lblOrder" runat="server"></asp:Label>
                        </span>
                        <div>
                            <span style="display: inline-block; font-size: 0.76rem; font-weight: 800; letter-spacing: 1.2px; text-transform: uppercase; color: var(--primary); margin-bottom: 4px;">
                                LESSON <asp:Label ID="lblOrderSubtitle" runat="server"></asp:Label>
                            </span>
                            <h1 style="color: var(--text-primary); font-size: 1.85rem; font-weight: 800; margin: 0; letter-spacing: -0.02em;">
                                <asp:Label ID="lblTitle" runat="server"></asp:Label>
                            </h1>
                        </div>
                    </div>

                    <!-- Completion Status Badge -->
                    <div>
                        <asp:Panel ID="pnlBadgeCompleted" runat="server" Visible="false"
                            style="display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; background: #ECFDF5; border: 1px solid #6EE7B7; color: #065F46; border-radius: 20px; font-weight: 700; font-size: 0.85rem;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>
                            Completed
                        </asp:Panel>
                        <asp:Panel ID="pnlBadgeIncomplete" runat="server" Visible="true"
                            style="display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; background: #FFFBEB; border: 1px solid #FDE68A; color: #92400E; border-radius: 20px; font-weight: 700; font-size: 0.85rem;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                            In Progress
                        </asp:Panel>
                    </div>
                </div>

                <!-- Video Embed (if available) -->
                <asp:Panel ID="pnlVideo" runat="server" Visible="false" style="margin-bottom: 32px;">
                    <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 16px; box-shadow: var(--shadow-sm); border: 1px solid var(--border);">
                        <iframe id="videoFrame" runat="server" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none;" allowfullscreen="true"></iframe>
                    </div>
                </asp:Panel>

                <!-- Lesson Body Text / Content -->
                <div style="color: var(--text-secondary); font-size: 1.05rem; line-height: 1.85; margin-bottom: 40px;">
                    <asp:Literal ID="litContent" runat="server"></asp:Literal>
                </div>

                <!-- Bottom Action & Navigation Bar -->
                <div style="padding-top: 24px; border-top: 1px solid var(--border-light); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 16px;">
                    
                    <!-- Previous Lesson Button -->
                    <div>
                        <asp:HyperLink ID="lnkPrevLesson" runat="server" Visible="false"
                            style="display: inline-flex; align-items: center; gap: 8px; padding: 10px 22px; background: #FFFFFF; color: #475569; border: 1px solid var(--border); border-radius: 10px; font-weight: 700; font-size: 0.9rem; text-decoration: none; transition: all 0.2s ease;">
                            &larr; Previous Lesson
                        </asp:HyperLink>
                    </div>

                    <!-- Center / Right Actions: Mark as Complete / Next Lesson -->
                    <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                        <asp:Button ID="btnMarkComplete" runat="server" Text="✓ Mark as Completed"
                            OnClick="btnMarkComplete_Click"
                            style="padding: 11px 26px; background: linear-gradient(135deg, #10B981 0%, #059669 100%); color: #FFFFFF; border: none; border-radius: 10px; font-weight: 700; font-size: 0.92rem; cursor: pointer; box-shadow: 0 4px 14px rgba(16, 185, 129, 0.25); font-family: inherit;" />

                        <asp:Button ID="btnMarkIncomplete" runat="server" Text="Mark as Incomplete" Visible="false"
                            OnClick="btnMarkIncomplete_Click"
                            style="padding: 10px 20px; background: #F8FAFC; color: #64748B; border: 1px solid var(--border); border-radius: 10px; font-weight: 600; font-size: 0.88rem; cursor: pointer; font-family: inherit;" />

                        <asp:HyperLink ID="lnkNextLesson" runat="server" Visible="false"
                            style="display: inline-flex; align-items: center; gap: 8px; padding: 11px 26px; background: linear-gradient(135deg, #6C5CE7 0%, #A855F7 100%); color: #FFFFFF; border-radius: 10px; font-weight: 700; font-size: 0.92rem; text-decoration: none; box-shadow: 0 4px 14px rgba(108, 92, 231, 0.25); transition: all 0.2s ease;">
                            Next Lesson &rarr;
                        </asp:HyperLink>

                        <asp:HyperLink ID="lnkFinishCourse" runat="server" Visible="false"
                            style="display: inline-flex; align-items: center; gap: 8px; padding: 11px 26px; background: linear-gradient(135deg, #6C5CE7 0%, #10B981 100%); color: #FFFFFF; border-radius: 10px; font-weight: 700; font-size: 0.92rem; text-decoration: none; box-shadow: 0 4px 14px rgba(108, 92, 231, 0.25);">
                            🎉 Back to Dashboard
                        </asp:HyperLink>
                    </div>

                </div>

            </div>

            <!-- Course Curriculum Accordion / Quick List at bottom -->
            <div style="background: #FFFFFF; border-radius: 16px; border: 1px solid var(--border); padding: 24px; box-shadow: var(--shadow-sm);">
                <h3 style="font-size: 1.05rem; font-weight: 700; color: #1E1B4B; margin: 0 0 16px 0;">Lessons in this Course</h3>
                <div style="display: flex; flex-direction: column; gap: 8px;">
                    <asp:Repeater ID="rptOtherLessons" runat="server">
                        <ItemTemplate>
                            <a href='ViewLesson.aspx?id=<%# Eval("Id") %>' 
                                style='<%# (int)Eval("Id") == CurrentLessonId ? "background: #F5F3FF; border: 1.5px solid #C4B5FD; color: #6C5CE7;" : ((bool)Eval("IsCompleted") ? "background: #F0FDF4; border: 1px solid #BBF7D0; color: #166534;" : "background: #FAFAFA; border: 1px solid #EDE9FE; color: #475569;") %> display: flex; align-items: center; justify-content: space-between; padding: 12px 18px; border-radius: 10px; text-decoration: none; font-size: 0.9rem; font-weight: 600; transition: all 0.2s;'>
                                <div style="display: flex; align-items: center; gap: 12px;">
                                    <span style='<%# (bool)Eval("IsCompleted") ? "background: #10B981; color: white;" : ((int)Eval("Id") == CurrentLessonId ? "background: #6C5CE7; color: white;" : "background: #E2E8F0; color: #64748B;") %> width: 26px; height: 26px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 0.78rem; font-weight: 800;'>
                                        <%# (bool)Eval("IsCompleted") ? "✓" : Eval("OrderIndex") %>
                                    </span>
                                    <span><%# Eval("Title") %></span>
                                    <%# (int)Eval("Id") == CurrentLessonId ? "<span style='padding: 2px 8px; background: #6C5CE7; color: white; border-radius: 20px; font-size: 0.7rem; font-weight: 700;'>CURRENT</span>" : "" %>
                                </div>
                                <span style="font-size: 0.8rem; opacity: 0.8;">
                                    <%# (bool)Eval("IsCompleted") ? "Completed" : "Start &rarr;" %>
                                </span>
                            </a>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
