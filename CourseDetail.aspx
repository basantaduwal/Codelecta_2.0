<%@ Page Title="Course Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseDetail.aspx.cs" Inherits="Codelecta_2._0.CourseDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container section-padding">
        <a href="Courses.aspx" style="color: var(--primary-light); text-decoration: none; font-size: 0.95rem;">&larr; Back to Courses</a>

        <!-- Course Header -->
        <div class="feature-card" style="margin-top: 20px; padding: 40px;">
            <h2 style="color: var(--text-primary); font-size: 2rem; margin-bottom: 12px;">
                <asp:Label ID="lblTitle" runat="server"></asp:Label>
            </h2>
            <p style="color: var(--text-secondary); font-size: 1.05rem; line-height: 1.7; margin-bottom: 24px;">
                <asp:Label ID="lblDescription" runat="server"></asp:Label>
            </p>
            <div style="display: flex; align-items: center; gap: 20px; flex-wrap: wrap;">
                <span style="color: var(--text-muted); font-size: 0.9rem;">
                    <asp:Label ID="lblLessonCount" runat="server"></asp:Label> Lessons
                </span>
                <span style="color: var(--text-muted); font-size: 0.9rem;">
                    Admin: <asp:Label ID="lblInstructor" runat="server"></asp:Label>
                </span>

                <asp:Panel ID="pnlEnroll" runat="server" Visible="false">
                    <asp:Button ID="btnEnroll" runat="server" Text="Enroll Now" CssClass="btn-primary" OnClick="btnEnroll_Click" />
                </asp:Panel>
                <asp:Label ID="lblEnrolled" runat="server" Visible="false"
                    style="color: var(--success); font-weight: 600; font-size: 0.95rem;">&#10003; You are enrolled</asp:Label>
                <asp:Label ID="lblLoginPrompt" runat="server" Visible="false"
                    style="color: var(--text-muted); font-size: 0.9rem;">
                    <a href="Account/Login.aspx" style="color: var(--primary-light);">Login</a> to enroll in this course.
                </asp:Label>
            </div>
            <asp:Label ID="lblMessage" runat="server" style="display: block; margin-top: 12px;" ForeColor="#10B981"></asp:Label>
        </div>

        <!-- Lessons List -->
        <div style="margin-top: 40px;">
            <h3 style="color: var(--text-primary); margin-bottom: 20px;">Course Content</h3>
            <asp:Repeater ID="rptLessons" runat="server">
                <ItemTemplate>
                    <div class="feature-card" style="margin-bottom: 12px; padding: 20px 25px;">
                        <div style="display: flex; align-items: center; justify-content: space-between;">
                            <div style="display: flex; align-items: center; gap: 15px;">
                                <span style="background: var(--gradient-primary); color: white; width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 0.9rem; flex-shrink: 0;"><%# Eval("OrderIndex") %></span>
                                <div>
                                    <h4 style="color: white; margin: 0; font-size: 1.05rem;"><%# Eval("Title") %></h4>
                                </div>
                            </div>
                            <asp:HyperLink ID="lnkView" runat="server" 
                                NavigateUrl='<%# ((Codelecta_2._0.CourseDetail)Page).IsEnrolled ? "ViewLesson.aspx?id=" + Eval("Id") : "#" %>'
                                CssClass='<%# ((Codelecta_2._0.CourseDetail)Page).IsEnrolled ? "btn-primary" : "btn-secondary" %>'
                                style="padding: 8px 18px; font-size: 0.85rem; text-decoration: none;"
                                Enabled='<%# ((Codelecta_2._0.CourseDetail)Page).IsEnrolled %>'>
                                <%# ((Codelecta_2._0.CourseDetail)Page).IsEnrolled ? "Start" : "Locked" %>
                            </asp:HyperLink>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Label ID="lblNoLessons" runat="server" Visible="false"
                style="color: var(--text-muted); display: block; text-align: center; padding: 40px; background: var(--bg-card); border-radius: var(--radius-lg); border: 1px solid var(--border);">
                No lessons available for this course yet.
            </asp:Label>
        </div>
    </div>
</asp:Content>
