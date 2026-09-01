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
                            From absolute beginner to professional developer — find the course that matches your level and goals.
                        </p>
                    </div>
                    <div class="catalog-hero-stats">
                        <div class="hero-stat">
                            <span class="hero-stat-num"><asp:Label ID="lblTotalCoursesStat" runat="server" Text="8" /></span>
                            <span class="hero-stat-label">Courses</span>
                        </div>
                        <div class="hero-stat">
                            <span class="hero-stat-num"><asp:Label ID="lblTotalLessonsStat" runat="server" Text="40+" /></span>
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

        <!-- ==================== SEARCH & FILTER BAR ==================== -->
        <div class="catalog-filter-bar" style="background: #FFFFFF; border-bottom: 1px solid var(--border); padding: 18px 0;">
            <div class="container">
                <div style="display: flex; justify-content: space-between; align-items: center; gap: 20px; flex-wrap: wrap;">
                    
                    <!-- Filter Level Pills -->
                    <div class="filter-group" style="display: flex; align-items: center; gap: 8px; flex-wrap: wrap;">
                        <span class="filter-label" style="font-weight: 700; color: #475569; font-size: 0.88rem; margin-right: 4px;">Level:</span>
                        <asp:LinkButton ID="btnAll"          runat="server" CssClass="filter-pill filter-pill-active" CommandArgument="All"          OnClick="FilterLevel_Click">All Courses</asp:LinkButton>
                        <asp:LinkButton ID="btnBeginner"     runat="server" CssClass="filter-pill" CommandArgument="Beginner"     OnClick="FilterLevel_Click">Beginner</asp:LinkButton>
                        <asp:LinkButton ID="btnIntermediate" runat="server" CssClass="filter-pill" CommandArgument="Intermediate" OnClick="FilterLevel_Click">Intermediate</asp:LinkButton>
                        <asp:LinkButton ID="btnProfessional" runat="server" CssClass="filter-pill" CommandArgument="Professional" OnClick="FilterLevel_Click">Professional</asp:LinkButton>
                    </div>

                    <!-- Search Input & Sort Dropdown -->
                    <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                        
                        <!-- Search Box -->
                        <div style="position: relative; min-width: 220px;">
                            <svg style="position: absolute; left: 11px; top: 50%; transform: translateY(-50%); color: #94A3B8; pointer-events: none;" xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                            </svg>
                            <asp:TextBox ID="txtCourseSearch" runat="server" placeholder="Search courses..."
                                style="width: 100%; padding: 8px 12px 8px 32px; border: 1.5px solid #EDE9FE; border-radius: 20px; font-size: 0.85rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
                        </div>

                        <!-- Sort Dropdown -->
                        <asp:DropDownList ID="ddlSort" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged"
                            style="padding: 8px 14px; border: 1.5px solid #EDE9FE; border-radius: 20px; font-size: 0.85rem; font-family: inherit; color: #475569; background: #FAFAFA; cursor: pointer;">
                            <asp:ListItem Value="popular" Text="⚡ Most Popular" />
                            <asp:ListItem Value="newest"  Text="✨ Newest First" />
                            <asp:ListItem Value="alpha"   Text="🔤 Alphabetical" />
                            <asp:ListItem Value="lessons" Text="📚 Most Lessons" />
                        </asp:DropDownList>

                        <!-- Search Button -->
                        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                            style="padding: 8px 18px; background: linear-gradient(135deg, #6C5CE7, #A855F7); color: white; border: none; border-radius: 20px; font-weight: 700; font-size: 0.85rem; cursor: pointer;" />
                        
                        <asp:Button ID="btnResetSearch" runat="server" Text="Reset" OnClick="btnResetSearch_Click"
                            style="padding: 8px 14px; background: #F5F3FF; color: #6C5CE7; border: 1px solid #DDD6FE; border-radius: 20px; font-weight: 600; font-size: 0.85rem; cursor: pointer;" />
                    </div>

                </div>
                <asp:HiddenField ID="hfCurrentFilter" runat="server" Value="All" />
            </div>
        </div>

        <!-- ==================== COURSES GRID ==================== -->
        <div class="container" style="padding-bottom: 80px; padding-top: 30px;">

            <!-- Personalised recommendation banner (only shown when logged in and level is set) -->
            <asp:Panel ID="pnlRecommendBanner" runat="server" Visible="false" CssClass="recommend-banner" style="margin-bottom: 24px;">
                <div class="recommend-banner-inner">
                    <span class="recommend-icon" style="font-size: 1.5rem;">🎯</span>
                    <div>
                        <strong>Courses recommended for you</strong>
                        <span class="recommend-sub">Based on your <asp:Label ID="lblUserLevel" runat="server"></asp:Label> experience level</span>
                    </div>
                </div>
                <asp:LinkButton ID="btnShowAll" runat="server" CssClass="recommend-show-all" OnClick="ShowAll_Click">View all courses &rarr;</asp:LinkButton>
            </asp:Panel>

            <!-- Results count -->
            <div class="catalog-results-row" style="margin-bottom: 20px;">
                <p class="catalog-count" style="font-weight: 600; color: #64748B; font-size: 0.92rem; margin: 0;">
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
                            <div class="catalog-card-meta" style="<%# (bool)Eval("IsEnrolled") ? "color: var(--success); font-weight: 700;" : "" %>">
                                <%# (bool)Eval("IsEnrolled") ? "✓ Enrolled" : "" %>
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

            <asp:Panel ID="pnlEmptyState" runat="server" Visible="false" CssClass="catalog-empty"
                style="background: #FFFFFF; border-radius: 20px; border: 1.5px dashed #DDD6FE; padding: 60px 20px; text-align: center;">
                <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 14px; opacity: 0.5;">
                    <circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
                <p style="font-weight: 700; font-size: 1.05rem; color: #1E1B4B; margin: 0 0 6px 0;">No courses found</p>
                <p style="color: #64748B; font-size: 0.9rem; margin: 0 0 20px 0;">Try adjusting your search query or level filters.</p>
                <asp:Button ID="btnResetAllFilters" runat="server" Text="Reset All Filters" OnClick="btnResetSearch_Click"
                    style="padding: 10px 24px; background: #F5F3FF; color: #6C5CE7; border: 1px solid #DDD6FE; border-radius: 10px; font-weight: 700; font-size: 0.88rem; cursor: pointer;" />
            </asp:Panel>
        </div>

    </div>
</asp:Content>
