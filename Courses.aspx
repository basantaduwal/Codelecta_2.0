<%@ Page Title="Courses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="Codelecta_2._0.Courses" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="catalog-page">

        <!-- ==================== PAGE HERO ==================== -->
        <div class="catalog-hero">
            <div class="container">
                <div class="catalog-hero-inner">
                    <div>
                        <span class="catalog-eyebrow">COURSE CATALOG</span>
                        <h1 class="catalog-title">
                            Explore Our<br />
                            <span class="catalog-title-accent">Learning Paths</span>
                        </h1>
                        <p class="catalog-subtitle">
                            From absolute beginner to professional developer - find the course that matches your level and goals.
                        </p>
                    </div>
                    <div class="catalog-hero-stats">
                        <div class="hero-stat">
                            <span class="hero-stat-num">8</span>
                            <span class="hero-stat-label">Courses</span>
                        </div>
                        <div class="hero-stat">
                            <span class="hero-stat-num">40+</span>
                            <span class="hero-stat-label">Lessons</span>
                        </div>
                        <div class="hero-stat">
                            <span class="hero-stat-num">3</span>
                            <span class="hero-stat-label">Levels</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ==================== FILTER BAR ==================== -->
        <div class="catalog-filter-bar">
            <div class="container">
                <div class="filter-group">
                    <span class="filter-label">Filter by level:</span>
                    <asp:LinkButton ID="btnAll"          runat="server" CssClass="filter-pill filter-pill-active" CommandArgument="All"          OnClick="FilterLevel_Click">All Courses</asp:LinkButton>
                    <asp:LinkButton ID="btnBeginner"     runat="server" CssClass="filter-pill" CommandArgument="Beginner"     OnClick="FilterLevel_Click">Beginner</asp:LinkButton>
                    <asp:LinkButton ID="btnIntermediate" runat="server" CssClass="filter-pill" CommandArgument="Intermediate" OnClick="FilterLevel_Click">Intermediate</asp:LinkButton>
                    <asp:LinkButton ID="btnProfessional" runat="server" CssClass="filter-pill" CommandArgument="Professional" OnClick="FilterLevel_Click">Professional</asp:LinkButton>
                </div>
                <asp:HiddenField ID="hfCurrentFilter" runat="server" Value="All" />
            </div>
        </div>

        <!-- ==================== COURSES GRID ==================== -->
        <div class="container" style="padding-bottom: 80px;">

            <!-- Personalised recommendation banner (only shown when logged in and level is set) -->
            <asp:Panel ID="pnlRecommendBanner" runat="server" Visible="false" CssClass="recommend-banner">
                <div class="recommend-banner-inner">
                    <span class="recommend-icon" style="font-size: 1.5rem;">&#127919;</span>
                    <div>
                        <strong>Courses recommended for you</strong>
                        <span class="recommend-sub">Based on your <asp:Label ID="lblUserLevel" runat="server"></asp:Label> experience level</span>
                    </div>
                </div>
                <asp:LinkButton ID="btnShowAll" runat="server" CssClass="recommend-show-all" OnClick="ShowAll_Click">View all courses &rarr;</asp:LinkButton>
            </asp:Panel>

            <!-- Results count -->
            <div class="catalog-results-row">
                <p class="catalog-count">
                    Showing <asp:Label ID="lblCount" runat="server" Text="0"></asp:Label> course<asp:Label ID="lblCountPlural" runat="server" Text="s"></asp:Label>
                    <asp:Label ID="lblFilterLabel" runat="server" Text="" CssClass="catalog-count-filter"></asp:Label>
                </p>
            </div>

            <asp:Repeater ID="rptCourses" runat="server">
                <HeaderTemplate>
                    <div class="catalog-grid">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="catalog-card">
                        <!-- Badge -->
                        <div class="catalog-card-top">
                            <div class="catalog-badge <%# Eval("BadgeClass") %>"><%# Eval("ImageTag") %></div>
                            <span class="catalog-level-tag level-<%# Eval("Level").ToString().ToLower() %>"><%# Eval("Level") %></span>
                        </div>
                        <!-- Body -->
                        <div class="catalog-card-body">
                            <h3 class="catalog-card-title"><%# Eval("Title") %></h3>
                            <p class="catalog-card-desc"><%# Eval("Description") %></p>
                        </div>
                        <!-- Footer -->
                        <div class="catalog-card-footer">
                            <div class="catalog-card-meta">
                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/></svg>
                                <span><%# Eval("LessonCount") %> lessons</span>
                            </div>
                            <div class="catalog-card-meta" style="<%# (bool)Eval("IsEnrolled") ? "color: var(--success);" : "" %>">
                                <%# (bool)Eval("IsEnrolled") ? "&#10003; Enrolled" : "" %>
                            </div>
                            <a href='CourseDetail.aspx?id=<%# Eval("Id") %>' class="btn-primary" style="padding: 9px 20px; font-size: 0.875rem;">
                                <%# (bool)Eval("IsEnrolled") ? "Continue &rarr;" : "View Course" %>
                            </a>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>

            <asp:Label ID="lblNoCourses" runat="server" Visible="false" CssClass="catalog-empty">
                No courses match the selected filter yet. Check back soon!
            </asp:Label>
        </div>

    </div>
</asp:Content>
