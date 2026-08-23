<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Codelecta_2._0.Admin.Dashboard" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PageTitleContent" runat="server">
    Dashboard
</asp:Content>

<asp:Content ID="MainContentHolder" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ==================== DASHBOARD WELCOME ==================== -->
    <div class="admin-welcome-banner">
        <div>
            <h2 class="welcome-title">
                Welcome back, <span class="welcome-highlight"><asp:Label ID="lblAdminName" runat="server" Text="Administrator"></asp:Label></span>
            </h2>
            <p class="welcome-sub">Here's an overview of your Codelecta platform.</p>
        </div>
        <div class="welcome-actions">
            <a runat="server" href="~/Admin/ManageCourses" class="btn-primary" style="padding: 10px 20px; font-size: 0.88rem; font-weight: 700; border-radius: 8px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 6px;">
                    <line x1="12" y1="5" x2="12" y2="19"></line>
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                </svg>
                Manage Courses
            </a>
        </div>
    </div>

    <!-- ==================== 4 STATISTICS CARDS ==================== -->
    <div class="admin-stats-grid">
        <!-- 1. Total Users -->
        <div class="admin-stat-card">
            <div class="stat-card-left">
                <span class="stat-label">Total Users</span>
                <div class="stat-value"><asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></div>
                <span class="stat-desc">Registered student accounts</span>
            </div>
            <div class="stat-icon-wrapper stat-icon-purple">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                    <circle cx="9" cy="7" r="4"></circle>
                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                    <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                </svg>
            </div>
        </div>

        <!-- 2. Total Courses -->
        <div class="admin-stat-card">
            <div class="stat-card-left">
                <span class="stat-label">Total Courses</span>
                <div class="stat-value"><asp:Label ID="lblTotalCourses" runat="server" Text="0"></asp:Label></div>
                <span class="stat-desc">Learning paths published</span>
            </div>
            <div class="stat-icon-wrapper stat-icon-blue">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                    <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
                </svg>
            </div>
        </div>

        <!-- 3. Total Enrollments -->
        <div class="admin-stat-card">
            <div class="stat-card-left">
                <span class="stat-label">Total Enrollments</span>
                <div class="stat-value"><asp:Label ID="lblTotalEnrollments" runat="server" Text="0"></asp:Label></div>
                <span class="stat-desc">Active course subscriptions</span>
            </div>
            <div class="stat-icon-wrapper stat-icon-green">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
                    <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
                    <path d="M9 14l2 2 4-4"></path>
                </svg>
            </div>
        </div>

        <!-- 4. Active Courses / Total Lessons -->
        <div class="admin-stat-card">
            <div class="stat-card-left">
                <span class="stat-label">Active Courses</span>
                <div class="stat-value"><asp:Label ID="lblActiveCourses" runat="server" Text="0"></asp:Label></div>
                <span class="stat-desc"><asp:Label ID="lblTotalLessons" runat="server" Text="0"></asp:Label> total lessons available</span>
            </div>
            <div class="stat-icon-wrapper stat-icon-amber">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline>
                </svg>
            </div>
        </div>
    </div>

    <!-- ==================== ANALYTICS SECTION ==================== -->
    <div class="admin-analytics-grid">
        <!-- 1. Enrollment Overview Chart / Activity -->
        <div class="admin-card">
            <div class="card-header-row">
                <h3 class="card-heading">Enrollment Overview</h3>
                <span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 600;">Platform Trend</span>
            </div>

            <asp:Panel ID="pnlEnrollmentChart" runat="server" Visible="false">
                <div style="height: 180px; display: flex; align-items: flex-end; gap: 14px; padding-top: 20px;">
                    <!-- Real data rendered via code-behind if available -->
                    <asp:Literal ID="litEnrollmentBars" runat="server"></asp:Literal>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEnrollmentEmpty" runat="server" Visible="true" CssClass="admin-empty-state">
                <div class="empty-icon-circle">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="18" y1="20" x2="18" y2="10"></line>
                        <line x1="12" y1="20" x2="12" y2="4"></line>
                        <line x1="6" y1="20" x2="6" y2="14"></line>
                    </svg>
                </div>
                <h4 class="empty-title">No enrollment activity yet</h4>
                <p class="empty-desc">When students enroll in courses, trends and charts will be dynamically visualized here.</p>
            </asp:Panel>
        </div>

        <!-- 2. Course Distribution -->
        <div class="admin-card">
            <div class="card-header-row">
                <h3 class="card-heading">Course Distribution</h3>
                <span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 600;">By Difficulty Level</span>
            </div>

            <div class="dist-list">
                <!-- Beginner -->
                <div class="dist-item">
                    <div class="dist-meta">
                        <span>Beginner</span>
                        <span><asp:Label ID="lblBeginnerCount" runat="server" Text="0"></asp:Label> courses (<asp:Label ID="lblBeginnerPct" runat="server" Text="0%"></asp:Label>)</span>
                    </div>
                    <div class="dist-bar-track">
                        <div class="dist-bar-fill dist-fill-beginner" id="barBeginner" runat="server" style="width: 0%;"></div>
                    </div>
                </div>

                <!-- Intermediate -->
                <div class="dist-item">
                    <div class="dist-meta">
                        <span>Intermediate</span>
                        <span><asp:Label ID="lblIntermediateCount" runat="server" Text="0"></asp:Label> courses (<asp:Label ID="lblIntermediatePct" runat="server" Text="0%"></asp:Label>)</span>
                    </div>
                    <div class="dist-bar-track">
                        <div class="dist-bar-fill dist-fill-intermediate" id="barIntermediate" runat="server" style="width: 0%;"></div>
                    </div>
                </div>

                <!-- Professional -->
                <div class="dist-item">
                    <div class="dist-meta">
                        <span>Professional</span>
                        <span><asp:Label ID="lblProfessionalCount" runat="server" Text="0"></asp:Label> courses (<asp:Label ID="lblProfessionalPct" runat="server" Text="0%"></asp:Label>)</span>
                    </div>
                    <div class="dist-bar-track">
                        <div class="dist-bar-fill dist-fill-professional" id="barProfessional" runat="server" style="width: 0%;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ==================== BOTTOM GRID: RECENT ACTIVITY & QUICK ACTIONS ==================== -->
    <div class="admin-bottom-grid">
        <!-- Recent Activity -->
        <div class="admin-card">
            <div class="card-header-row">
                <h3 class="card-heading">Recent Activity</h3>
                <span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 600;">Audit Feed</span>
            </div>

            <asp:Repeater ID="rptRecentActivity" runat="server">
                <HeaderTemplate>
                    <div style="display: flex; flex-direction: column; gap: 12px;">
                </HeaderTemplate>
                <ItemTemplate>
                    <div style="display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; background: var(--bg-surface); border-radius: var(--radius-md); border: 1px solid var(--border);">
                        <div style="display: flex; align-items: center; gap: 12px;">
                            <div style="width: 32px; height: 32px; border-radius: 50%; background: var(--primary-subtle); display: flex; align-items: center; justify-content: center; color: var(--primary);">
                                <%# Eval("Icon") %>
                            </div>
                            <div>
                                <div style="font-size: 0.88rem; font-weight: 700; color: var(--text-primary);"><%# Eval("Title") %></div>
                                <div style="font-size: 0.78rem; color: var(--text-muted);"><%# Eval("Subtitle") %></div>
                            </div>
                        </div>
                        <span style="font-size: 0.76rem; color: var(--text-muted); font-weight: 600;"><%# Eval("TimeAgo") %></span>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlNoActivity" runat="server" Visible="false" CssClass="admin-empty-state">
                <div class="empty-icon-circle">
                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"></circle>
                        <polyline points="12 6 12 12 16 14"></polyline>
                    </svg>
                </div>
                <h4 class="empty-title">No recent activity available</h4>
                <p class="empty-desc">Recent course modifications and registrations will be logged here.</p>
            </asp:Panel>
        </div>

        <!-- Quick Actions -->
        <div class="admin-card">
            <div class="card-header-row">
                <h3 class="card-heading">Quick Actions</h3>
                <span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 600;">Shortcuts</span>
            </div>

            <div class="quick-actions-grid">
                <!-- Add Course -->
                <a runat="server" href="~/Admin/ManageCourses" class="quick-action-btn">
                    <div class="qa-icon-wrapper">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="12" y1="5" x2="12" y2="19"></line>
                            <line x1="5" y1="12" x2="19" y2="12"></line>
                        </svg>
                    </div>
                    <span class="qa-title">Manage Courses</span>
                    <span class="qa-desc">Add & configure courses</span>
                </a>

                <!-- Manage Lessons -->
                <a runat="server" href="~/Admin/ManageLessons" class="quick-action-btn">
                    <div class="qa-icon-wrapper">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                            <polyline points="14 2 14 8 20 8"></polyline>
                        </svg>
                    </div>
                    <span class="qa-title">Manage Lessons</span>
                    <span class="qa-desc">Upload content & video</span>
                </a>

                <!-- View Catalog -->
                <a runat="server" href="~/Courses" class="quick-action-btn">
                    <div class="qa-icon-wrapper">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                    </div>
                    <span class="qa-title">View Catalog</span>
                    <span class="qa-desc">Preview learner catalog</span>
                </a>

                <!-- View Live Site -->
                <a runat="server" href="~/" class="quick-action-btn">
                    <div class="qa-icon-wrapper">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path>
                            <polyline points="15 3 21 3 21 9"></polyline>
                            <line x1="10" y1="14" x2="21" y2="3"></line>
                        </svg>
                    </div>
                    <span class="qa-title">Live Website</span>
                    <span class="qa-desc">Go to platform homepage</span>
                </a>
            </div>
        </div>
    </div>

    <!-- ==================== RECENT ENROLLMENTS ==================== -->
    <div class="admin-card" style="margin-bottom: 28px;">
        <div class="card-header-row">
            <div>
                <h3 class="card-heading">Recent Enrollments</h3>
                <span style="font-size: 0.8rem; color: var(--text-muted);">Real-time student course subscriptions</span>
            </div>
        </div>

        <asp:Repeater ID="rptRecentEnrollments" runat="server">
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Student</th>
                                <th>Course</th>
                                <th>Level</th>
                                <th>Enrolled Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <div style="font-weight: 700;"><%# Eval("StudentName") %></div>
                        <div style="font-size: 0.78rem; color: var(--text-muted);"><%# Eval("StudentEmail") %></div>
                    </td>
                    <td style="font-weight: 600;"><%# Eval("CourseTitle") %></td>
                    <td>
                        <span class="tbl-badge-level tbl-level-<%# Eval("Level").ToString().ToLower() %>"><%# Eval("Level") %></span>
                    </td>
                    <td style="color: var(--text-secondary); font-size: 0.82rem;"><%# Eval("EnrolledDateFormatted") %></td>
                    <td>
                        <span class="tbl-status-active">Active</span>
                    </td>
                    <td>
                        <a href='<%# ResolveUrl("~/CourseDetail.aspx?id=" + Eval("CourseId")) %>' class="tbl-action-btn tbl-btn-view" target="_blank">
                            View Course
                        </a>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                        </tbody>
                    </table>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <asp:Panel ID="pnlNoEnrollments" runat="server" Visible="false" CssClass="admin-empty-state">
            <div class="empty-icon-circle">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
                    <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
                </svg>
            </div>
            <h4 class="empty-title">No enrollments yet</h4>
            <p class="empty-desc">When students enroll into published courses, their enrollment details will appear here.</p>
        </asp:Panel>
    </div>

    <!-- ==================== COURSE OVERVIEW TABLE ==================== -->
    <div class="admin-card">
        <div class="card-header-row">
            <div>
                <h3 class="card-heading">Course Overview</h3>
                <span style="font-size: 0.8rem; color: var(--text-muted);">Published courses & syllabus summary</span>
            </div>
            <a runat="server" href="~/Admin/ManageCourses" class="card-action-link">Manage All &rarr;</a>
        </div>

        <asp:Repeater ID="rptCoursesOverview" runat="server">
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Course</th>
                                <th>Level</th>
                                <th>Lessons</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <div style="display: flex; align-items: center; gap: 10px;">
                            <div class="catalog-badge <%# Eval("BadgeClass") %>" style="width: 36px; height: 36px; font-size: 0.85rem; border-radius: 8px;">
                                <%# Eval("ImageTag") %>
                            </div>
                            <div>
                                <div style="font-weight: 700;"><%# Eval("Title") %></div>
                                <div style="font-size: 0.78rem; color: var(--text-muted); max-width: 320px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><%# Eval("Description") %></div>
                            </div>
                        </div>
                    </td>
                    <td>
                        <span class="tbl-badge-level tbl-level-<%# Eval("Level").ToString().ToLower() %>"><%# Eval("Level") %></span>
                    </td>
                    <td style="font-weight: 700; color: var(--text-secondary);"><%# Eval("LessonCount") %> lessons</td>
                    <td>
                        <span class="tbl-status-active">Published</span>
                    </td>
                    <td>
                        <div style="display: flex; gap: 6px;">
                            <a href='<%# ResolveUrl("~/Admin/ManageLessons.aspx?courseId=" + Eval("Id")) %>' class="tbl-action-btn tbl-btn-view" title="Manage Lessons">
                                Lessons
                            </a>
                            <a href='<%# ResolveUrl("~/CourseDetail.aspx?id=" + Eval("Id")) %>' class="tbl-action-btn" style="background: var(--bg-surface); color: var(--text-secondary);" target="_blank" title="View Public Page">
                                View
                            </a>
                        </div>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                        </tbody>
                    </table>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <asp:Panel ID="pnlNoCourses" runat="server" Visible="false" CssClass="admin-empty-state">
            <div class="empty-icon-circle">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                    <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
                </svg>
            </div>
            <h4 class="empty-title">No courses available yet</h4>
            <p class="empty-desc">Create your first course to start building the Codelecta learning catalogue.</p>
        </asp:Panel>
    </div>

</asp:Content>
