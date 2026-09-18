<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Codelecta_2._0._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <!-- ==================== HERO SECTION (3D ISOMETRIC MODERN LIGHT THEME) ==================== -->
        <section class="hero-section" aria-labelledby="heroTitle">
            <div class="hero-container">
                <!-- Left: Hero Content -->
                <div class="hero-content">
                    <div class="hero-badge-tag">
                        <span class="badge-glow-dot"></span>
                        LEARN. CODE. BUILD.
                    </div>
                    <h1 id="heroTitle" class="hero-title">
                        Code. Learn.<br />
                        <span class="hero-highlight">Innovate.</span> <span class="purple-text">Repeat.</span>
                    </h1>
                    <p class="hero-text">
                        Interactive lessons, personalized learning paths, and progress tracking. Master modern programming with structured courses and interactive quizzes.
                    </p>
                    <div class="hero-buttons">
                        <asp:LoginView runat="server">
                            <AnonymousTemplate>
                                <a href="<%= ResolveUrl("~/Account/Register") %>" class="btn-pill-primary">Start Learning</a>
                                <a href="<%= ResolveUrl("~/Courses") %>" class="btn-pill-secondary">Explore Courses</a>
                            </AnonymousTemplate>
                            <LoggedInTemplate>
                                <a href="<%# GetDashboardUrl() %>" class="btn-pill-primary">Go to Dashboard</a>
                                <a href="<%# ResolveUrl("~/Courses") %>" class="btn-pill-secondary">Explore Courses</a>
                            </LoggedInTemplate>
                        </asp:LoginView>
                    </div>
                </div>

                <!-- Right: One Cohesive Programming Visual -->
                <div class="hero-visual">
                    <div class="hero-visual-wrapper">
                        <!-- Subtle Geometric Accent (Echoing the official 3D Cube Logo) -->
                        <div class="hero-geo-backdrop" aria-hidden="true">
                            <svg class="geo-cube-svg" viewBox="0 0 400 400" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M200 40 L340 120 V280 L200 360 L60 280 V120 Z" stroke="url(#geoHexGrad)" stroke-width="1.5" stroke-dasharray="6 6" opacity="0.45" />
                                <path d="M200 200 L340 120 M200 200 V360 M200 200 L60 120" stroke="url(#geoHexGrad)" stroke-width="1.5" opacity="0.35" />
                                <circle cx="200" cy="200" r="145" stroke="url(#geoCircleGrad)" stroke-width="1" stroke-dasharray="4 8" opacity="0.3" />
                                <defs>
                                    <linearGradient id="geoHexGrad" x1="60" y1="40" x2="340" y2="360" gradientUnits="userSpaceOnUse">
                                        <stop offset="0%" stop-color="#8B5CF6" />
                                        <stop offset="100%" stop-color="#6C5CE7" />
                                    </linearGradient>
                                    <linearGradient id="geoCircleGrad" x1="60" y1="60" x2="340" y2="340" gradientUnits="userSpaceOnUse">
                                        <stop offset="0%" stop-color="#C084FC" stop-opacity="0.6" />
                                        <stop offset="100%" stop-color="#6366F1" stop-opacity="0" />
                                    </linearGradient>
                                </defs>
                            </svg>
                            <div class="geo-ambient-glow"></div>
                        </div>

                        <!-- Central Programming Interface: Codelecta Studio Workspace -->
                        <div class="code-workspace-window">
                            <!-- Window Titlebar -->
                            <div class="workspace-titlebar">
                                <div class="window-controls">
                                    <span class="control-dot dot-close"></span>
                                    <span class="control-dot dot-minimize"></span>
                                    <span class="control-dot dot-maximize"></span>
                                </div>

                                <!-- Integrated File Tabs -->
                                <div class="workspace-tabs">
                                    <div class="workspace-tab active-tab">
                                        <span class="tab-icon-badge badge-cs">C#</span>
                                        <span class="tab-name">Lesson_04.cs</span>
                                    </div>
                                    <div class="workspace-tab">
                                        <span class="tab-icon-badge badge-py">Py</span>
                                        <span class="tab-name">exercise.py</span>
                                    </div>
                                    <div class="workspace-tab">
                                        <span class="tab-icon-badge badge-js">JS</span>
                                        <span class="tab-name">quiz.js</span>
                                    </div>
                                </div>

                                <!-- Workspace Status Badge -->
                                <div class="workspace-status">
                                    <span class="status-live-dot"></span>
                                    <span class="status-text">Interactive</span>
                                </div>
                            </div>

                            <!-- Code Editor Body -->
                            <div class="workspace-editor-body">
                                <div class="editor-sidebar-strip" aria-hidden="true">
                                    <span class="strip-icon active" title="Explorer">📁</span>
                                    <span class="strip-icon" title="Progress">🎯</span>
                                    <span class="strip-icon" title="Quiz">⚡</span>
                                </div>

                                <div class="code-pane">
                                    <div class="code-line">
                                        <span class="line-num">01</span>
                                        <span class="code-text"><span class="token-comment">// Codelecta: Interactive Lesson & Quiz</span></span>
                                    </div>
                                    <div class="code-line">
                                        <span class="line-num">02</span>
                                        <span class="code-text"><span class="token-keyword">using</span> <span class="token-namespace">Codelecta</span>.<span class="token-namespace">Learning</span>;</span>
                                    </div>
                                    <div class="code-line">
                                        <span class="line-num">03</span>
                                        <span class="code-text">&nbsp;</span>
                                    </div>
                                    <div class="code-line active-code-line">
                                        <span class="line-num">04</span>
                                        <span class="code-text"><span class="token-keyword">var</span> learner = <span class="token-keyword">await</span> <span class="token-class">CodelectaUser</span>.<span class="token-method">GetProfileAsync</span>();</span>
                                    </div>
                                    <div class="code-line">
                                        <span class="line-num">05</span>
                                        <span class="code-text"><span class="token-keyword">var</span> track = learner.<span class="token-method">RecommendTrack</span>(<span class="token-class">Level</span>.<span class="token-property">Beginner</span>);</span>
                                    </div>
                                    <div class="code-line">
                                        <span class="line-num">06</span>
                                        <span class="code-text">&nbsp;</span>
                                    </div>
                                    <div class="code-line">
                                        <span class="line-num">07</span>
                                        <span class="code-text"><span class="token-keyword">await</span> track.<span class="token-method">CompleteLessonAsync</span>(<span class="token-number">4</span>);</span>
                                    </div>
                                    <div class="code-line">
                                        <span class="line-num">08</span>
                                        <span class="code-text"><span class="token-class">Console</span>.<span class="token-method">WriteLine</span>(<span class="token-string">"Progress updated! Take quiz &rarr;"</span>);<span class="code-cursor"></span></span>
                                    </div>
                                </div>
                            </div>

                            <!-- Integrated Terminal / Output Console -->
                            <div class="workspace-terminal">
                                <div class="terminal-header">
                                    <div class="terminal-title">
                                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                            <polyline points="4 17 10 11 4 5"></polyline>
                                            <line x1="12" y1="19" x2="20" y2="19"></line>
                                        </svg>
                                        <span>Interactive Output</span>
                                    </div>
                                    <span class="terminal-pill">Exit Code: 0</span>
                                </div>
                                <div class="terminal-content">
                                    <div class="terminal-row success-row">
                                        <span class="term-check">&#10003;</span>
                                        <span class="term-msg">Lesson 04 completed &bull; <strong>+50 XP earned</strong></span>
                                    </div>
                                    <div class="terminal-row info-row">
                                        <span class="term-arrow">&gt;</span>
                                        <span class="term-msg">Course Progress: <span class="term-highlight">80%</span> &bull; 1 Lesson remaining</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Anchored Progress Badge -->
                            <div class="workspace-docked-badge">
                                <div class="docked-badge-icon">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                                        <polyline points="22 4 12 14.01 9 11.01"></polyline>
                                    </svg>
                                </div>
                                <div class="docked-badge-text">
                                    <span class="docked-badge-label">Quiz Ready</span>
                                    <span class="docked-badge-val">Passing Score: 70%+</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==================== FEATURES BAR SECTION ==================== -->
        <section class="features-bar-section">
            <div class="container">
                <div class="features-bar-card reveal">
                    <!-- Item 1 -->
                    <div class="feature-bar-item">
                        <div class="feature-bar-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                                <line x1="8" y1="21" x2="16" y2="21"></line>
                                <line x1="12" y1="17" x2="12" y2="21"></line>
                            </svg>
                        </div>
                        <div class="feature-bar-text">
                            <h4>Interactive Lessons</h4>
                            <p>Engage with bite-sized lessons.</p>
                        </div>
                    </div>
                    <!-- Item 2 -->
                    <div class="feature-bar-item">
                        <div class="feature-bar-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                            </svg>
                        </div>
                        <div class="feature-bar-text">
                            <h4>Real Projects</h4>
                            <p>Build real-world projects.</p>
                        </div>
                    </div>
                    <!-- Item 3 -->
                    <div class="feature-bar-item">
                        <div class="feature-bar-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="8" r="7"></circle>
                                <polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline>
                            </svg>
                        </div>
                        <div class="feature-bar-text">
                            <h4>Certificates</h4>
                            <p>Earn certificates and get recognized.</p>
                        </div>
                    </div>
                    <!-- Item 4 -->
                    <div class="feature-bar-item">
                        <div class="feature-bar-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                                <polyline points="22 4 12 14.01 9 11.01"></polyline>
                            </svg>
                        </div>
                        <div class="feature-bar-text">
                            <h4>Flexible Learning</h4>
                            <p>Learn anytime, anywhere.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==================== TOP COURSES SECTION ==================== -->
        <section class="courses-section" aria-labelledby="coursesTitle">
            <div class="container">
                <div class="section-header flex-header reveal">
                    <h2 id="coursesTitle" class="section-title">Top Courses</h2>
                    <a href="Courses" class="view-all-link">View all &rarr;</a>
                </div>
                <div class="courses-grid">
                    <!-- Course 1: Python -->
                    <a href="Courses" class="course-card reveal">
                        <div class="course-icon-badge python-badge">Py</div>
                        <div class="course-card-info">
                            <h3>Python</h3>
                            <p>Beginner to Advanced</p>
                        </div>
                    </a>

                    <!-- Course 2: React -->
                    <a href="Courses" class="course-card reveal">
                        <div class="course-icon-badge react-badge">&#9883;</div>
                        <div class="course-card-info">
                            <h3>React</h3>
                            <p>Build Web Apps</p>
                        </div>
                    </a>

                    <!-- Course 3: Java -->
                    <a href="Courses" class="course-card reveal">
                        <div class="course-icon-badge java-badge">&#9749;</div>
                        <div class="course-card-info">
                            <h3>Java</h3>
                            <p>Object Oriented</p>
                        </div>
                    </a>

                    <!-- Course 4: JavaScript -->
                    <a href="Courses" class="course-card reveal">
                        <div class="course-icon-badge js-badge">JS</div>
                        <div class="course-card-info">
                            <h3>JavaScript</h3>
                            <p>Web Development</p>
                        </div>
                    </a>
                </div>
            </div>
        </section>

        <!-- ==================== LEARNING JOURNEY ==================== -->
        <section class="journey-section" aria-labelledby="journeyTitle">
            <div class="container">
                <div class="section-header reveal">
                    <h2 id="journeyTitle" class="section-title">Start Your Learning Journey</h2>
                    <p class="section-subtitle">Three simple steps to build your programming foundation.</p>
                </div>
                <div class="journey-steps">
                    <div class="journey-step reveal">
                        <div class="step-number">01</div>
                        <h3>Choose a Course</h3>
                        <p>Find a programming course suitable for your current level and goals.</p>
                    </div>
                    <div class="journey-step reveal">
                        <div class="step-number">02</div>
                        <h3>Learn at Your Pace</h3>
                        <p>Study structured lessons with examples, videos, and quizzes.</p>
                    </div>
                    <div class="journey-step reveal">
                        <div class="step-number">03</div>
                        <h3>Track Your Progress</h3>
                        <p>Complete lessons and monitor your learning activity.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==================== TARGET AUDIENCE ==================== -->
        <section class="audience-section" aria-labelledby="audienceTitle">
            <div class="container">
                <div class="section-header reveal">
                    <h2 id="audienceTitle" class="section-title">Built for Different Learning Goals</h2>
                    <p class="section-subtitle">Designed for both academic excellence and professional growth.</p>
                </div>
                <div class="audience-grid">
                    <div class="audience-card reveal">
                        <div class="audience-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M22 10v6M2 10l10-5 10 5-10 5z"></path>
                                <path d="M6 12v5c3 3 10 3 12 0v-5"></path>
                            </svg>
                        </div>
                        <h3>University Students</h3>
                        <p>Strengthen your programming knowledge outside the classroom with focused lessons and practical examples.</p>
                    </div>
                    <div class="audience-card reveal">
                        <div class="audience-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                                <line x1="8" y1="21" x2="16" y2="21"></line>
                                <line x1="12" y1="17" x2="12" y2="21"></line>
                            </svg>
                        </div>
                        <h3>Working Professionals</h3>
                        <p>Build programming skills at your own pace and learn around your work schedule.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==================== CTA SECTION ==================== -->
        <section class="cta-section" aria-labelledby="ctaTitle">
            <div class="cta-content reveal">
                <h2 id="ctaTitle">Ready to Start Coding?</h2>
                <p>Build your programming foundation with structured, practical, and self-paced learning.</p>
                <asp:LoginView runat="server">
                    <AnonymousTemplate>
                        <a href="Account/Register" class="btn-pill-primary" style="font-size: 1.05rem; padding: 15px 38px; background: #FFFFFF !important; color: #6C5CE7 !important; box-shadow: 0 8px 30px rgba(0,0,0,0.2);">Create Your Free Account</a>
                    </AnonymousTemplate>
                    <LoggedInTemplate>
                        <a href="Dashboard" class="btn-pill-primary" style="font-size: 1.05rem; padding: 15px 38px; background: #FFFFFF !important; color: #6C5CE7 !important; box-shadow: 0 8px 30px rgba(0,0,0,0.2);">Continue Learning</a>
                    </LoggedInTemplate>
                </asp:LoginView>
            </div>
        </section>
    </main>

</asp:Content>
