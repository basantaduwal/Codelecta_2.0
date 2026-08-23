<%@ Page Title="Course Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseDetail.aspx.cs" Inherits="Codelecta_2._0.CourseDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="detail-page">

        <!-- ==================== BREADCRUMB ==================== -->
        <div class="detail-breadcrumb">
            <div class="container">
                <a href="Courses" class="breadcrumb-link">&larr; Back to Courses</a>
            </div>
        </div>

        <!-- ==================== COURSE HERO ==================== -->
        <div class="detail-hero">
            <div class="container">
                <div class="detail-hero-inner">
                    <div class="detail-hero-content">
                        <div class="detail-hero-top">
                            <div class="detail-badge-large <asp:Literal ID="litBadgeClass" runat="server" />">
                                <asp:Literal ID="litImageTag" runat="server" />
                            </div>
                            <asp:Label ID="lblLevel" runat="server" CssClass="detail-level-pill" />
                        </div>
                        <h1 class="detail-course-title">
                            <asp:Label ID="lblTitle" runat="server" />
                        </h1>
                        <p class="detail-course-desc">
                            <asp:Label ID="lblDescription" runat="server" />
                        </p>
                        <div class="detail-meta-row">
                            <span class="detail-meta-item">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/></svg>
                                <asp:Label ID="lblLessonCount" runat="server" /> lessons
                            </span>
                            <span class="detail-meta-item" id="enrolledBadge" runat="server" visible="false">
                                <span class="detail-enrolled-badge">&#10003; Enrolled</span>
                            </span>
                        </div>
                    </div>

                    <!-- Enroll / Enrolled action card -->
                    <div class="detail-action-card">
                        <!-- Progress ring (only when enrolled) -->
                        <asp:Panel ID="pnlProgress" runat="server" Visible="false" CssClass="detail-progress-block">
                            <div class="detail-progress-label">Your Progress</div>
                            <div class="detail-progress-bar-track">
                                <div class="detail-progress-bar-fill" style="width: <%: Page.GetType() == typeof(Codelecta_2._0.CourseDetail) ? ((Codelecta_2._0.CourseDetail)Page).ProgressPct + "%" : "0%" %>"></div>
                            </div>
                            <div class="detail-progress-pct">
                                <asp:Label ID="lblProgressPct" runat="server" Text="0%" />
                                <span> completed</span>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlEnroll" runat="server" Visible="false">
                            <asp:Button ID="btnEnroll" runat="server" Text="Enroll Now — It's Free"
                                CssClass="btn-primary detail-enroll-btn" OnClick="btnEnroll_Click" />
                            <p class="detail-enroll-note">Free access &middot; Self-paced &middot; No deadline</p>
                        </asp:Panel>

                        <asp:Panel ID="pnlContinue" runat="server" Visible="false">
                            <a id="aStartLesson" runat="server" class="btn-primary detail-enroll-btn">
                                Continue Learning &rarr;
                            </a>
                            <p class="detail-enroll-note">Pick up where you left off</p>
                        </asp:Panel>

                        <asp:Panel ID="pnlLoginPrompt" runat="server" Visible="false" CssClass="detail-login-prompt">
                            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                            <p>Sign in to enroll in this course</p>
                            <a href="Account/Login" class="btn-primary" style="width: 100%; text-align: center;">Log In</a>
                            <a href="Account/Register" class="btn-secondary" style="width: 100%; text-align: center; margin-top: 10px;">Create Account</a>
                        </asp:Panel>

                        <asp:Label ID="lblMessage" runat="server" CssClass="detail-msg" Visible="false" />
                    </div>
                </div>
            </div>
        </div>

        <!-- ==================== LESSON LIST ==================== -->
        <div class="container" style="padding-bottom: 80px;">
            <div class="detail-lessons-section">
                <h2 class="detail-lessons-heading">Course Content</h2>
                <p class="detail-lessons-sub">
                    <asp:Label ID="lblLessonCount2" runat="server" /> lessons &middot; complete at your own pace
                </p>

                <div class="detail-lessons-list">
                    <asp:Repeater ID="rptLessons" runat="server">
                        <ItemTemplate>
                            <div class="lesson-row <%# (bool)Eval("IsCompleted") ? "lesson-row-done" : "" %>">
                                <div class="lesson-row-left">
                                    <div class="lesson-index <%# (bool)Eval("IsCompleted") ? "lesson-index-done" : "" %>">
                                        <%# (bool)Eval("IsCompleted") ? "&#10003;" : Eval("OrderIndex") %>
                                    </div>
                                    <div>
                                        <div class="lesson-title"><%# Eval("Title") %></div>
                                        <div class="lesson-status-text"><%# (bool)Eval("IsCompleted") ? "Completed" : "Not started" %></div>
                                    </div>
                                </div>
                                <div class="lesson-row-right">
                                    <%# ((Codelecta_2._0.CourseDetail)Page).IsEnrolled
                                        ? "<a href='ViewLesson.aspx?id=" + Eval("Id") + "' class='lesson-link'>" + ((bool)Eval("IsCompleted") ? "Review" : "Start") + " &rarr;</a>"
                                        : "<span class='lesson-locked'>🔒 Enroll to unlock</span>" %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Label ID="lblNoLessons" runat="server" Visible="false" CssClass="detail-no-lessons">
                        No lessons have been added to this course yet. Check back soon.
                    </asp:Label>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
