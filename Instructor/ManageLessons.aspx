<%@ Page Title="Manage Lessons" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageLessons.aspx.cs" Inherits="Codelecta_2._0.Instructor.ManageLessons" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container section-padding">
        <div class="section-header" style="margin-bottom: 40px;">
            <h2 class="section-title">
                <asp:Label ID="lblCourseTitle" runat="server"></asp:Label>
            </h2>
            <p class="section-subtitle">Add and manage lessons for this course.</p>
            <a href="ManageCourses.aspx" style="color: var(--primary-light); text-decoration: none; font-size: 0.95rem;">&larr; Back to My Courses</a>
        </div>

        <!-- Add New Lesson Form -->
        <div class="features-grid" style="grid-template-columns: 1fr; max-width: 800px; margin: 0 auto; margin-bottom: 40px;">
            <div class="feature-card">
                <h3 style="color: var(--text-primary); margin-bottom: 20px;">Add New Lesson</h3>
                <div class="form-group" style="margin-bottom: 15px;">
                    <label style="display: block; color: var(--text-secondary); margin-bottom: 5px;">Lesson Title</label>
                    <asp:TextBox ID="txtLessonTitle" runat="server" CssClass="form-control" placeholder="e.g. Introduction to Variables" Width="100%"></asp:TextBox>
                </div>
                <div class="form-group" style="margin-bottom: 15px;">
                    <label style="display: block; color: var(--text-secondary); margin-bottom: 5px;">Content</label>
                    <asp:TextBox ID="txtLessonContent" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="6" placeholder="Write the lesson content here..." Width="100%"></asp:TextBox>
                </div>
                <div class="form-group" style="margin-bottom: 15px;">
                    <label style="display: block; color: var(--text-secondary); margin-bottom: 5px;">Video URL (optional)</label>
                    <asp:TextBox ID="txtVideoUrl" runat="server" CssClass="form-control" placeholder="e.g. https://youtube.com/watch?v=..." Width="100%"></asp:TextBox>
                </div>
                <div class="form-group" style="margin-bottom: 20px;">
                    <label style="display: block; color: var(--text-secondary); margin-bottom: 5px;">Order</label>
                    <asp:TextBox ID="txtOrder" runat="server" CssClass="form-control" TextMode="Number" Text="1" Width="80px"></asp:TextBox>
                </div>
                <asp:Button ID="btnAddLesson" runat="server" Text="Add Lesson" CssClass="btn-primary" OnClick="btnAddLesson_Click" />
                <asp:Label ID="lblMessage" runat="server" ForeColor="#10B981" style="margin-left: 15px;"></asp:Label>
            </div>
        </div>

        <!-- Lessons List -->
        <div style="max-width: 800px; margin: 0 auto;">
            <h3 style="color: var(--text-primary); margin-bottom: 20px;">Lessons</h3>
            <asp:Repeater ID="rptLessons" runat="server" OnItemCommand="rptLessons_ItemCommand">
                <ItemTemplate>
                    <div class="feature-card" style="margin-bottom: 16px; display: flex; justify-content: space-between; align-items: center; padding: 20px 25px;">
                        <div style="flex: 1;">
                            <div style="display: flex; align-items: center; gap: 15px; margin-bottom: 8px;">
                                <span style="background: var(--gradient-primary); color: white; width: 32px; height: 32px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 0.85rem; flex-shrink: 0;"><%# Eval("OrderIndex") %></span>
                                <h4 style="color: white; margin: 0; font-size: 1.1rem;"><%# Eval("Title") %></h4>
                            </div>
                            <p style="color: var(--text-secondary); font-size: 0.9rem; margin: 0 0 0 47px; max-width: 500px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%# Eval("Content") %></p>
                        </div>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteLesson" CommandArgument='<%# Eval("Id") %>' 
                            style="color: #EF4444; text-decoration: none; font-size: 0.85rem; padding: 6px 14px; border: 1px solid #EF4444; border-radius: 6px; background: transparent; cursor: pointer;"
                            OnClientClick="return confirm('Delete this lesson?');">Delete</asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Label ID="lblNoLessons" runat="server" Text="No lessons yet. Add your first lesson above." Visible="false" 
                style="color: var(--text-muted); display: block; text-align: center; padding: 40px; background: var(--bg-card); border-radius: var(--radius-lg); border: 1px solid var(--border);"></asp:Label>
        </div>
    </div>
</asp:Content>
