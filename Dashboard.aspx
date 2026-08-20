<%@ Page Title="My Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Codelecta_2._0.Dashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main style="padding: 40px 0 80px 0; background: var(--bg-page);">
        <div class="container" style="max-width: 1100px; margin: 0 auto; padding: 0 24px;">

            <!-- ==================== WELCOME & STATS BANNER ==================== -->
            <div style="background: linear-gradient(135deg, #21094E 0%, #170638 50%, #0D0226 100%); border-radius: 24px; padding: 40px 44px; color: #FFFFFF; margin-bottom: 44px; box-shadow: 0 16px 40px rgba(33, 9, 78, 0.25); position: relative; overflow: hidden; border: 1px solid rgba(255, 255, 255, 0.1);">
                <!-- Glow Blobs -->
                <div style="position: absolute; top: -60px; right: -60px; width: 260px; height: 260px; border-radius: 50%; background: radial-gradient(circle, rgba(139, 92, 246, 0.3) 0%, transparent 70%); pointer-events: none;"></div>
                <div style="position: absolute; bottom: -60px; left: -60px; width: 220px; height: 220px; border-radius: 50%; background: radial-gradient(circle, rgba(99, 102, 241, 0.25) 0%, transparent 70%); pointer-events: none;"></div>

                <div style="position: relative; z-index: 2;">
                    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 20px; margin-bottom: 32px;">
                        <div>
                            <span style="display: inline-block; font-size: 0.8rem; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; color: #C4B5FD; background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.15); padding: 4px 14px; border-radius: var(--radius-full); margin-bottom: 12px;">STUDENT LEARNING DASHBOARD</span>
                            <h1 style="font-size: 2.4rem; font-weight: 800; color: #FFFFFF; margin: 0 0 6px 0; letter-spacing: -0.02em;">
                                Welcome Back, <span class="purple-highlight" style="background: linear-gradient(135deg, #A78BFA 0%, #C084FC 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;"><asp:Label ID="lblUserName" runat="server"></asp:Label></span>
                            </h1>
                            <p style="color: rgba(255, 255, 255, 0.7); font-size: 1rem; margin: 0;">Track your learning milestones, manage enrolled courses, and continue your progress.</p>
                        </div>
                        <div>
                            <a href="Courses" class="btn-primary" style="padding: 12px 24px; font-size: 0.92rem; font-weight: 700; border-radius: 10px; text-decoration: none; display: inline-flex; align-items: center; gap: 8px;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="11" cy="11" r="8"></circle>
                                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                </svg>
                                Browse Courses
                            </a>
                        </div>
                    </div>

                    <!-- 3 Metric Cards Grid -->
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 18px;">
                        <!-- Stat 1: Enrolled Courses -->
                        <div style="background: rgba(255, 255, 255, 0.06); border: 1px solid rgba(255, 255, 255, 0.12); border-radius: 16px; padding: 20px; backdrop-filter: blur(8px);">
                            <span style="font-size: 0.85rem; color: rgba(255, 255, 255, 0.65); font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Enrolled Courses</span>
                            <div style="font-size: 2.2rem; font-weight: 900; color: #FFFFFF; margin-top: 6px;">
                                <asp:Label ID="lblTotalEnrolled" runat="server" Text="0"></asp:Label>
                            </div>
                        </div>

                        <!-- Stat 2: Completed Lessons -->
                        <div style="background: rgba(255, 255, 255, 0.06); border: 1px solid rgba(255, 255, 255, 0.12); border-radius: 16px; padding: 20px; backdrop-filter: blur(8px);">
                            <span style="font-size: 0.85rem; color: rgba(255, 255, 255, 0.65); font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Lessons Completed</span>
                            <div style="font-size: 2.2rem; font-weight: 900; color: #34D399; margin-top: 6px;">
                                <asp:Label ID="lblCompletedLessons" runat="server" Text="0"></asp:Label>
                            </div>
                        </div>

                        <!-- Stat 3: Completion Rate -->
                        <div style="background: rgba(255, 255, 255, 0.06); border: 1px solid rgba(255, 255, 255, 0.12); border-radius: 16px; padding: 20px; backdrop-filter: blur(8px);">
                            <span style="font-size: 0.85rem; color: rgba(255, 255, 255, 0.65); font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Overall Progress</span>
                            <div style="font-size: 2.2rem; font-weight: 900; color: #A78BFA; margin-top: 6px;">
                                <asp:Label ID="lblCompletionRate" runat="server" Text="0%"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==================== ENROLLED COURSES SECTION ==================== -->
            <div style="margin-bottom: 24px; display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h2 style="font-size: 1.85rem; font-weight: 800; color: var(--text-primary); margin: 0 0 4px 0; letter-spacing: -0.02em;">My Enrolled Courses</h2>
                    <p style="color: var(--text-secondary); font-size: 0.95rem; margin: 0;">Continue your structured lessons or review finished material.</p>
                </div>
            </div>

            <!-- Courses Repeater -->
            <div style="display: flex; flex-direction: column; gap: 20px;">
                <asp:Repeater ID="rptEnrolledCourses" runat="server">
                    <ItemTemplate>
                        <div style="background: #FFFFFF; border-radius: 18px; border: 1px solid var(--border); box-shadow: 0 4px 16px rgba(108, 92, 231, 0.06); padding: 28px 32px; display: grid; grid-template-columns: 1.2fr 0.8fr; gap: 32px; align-items: center; transition: transform 0.2s ease, box-shadow 0.2s ease;">
                            
                            <!-- Left: Course Info -->
                            <div>
                                <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 10px;">
                                    <span style="font-size: 0.78rem; font-weight: 800; padding: 4px 12px; border-radius: var(--radius-full); background: #F3F0FF; color: var(--primary); border: 1px solid #E4DEFF;">
                                        ENROLLED
                                    </span>
                                    <span style="font-size: 0.82rem; color: var(--text-muted);">
                                        Enrolled on <%# Eval("EnrollmentDate", "{0:MMM dd, yyyy}") %>
                                    </span>
                                </div>

                                <h3 style="font-size: 1.35rem; font-weight: 800; color: var(--text-primary); margin: 0 0 8px 0;">
                                    <%# Eval("CourseTitle") %>
                                </h3>
                                <p style="color: var(--text-secondary); font-size: 0.92rem; line-height: 1.6; margin: 0 0 16px 0;">
                                    <%# Eval("CourseDescription") %>
                                </p>

                                <div style="display: flex; align-items: center; gap: 18px; font-size: 0.85rem; color: var(--text-muted);">
                                    <span>Instructor: <strong style="color: var(--text-primary);"><%# Eval("InstructorName") %></strong></span>
                                    <span>&bull;</span>
                                    <span><%# Eval("TotalLessons") %> Total Lessons</span>
                                </div>
                            </div>

                            <!-- Right: Progress Bar & Action Button -->
                            <div style="background: #FAF9FF; border: 1px solid #ECE7FF; border-radius: 14px; padding: 22px; display: flex; flex-direction: column; justify-content: center; gap: 16px;">
                                <div>
                                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                        <span style="font-size: 0.88rem; font-weight: 700; color: var(--text-primary);">Course Progress</span>
                                        <span style="font-size: 0.88rem; font-weight: 800; color: var(--primary);"><%# Eval("ProgressPercent") %>%</span>
                                    </div>

                                    <!-- Progress Track -->
                                    <div style="width: 100%; height: 10px; background: #E9E5FF; border-radius: 9999px; overflow: hidden;">
                                        <div style='width: <%# Eval("ProgressPercent") %>%; height: 100%; background: linear-gradient(90deg, #6C5CE7, #A855F7); border-radius: 9999px; transition: width 0.4s ease;'></div>
                                    </div>

                                    <div style="margin-top: 6px; font-size: 0.8rem; color: var(--text-secondary); text-align: right;">
                                        <%# Eval("CompletedLessons") %> of <%# Eval("TotalLessons") %> lessons completed
                                    </div>
                                </div>

                                <!-- Continue Button -->
                                <div>
                                    <a href='<%# "ViewLesson.aspx?id=" + Eval("NextLessonId") %>' class="btn-primary" 
                                       style='width: 100%; padding: 11px 20px; font-size: 0.92rem; font-weight: 700; border-radius: 8px; text-decoration: none; display: flex; justify-content: center; align-items: center; gap: 6px; <%# (int)Eval("TotalLessons") == 0 ? "pointer-events: none; opacity: 0.5;" : "" %>'>
                                        <%# (int)Eval("ProgressPercent") == 100 ? "Review Course &#10003;" : "Continue Learning &rarr;" %>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- Empty State when user has no enrolled courses -->
            <asp:Panel ID="pnlNoCourses" runat="server" Visible="false"
                style="background: #FFFFFF; border-radius: 20px; border: 1px dashed #DDD6FE; padding: 60px 40px; text-align: center; margin-top: 20px; box-shadow: var(--shadow-sm);">
                <div style="width: 64px; height: 64px; border-radius: 50%; background: #F3F0FF; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px auto;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                        <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
                    </svg>
                </div>
                <h3 style="font-size: 1.4rem; font-weight: 800; color: var(--text-primary); margin: 0 0 8px 0;">No Enrolled Courses Yet</h3>
                <p style="color: var(--text-secondary); font-size: 0.95rem; max-width: 460px; margin: 0 auto 24px auto; line-height: 1.6;">
                    You haven't enrolled in any programming courses yet. Explore our structured curriculum to begin learning.
                </p>
                <a href="Courses" class="btn-primary" style="padding: 12px 28px; font-size: 0.95rem; font-weight: 700; border-radius: 8px; text-decoration: none;">
                    Explore Course Catalog
                </a>
            </asp:Panel>

        </div>
    </main>
</asp:Content>
