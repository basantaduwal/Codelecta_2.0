<%@ Page Title="Manage Courses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageCourses.aspx.cs" Inherits="Codelecta_2._0.Admin.ManageCourses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container section-padding">
        <div class="section-header" style="margin-bottom: 40px;">
            <h2 class="section-title">Admin Dashboard</h2>
            <p class="section-subtitle">Create and manage your educational content.</p>
        </div>
        
        <div class="features-grid" style="grid-template-columns: 1fr; max-width: 800px; margin: 0 auto; margin-bottom: 40px;">
            <div class="feature-card">
                <h3 style="color: var(--text-primary); margin-bottom: 20px;">Create New Course</h3>
                <div class="form-group" style="margin-bottom: 15px;">
                    <label style="display: block; color: var(--text-secondary); margin-bottom: 5px;">Course Title</label>
                    <asp:TextBox ID="txtCourseTitle" runat="server" CssClass="form-control" placeholder="e.g. Advanced C# Programming" Width="100%"></asp:TextBox>
                </div>
                <div class="form-group" style="margin-bottom: 20px;">
                    <label style="display: block; color: var(--text-secondary); margin-bottom: 5px;">Description</label>
                    <asp:TextBox ID="txtCourseDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="What will students learn?" Width="100%"></asp:TextBox>
                </div>
                <asp:Button ID="btnCreateCourse" runat="server" Text="Create Course" CssClass="btn-primary" OnClick="btnCreateCourse_Click" />
                <asp:Label ID="lblMessage" runat="server" ForeColor="#10B981" style="margin-left: 15px;"></asp:Label>
            </div>
        </div>

        <div class="features-grid" style="grid-template-columns: 1fr; max-width: 800px; margin: 0 auto;">
            <h3 style="color: var(--text-primary); margin-bottom: 20px;">Your Courses</h3>
            <asp:Repeater ID="rptCourses" runat="server">
                <ItemTemplate>
                    <div class="feature-card" style="margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; padding: 25px;">
                        <div>
                            <h4 style="color: white; margin-top: 0; font-size: 1.2rem; margin-bottom: 8px;"><%# Eval("Title") %></h4>
                            <p style="color: var(--text-secondary); font-size: 0.95rem; margin-bottom: 10px;"><%# Eval("Description") %></p>
                            <span style="font-size: 0.8rem; color: var(--text-muted);">Created: <%# Eval("CreatedDate", "{0:MMM dd, yyyy}") %></span>
                        </div>
                        <div>
                            <a href="ManageLessons.aspx?courseId=<%# Eval("Id") %>" class="btn-secondary" style="padding: 8px 16px; font-size: 0.9rem; display: inline-block; text-decoration: none;">Manage Lessons</a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Label ID="lblNoCourses" runat="server" Text="You haven't created any courses yet." Visible="false" style="color: var(--text-muted); display: block; text-align: center; padding: 40px; background: var(--bg-card); border-radius: var(--radius-lg); border: 1px solid var(--border);"></asp:Label>
        </div>
    </div>
</asp:Content>
