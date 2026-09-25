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

                <!-- Right: 3D Isometric Laptop & Floating Tech Scene -->
                <div class="hero-visual">
                    <div class="isometric-scene-container">
                        <!-- Floating Tech Tags Around Scene -->
                        <span class="floating-tag tag-php">PHP</span>
                        <span class="floating-tag tag-sql">SQL</span>
                        <span class="floating-tag tag-code-bracket">&lt;/&gt;</span>

                        <!-- Isometric 3D Laptop SVG Artwork (Light Theme Edition) -->
                        <svg class="isometric-art-svg" viewBox="0 0 600 480" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <defs>
                                <!-- Ground Ambient Glow Filter & Gradient -->
                                <radialGradient id="groundGlowLight" cx="50%" cy="50%" r="50%">
                                    <stop offset="0%" stop-color="#C084FC" stop-opacity="0.3" />
                                    <stop offset="60%" stop-color="#818CF8" stop-opacity="0.12" />
                                    <stop offset="100%" stop-color="#FAF9FF" stop-opacity="0" />
                                </radialGradient>

                                <!-- Screen Glow Filters -->
                                <filter id="screenSoftGlow" x="-20%" y="-20%" width="140%" height="140%">
                                    <feGaussianBlur stdDeviation="6" result="blur" />
                                    <feComposite in="SourceGraphic" in2="blur" operator="over" />
                                </filter>

                                <filter id="cyanGlow" x="-30%" y="-30%" width="160%" height="160%">
                                    <feGaussianBlur stdDeviation="4" result="blur" />
                                    <feComposite in="SourceGraphic" in2="blur" operator="over" />
                                </filter>

                                <!-- Metallic Slate Deck Gradient -->
                                <linearGradient id="deckGradLight" x1="190" y1="285" x2="565" y2="225" gradientUnits="userSpaceOnUse">
                                    <stop offset="0%" stop-color="#F1F5F9" />
                                    <stop offset="50%" stop-color="#E2E8F0" />
                                    <stop offset="100%" stop-color="#CBD5E1" />
                                </linearGradient>

                                <!-- Screen Outer Frame Gradient -->
                                <linearGradient id="screenBackGradLight" x1="120" y1="140" x2="350" y2="290" gradientUnits="userSpaceOnUse">
                                    <stop offset="0%" stop-color="#312E81" />
                                    <stop offset="100%" stop-color="#1E1B4B" />
                                </linearGradient>

                                <!-- Screen Display UI Gradient -->
                                <linearGradient id="screenUiGradLight" x1="130" y1="150" x2="340" y2="282" gradientUnits="userSpaceOnUse">
                                    <stop offset="0%" stop-color="#1E1B4B" />
                                    <stop offset="100%" stop-color="#0F172A" />
                                </linearGradient>

                                <!-- Flowchart Nodes Gradients -->
                                <linearGradient id="nodeCyan" x1="0%" y1="0%" x2="100%" y2="100%">
                                    <stop offset="0%" stop-color="#38BDF8" />
                                    <stop offset="100%" stop-color="#0284C7" />
                                </linearGradient>

                                <linearGradient id="nodePurple" x1="0%" y1="0%" x2="100%" y2="100%">
                                    <stop offset="0%" stop-color="#C084FC" />
                                    <stop offset="100%" stop-color="#7C3AED" />
                                </linearGradient>

                                <linearGradient id="nodeAmber" x1="0%" y1="0%" x2="100%" y2="100%">
                                    <stop offset="0%" stop-color="#FDE047" />
                                    <stop offset="100%" stop-color="#F59E0B" />
                                </linearGradient>
                            </defs>

                            <!-- 1. Ambient Floor Glow -->
                            <ellipse cx="330" cy="370" rx="200" ry="60" fill="url(#groundGlowLight)" />

                            <!-- 2. Laptop Base: 3D Extruded Silver-Slate Chassis (Aligned Isometric Perspective) -->
                            <!-- Base Top Deck -->
                            <polygon points="120,290 350,175 520,260 290,375" fill="url(#deckGradLight)" stroke="#CBD5E1" stroke-width="1.5" />

                            <!-- Base Front Left Edge -->
                            <polygon points="120,290 290,375 290,388 120,303" fill="#94A3B8" />
                            <!-- Base Front Right Edge -->
                            <polygon points="290,375 520,260 520,273 290,388" fill="#64748B" />
                            <!-- Front Rim Highlight Strip -->
                            <line x1="290" y1="388" x2="520" y2="273" stroke="#A855F7" stroke-width="2" stroke-opacity="0.8" />

                            <!-- Keyboard Well Depression -->
                            <polygon points="180,270 340,190 460,250 300,330" fill="#0F172A" stroke="#1E293B" stroke-width="1" />

                            <!-- Keyboard Isometric Key Grid -->
                            <!-- Row 1 -->
                            <polygon points="200,260 330,195 340,200 210,265" fill="#1E293B" stroke="#334155" stroke-width="0.8" />
                            <!-- Row 2 -->
                            <polygon points="215,268 345,203 355,208 225,273" fill="#334155" stroke="#475569" stroke-width="0.8" />
                            <!-- Row 3 -->
                            <polygon points="230,276 360,211 370,216 240,281" fill="#334155" stroke="#475569" stroke-width="0.8" />
                            <!-- Row 4 -->
                            <polygon points="245,284 375,219 385,224 255,289" fill="#334155" stroke="#475569" stroke-width="0.8" />
                            <!-- Spacebar row -->
                            <polygon points="265,294 365,244 375,249 275,299" fill="#475569" stroke="#64748B" stroke-width="0.8" />

                            <!-- Trackpad (Centered on front deck) -->
                            <polygon points="275,335 330,307 360,322 305,350" fill="#E2E8F0" stroke="#818CF8" stroke-width="1.2" />

                            <!-- Hinge Bar connecting screen to base -->
                            <polygon points="120,290 350,175 356,178 126,293" fill="#475569" />

                            <!-- 3. Laptop Screen: Perfectly Aligned to Base Top-Left Hinge -->
                            <!-- Screen Back Shell -->
                            <polygon points="120,290 350,175 350,25 120,140" fill="url(#screenBackGradLight)" stroke="#818CF8" stroke-width="2.5" filter="url(#screenSoftGlow)" />

                            <!-- Inner Display Bezel -->
                            <polygon points="132,282 342,175 342,37 132,144" fill="url(#screenUiGradLight)" stroke="#6366F1" stroke-width="1.5" />

                            <!-- Display Top Header Bar -->
                            <polygon points="132,144 342,37 342,52 132,159" fill="#0F172A" />
                            <circle cx="145" cy="152" r="2.2" fill="#EF4444" />
                            <circle cx="153" cy="148" r="2.2" fill="#F59E0B" />
                            <circle cx="161" cy="144" r="2.2" fill="#10B981" />

                            <!-- 4. On-Screen Interactive Flowchart Diagram (Mapped to Screen Plane) -->
                            <polyline points="230,150 265,133 285,150 320,132" stroke="#38BDF8" stroke-width="1.8" stroke-dasharray="3 2" stroke-opacity="0.9" />
                            <polyline points="285,150 285,175 305,165" stroke="#F472B6" stroke-width="1.6" stroke-opacity="0.9" />

                            <!-- Node 1: Cyan Step Box -->
                            <polygon points="220,146 250,131 250,144 220,159" fill="url(#nodeCyan)" opacity="0.95" />

                            <!-- Node 2: Central Flowchart Diamond Node with { / } -->
                            <polygon points="280,138 298,147 280,161 262,152" fill="url(#nodeAmber)" filter="url(#cyanGlow)" />
                            <text x="274" y="153" fill="#1E1B4B" font-family="'Fira Code', monospace" font-size="8" font-weight="900">{/}</text>

                            <!-- Node 3: Purple Step Box -->
                            <polygon points="268,172 298,157 298,170 268,185" fill="url(#nodePurple)" opacity="0.95" />

                            <!-- Node 4: Cyan Step Box -->
                            <polygon points="305,130 335,115 335,128 305,143" fill="url(#nodeCyan)" opacity="0.9" />

                            <!-- 5. On-Screen Binary Matrix Stream -->
                            <text x="300" y="80" fill="#38BDF8" font-family="'Fira Code', monospace" font-size="7.5" font-weight="700" opacity="0.85" letter-spacing="0.5">101010 1000</text>
                            <text x="303" y="92" fill="#38BDF8" font-family="'Fira Code', monospace" font-size="7.5" font-weight="700" opacity="0.75" letter-spacing="0.5">10011 11010</text>
                            <text x="306" y="104" fill="#38BDF8" font-family="'Fira Code', monospace" font-size="7.5" font-weight="700" opacity="0.6" letter-spacing="0.5">01 00 10</text>
                        </svg>

                        <!-- Floating Acrylic Code Snippet Card (Light Theme) -->
                        <div class="hero-code-card-floating">
                            <div class="acrylic-card-header">
                                <span class="acrylic-dot" style="background: #EF4444;"></span>
                                <span class="acrylic-dot" style="background: #F59E0B;"></span>
                                <span class="acrylic-dot" style="background: #10B981;"></span>
                                <span style="margin-left: auto; font-size: 0.68rem; color: #6C5CE7; font-family: monospace; font-weight: 800;">Codelecta.cs</span>
                            </div>
                            <div class="acrylic-code-body">
                                <div><span class="c-purple">class</span> <span class="c-cyan">Codelecta</span> {</div>
                                <div>&nbsp;&nbsp;<span class="c-purple">void</span> <span class="c-yellow">Learn</span>() {</div>
                                <div>&nbsp;&nbsp;&nbsp;&nbsp;<span class="c-purple">var</span> p = <span class="c-green">"Success"</span>;</div>
                                <div>&nbsp;&nbsp;&nbsp;&nbsp;<span class="c-cyan">Console</span>.<span class="c-yellow">Write</span>(p);</div>
                                <div>&nbsp;&nbsp;}</div>
                                <div>}</div>
                            </div>
                        </div>

                        <!-- Floating Language Capsule Pill Bar (Bottom Right of Laptop) -->
                        <div class="hero-lang-capsule">
                            <span class="capsule-arrow">&lt;</span>
                            <span class="capsule-badge badge-csharp">C#</span>
                            <span class="capsule-badge badge-js">JS</span>
                            <span class="capsule-badge" style="background: #065F46; border-color: #34D399;">Py</span>
                            <span class="capsule-badge badge-r">R</span>
                            <span class="capsule-arrow">&gt;</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==================== FEATURES BAR SECTION ==================== -->
        <section class="features-bar-section">
            <div class="container">
                <div class="features-bar-card reveal">
                    <!-- Item 1: Interactive Lessons -->
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
                            <p>Learn through structured, bite-sized lessons.</p>
                        </div>
                    </div>
                    <!-- Item 2: Personalized Learning -->
                    <div class="feature-bar-item">
                        <div class="feature-bar-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <circle cx="12" cy="12" r="6"></circle>
                                <circle cx="12" cy="12" r="2"></circle>
                            </svg>
                        </div>
                        <div class="feature-bar-text">
                            <h4>Personalized Learning</h4>
                            <p>Get course recommendations based on experience level.</p>
                        </div>
                    </div>
                    <!-- Item 3: Interactive Quizzes -->
                    <div class="feature-bar-item">
                        <div class="feature-bar-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polygon points="12 8 8 12 12 16 16 12 12 8"></polygon>
                            </svg>
                        </div>
                        <div class="feature-bar-text">
                            <h4>Interactive Quizzes</h4>
                            <p>Test your understanding while learning.</p>
                        </div>
                    </div>
                    <!-- Item 4: Progress Tracking -->
                    <div class="feature-bar-item">
                        <div class="feature-bar-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <line x1="18" y1="20" x2="18" y2="10"></line>
                                <line x1="12" y1="20" x2="12" y2="4"></line>
                                <line x1="6" y1="20" x2="6" y2="14"></line>
                            </svg>
                        </div>
                        <div class="feature-bar-text">
                            <h4>Progress Tracking</h4>
                            <p>Track learning progress across courses.</p>
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
                
                <asp:Repeater ID="rptTopCourses" runat="server">
                    <HeaderTemplate>
                        <div class="courses-grid">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <a href='CourseDetail.aspx?id=<%# Eval("Id") %>' class="course-card reveal">
                            <div class="course-card-thumb">
                                <img src='<%# Eval("ThumbnailUrl") %>' alt='<%# Eval("Title") %>' loading="lazy" />
                                <span class="course-level-badge"><%# Eval("Level") %></span>
                            </div>
                            <div class="course-card-body">
                                <div class="course-icon-badge <%# Eval("BadgeClass") %>"><%# Eval("ImageTag") %></div>
                                <h3><%# Eval("Title") %></h3>
                                <p><%# Eval("LessonCount") %> lessons</p>
                            </div>
                        </a>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnlFallbackCourses" runat="server" Visible="false">
                    <div class="courses-grid">
                        <a href="Courses" class="course-card reveal">
                            <div class="course-card-thumb">
                                <img src="Content/images/courses/python.svg" alt="Python Programming" loading="lazy" />
                                <span class="course-level-badge">Beginner</span>
                            </div>
                            <div class="course-card-body">
                                <div class="course-icon-badge python-badge">Py</div>
                                <h3>Python Programming</h3>
                                <p>5 lessons</p>
                            </div>
                        </a>
                        <a href="Courses" class="course-card reveal">
                            <div class="course-card-thumb">
                                <img src="Content/images/courses/javascript.svg" alt="JavaScript Essentials" loading="lazy" />
                                <span class="course-level-badge">Beginner</span>
                            </div>
                            <div class="course-card-body">
                                <div class="course-icon-badge js-badge">JS</div>
                                <h3>JavaScript Essentials</h3>
                                <p>5 lessons</p>
                            </div>
                        </a>
                        <a href="Courses" class="course-card reveal">
                            <div class="course-card-thumb">
                                <img src="Content/images/courses/csharp.svg" alt="C# Fundamentals" loading="lazy" />
                                <span class="course-level-badge">Beginner</span>
                            </div>
                            <div class="course-card-body">
                                <div class="course-icon-badge csharp-badge">C#</div>
                                <h3>C# Fundamentals</h3>
                                <p>5 lessons</p>
                            </div>
                        </a>
                        <a href="Courses" class="course-card reveal">
                            <div class="course-card-thumb">
                                <img src="Content/images/courses/react.svg" alt="React for Web Apps" loading="lazy" />
                                <span class="course-level-badge">Intermediate</span>
                            </div>
                            <div class="course-card-body">
                                <div class="course-icon-badge react-badge">&#9883;</div>
                                <h3>React for Web Apps</h3>
                                <p>5 lessons</p>
                            </div>
                        </a>
                    </div>
                </asp:Panel>
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
                        <h3>Choose Your Level</h3>
                        <p>Select courses matched to your experience level, from beginner to advanced.</p>
                    </div>
                    <div class="journey-step reveal">
                        <div class="step-number">02</div>
                        <h3>Learn & Practice</h3>
                        <p>Study structured lessons, run code examples, and test knowledge with quizzes.</p>
                    </div>
                    <div class="journey-step reveal">
                        <div class="step-number">03</div>
                        <h3>Track Your Progress</h3>
                        <p>Monitor completed lessons, quiz scores, and achievements on your dashboard.</p>
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
