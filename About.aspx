<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Codelecta_2._0.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <!-- ==================== ABOUT HERO ==================== -->
        <section class="hero-section" style="min-height: auto; padding: 60px 0 40px 0;">
            <div class="container" style="text-align: center; max-width: 860px; margin: 0 auto; padding: 0 20px;">
                <span class="hero-label" style="display: inline-block; font-size: 0.85rem; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; color: var(--primary); margin-bottom: 16px; padding: 6px 18px; border-radius: var(--radius-full); background: var(--primary-subtle); border: 1px solid var(--border);">ABOUT CODELECTA</span>
                <h1 class="hero-title" style="font-size: 2.8rem; margin-bottom: 18px; line-height: 1.2;">
                    Empowering Future <span class="purple-text">Developers</span>
                </h1>
                <p class="hero-text" style="font-size: 1.15rem; color: var(--text-secondary); margin: 0 auto 30px auto; max-width: 720px; line-height: 1.7;">
                    Codelecta is an interactive programming learning platform designed to make software engineering concepts intuitive, structured, and accessible for everyone.
                </p>
            </div>
        </section>

        <!-- ==================== MISSION & VISION ==================== -->
        <section style="padding: 40px 0 60px 0;">
            <div class="container" style="max-width: 1100px; margin: 0 auto; padding: 0 20px;">
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 28px;">
                    <!-- Mission Card -->
                    <div class="feature-card" style="padding: 36px 32px; border-radius: var(--radius-lg); background: var(--bg-card); border: 1px solid var(--border); box-shadow: var(--shadow-md);">
                        <div class="feature-icon" style="margin-bottom: 20px;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12 6 12 12 16 14"></polyline>
                            </svg>
                        </div>
                        <h3 style="font-size: 1.35rem; font-weight: 700; color: var(--text-primary); margin-bottom: 14px;">Our Mission</h3>
                        <p style="color: var(--text-secondary); font-size: 0.98rem; line-height: 1.7;">
                            To bridge the gap between classroom theory and industry-ready development through step-by-step modular lessons, hands-on examples, and real-time progress tracking.
                        </p>
                    </div>

                    <!-- Vision Card -->
                    <div class="feature-card" style="padding: 36px 32px; border-radius: var(--radius-lg); background: var(--bg-card); border: 1px solid var(--border); box-shadow: var(--shadow-md);">
                        <div class="feature-icon" style="margin-bottom: 20px;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
                            </svg>
                        </div>
                        <h3 style="font-size: 1.35rem; font-weight: 700; color: var(--text-primary); margin-bottom: 14px;">Our Vision</h3>
                        <p style="color: var(--text-secondary); font-size: 0.98rem; line-height: 1.7;">
                            To cultivate a community where aspiring developers master programming paradigms confidently at their own pace without unnecessary complexities.
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==================== CORE PILLARS ==================== -->
        <section style="padding: 40px 0 70px 0; background: var(--bg-subtle);">
            <div class="container" style="max-width: 1100px; margin: 0 auto; padding: 0 20px;">
                <div style="text-align: center; margin-bottom: 50px;">
                    <span style="font-size: 0.85rem; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; color: var(--primary);">WHY CODELECTA</span>
                    <h2 style="font-size: 2.2rem; font-weight: 800; color: var(--text-primary); margin-top: 8px;">What Makes Codelecta Special</h2>
                </div>

                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 24px;">
                    <!-- Pillar 1 -->
                    <div style="background: var(--bg-card); padding: 28px; border-radius: var(--radius-md); border: 1px solid var(--border);">
                        <div style="font-size: 1.8rem; font-weight: 800; color: var(--primary); margin-bottom: 12px;">01</div>
                        <h4 style="font-size: 1.15rem; font-weight: 700; color: var(--text-primary); margin-bottom: 10px;">Structured Paths</h4>
                        <p style="color: var(--text-secondary); font-size: 0.92rem; line-height: 1.6;">Carefully ordered lessons designed to build your foundational understanding before advancing.</p>
                    </div>

                    <!-- Pillar 2 -->
                    <div style="background: var(--bg-card); padding: 28px; border-radius: var(--radius-md); border: 1px solid var(--border);">
                        <div style="font-size: 1.8rem; font-weight: 800; color: var(--secondary); margin-bottom: 12px;">02</div>
                        <h4 style="font-size: 1.15rem; font-weight: 700; color: var(--text-primary); margin-bottom: 10px;">Video & Text Lessons</h4>
                        <p style="color: var(--text-secondary); font-size: 0.92rem; line-height: 1.6;">Support for multimedia content with embedded tutorials, code walkthroughs, and explanations.</p>
                    </div>

                    <!-- Pillar 3 -->
                    <div style="background: var(--bg-card); padding: 28px; border-radius: var(--radius-md); border: 1px solid var(--border);">
                        <div style="font-size: 1.8rem; font-weight: 800; color: var(--accent); margin-bottom: 12px;">03</div>
                        <h4 style="font-size: 1.15rem; font-weight: 700; color: var(--text-primary); margin-bottom: 10px;">Progress Tracking</h4>
                        <p style="color: var(--text-secondary); font-size: 0.92rem; line-height: 1.6;">Enrolled students can track their completion status and pick up right where they left off.</p>
                    </div>

                    <!-- Pillar 4 -->
                    <div style="background: var(--bg-card); padding: 28px; border-radius: var(--radius-md); border: 1px solid var(--border);">
                        <div style="font-size: 1.8rem; font-weight: 800; color: var(--success); margin-bottom: 12px;">04</div>
                        <h4 style="font-size: 1.15rem; font-weight: 700; color: var(--text-primary); margin-bottom: 10px;">Instructor Tools</h4>
                        <p style="color: var(--text-secondary); font-size: 0.92rem; line-height: 1.6;">Dedicated instructor management dashboard to create, update, and organize course curricula.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==================== TECH STACK SECTION ==================== -->
        <section style="padding: 60px 0;">
            <div class="container" style="max-width: 900px; margin: 0 auto; padding: 0 20px; text-align: center;">
                <span style="font-size: 0.85rem; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; color: var(--primary);">PLATFORM ARCHITECTURE</span>
                <h2 style="font-size: 2rem; font-weight: 800; color: var(--text-primary); margin: 8px 0 24px 0;">Pure .NET Web Forms</h2>
                <p style="color: var(--text-secondary); font-size: 1rem; line-height: 1.7; margin-bottom: 36px;">
                    Codelecta is engineered with a clean, high-performance architecture leveraging native Microsoft .NET technologies, ASP.NET Identity, and Entity Framework.
                </p>
                <div style="display: flex; justify-content: center; gap: 16px; flex-wrap: wrap;">
                    <span style="padding: 10px 22px; background: var(--bg-card); border: 1px solid var(--border); border-radius: var(--radius-full); font-weight: 600; color: var(--text-primary); font-size: 0.92rem;">ASP.NET Web Forms 4.8</span>
                    <span style="padding: 10px 22px; background: var(--bg-card); border: 1px solid var(--border); border-radius: var(--radius-full); font-weight: 600; color: var(--text-primary); font-size: 0.92rem;">C# .NET</span>
                    <span style="padding: 10px 22px; background: var(--bg-card); border: 1px solid var(--border); border-radius: var(--radius-full); font-weight: 600; color: var(--text-primary); font-size: 0.92rem;">Entity Framework 6 Code-First</span>
                    <span style="padding: 10px 22px; background: var(--bg-card); border: 1px solid var(--border); border-radius: var(--radius-full); font-weight: 600; color: var(--text-primary); font-size: 0.92rem;">Microsoft SQL Server</span>
                    <span style="padding: 10px 22px; background: var(--bg-card); border: 1px solid var(--border); border-radius: var(--radius-full); font-weight: 600; color: var(--text-primary); font-size: 0.92rem;">OAuth (Google & GitHub)</span>
                </div>
            </div>
        </section>

        <!-- ==================== CTA SECTION ==================== -->
        <section class="cta-section" style="padding: 70px 0; text-align: center; background: var(--gradient-hero);">
            <div class="container" style="max-width: 700px; margin: 0 auto; padding: 0 20px;">
                <h2 style="font-size: 2.2rem; font-weight: 800; color: var(--text-primary); margin-bottom: 16px;">Start Learning with Codelecta</h2>
                <p style="font-size: 1.05rem; color: var(--text-secondary); margin-bottom: 30px;">
                    Explore our available courses and begin your learning journey today.
                </p>
                <div style="display: flex; gap: 16px; justify-content: center; flex-wrap: wrap;">
                    <a href="Courses.aspx" class="btn-primary btn-lg">Explore Courses</a>
                    <a href="Contact.aspx" class="btn-secondary btn-lg">Contact Us</a>
                </div>
            </div>
        </section>
    </main>
</asp:Content>
