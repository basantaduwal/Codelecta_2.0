<%@ Page Title="Courses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="Codelecta_2._0.Courses" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container section-padding">
        <div class="section-header" style="margin-bottom: 50px;">
            <h2 class="section-title">Explore Courses</h2>
            <p class="section-subtitle">Browse our catalog of courses and start learning today.</p>
        </div>

        <div class="features-grid" style="grid-template-columns: repeat(3, 1fr);">
            <asp:Repeater ID="rptCourses" runat="server">
                <ItemTemplate>
                    <div class="feature-card" style="display: flex; flex-direction: column; justify-content: space-between;">
                        <div>
                            <div class="feature-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                                    <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
                                </svg>
                            </div>
                            <h3><%# Eval("Title") %></h3>
                            <p><%# Eval("Description") %></p>
                        </div>
                        <div style="margin-top: 20px; display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 0.8rem; color: var(--text-muted);"><%# Eval("LessonCount") %> Lessons</span>
                            <a href="CourseDetail.aspx?id=<%# Eval("Id") %>" class="btn-primary" style="padding: 8px 20px; font-size: 0.9rem; text-decoration: none;">View Course</a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <asp:Label ID="lblNoCourses" runat="server" Visible="false"
            style="color: var(--text-muted); display: block; text-align: center; padding: 60px; background: var(--bg-card); border-radius: var(--radius-lg); border: 1px solid var(--border); max-width: 600px; margin: 0 auto;">
            No courses available yet. Check back soon!
        </asp:Label>
    </div>
</asp:Content>
