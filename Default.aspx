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
                        Interactive lessons, real projects and endless possibilities. Master modern programming with structured courses and hands-on coding.
                    </p>
                    <div class="hero-buttons">
                        <asp:LoginView runat="server">
                            <AnonymousTemplate>
                                <a href="Account/Register" class="btn-pill-primary">Start Learning</a>
                                <a href="Courses" class="btn-pill-secondary">Explore Courses</a>
                            </AnonymousTemplate>
                            <LoggedInTemplate>
                                <a href="Dashboard" class="btn-pill-primary">Go to Dashboard</a>
                                <a href="Courses" class="btn-pill-secondary">Explore Courses</a>
                            </LoggedInTemplate>
                        </asp:LoginView>
                    </div>
                </div>

                <!-- Right: 3D Isometric Laptop & Floating Tech Scene -->
                <div class="hero-visual">
                    <div class="isometric-scene-container">
                        <!-- Floating Tech Tags Around Scene -->
                        <span class="floating-tag tag-php">PHP</span>
                        <span class="floating-tag tag-xml">XML</span>
                        <span class="floating-tag tag-css">CSS</span>
                        <span class="floating-tag tag-sql">SQL</span>
                        <span class="floating-tag tag-code-bracket">&lt;/&gt;</span>
                        <span class="floating-tag tag-brackets">{ }</span>
                        <span class="floating-tag tag-stars">*****</span>

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
                                <linearGradient id="screenBackGradLight" x1="250" y1="75" x2="495" y2="185" gradientUnits="userSpaceOnUse">
                                    <stop offset="0%" stop-color="#312E81" />
                                    <stop offset="100%" stop-color="#1E1B4B" />
                                </linearGradient>

                                <!-- Screen Display UI Gradient -->
                                <linearGradient id="screenUiGradLight" x1="256" y1="82" x2="489" y2="178" gradientUnits="userSpaceOnUse">
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
                            <ellipse cx="370" cy="360" rx="190" ry="65" fill="url(#groundGlowLight)" />

                            <!-- 2. Laptop Base: 3D Extruded Silver-Slate Chassis -->
                            <!-- Base Top Deck -->
                            <polygon points="190,285 435,160 565,225 320,350" fill="url(#deckGradLight)" stroke="#CBD5E1" stroke-width="1.5" />

                            <!-- Base Front Left Edge -->
                            <polygon points="190,285 320,350 320,362 190,297" fill="#94A3B8" />
                            <!-- Base Front Right Edge -->
                            <polygon points="320,350 565,225 565,237 320,362" fill="#64748B" />
                            <!-- Front Rim Highlight Strip -->
                            <line x1="320" y1="362" x2="565" y2="237" stroke="#A855F7" stroke-width="2" stroke-opacity="0.8" />

                            <!-- Keyboard Well Depression -->
                            <polygon points="250,260 425,170 515,215 340,305" fill="#0F172A" stroke="#1E293B" stroke-width="1" />

                            <!-- Keyboard Isometric Key Grid -->
                            <!-- Row 1 -->
                            <polygon points="270,252 410,180 420,185 280,257" fill="#1E293B" stroke="#334155" stroke-width="0.8" />
                            <!-- Row 2 -->
                            <polygon points="282,260 422,188 432,193 292,265" fill="#334155" stroke="#475569" stroke-width="0.8" />
                            <!-- Row 3 -->
                            <polygon points="295,268 435,196 445,201 305,273" fill="#334155" stroke="#475569" stroke-width="0.8" />
                            <!-- Row 4 -->
                            <polygon points="307,276 447,204 457,209 317,281" fill="#334155" stroke="#475569" stroke-width="0.8" />
                            <!-- Spacebar row -->
                            <polygon points="325,286 425,235 435,240 335,291" fill="#475569" stroke="#64748B" stroke-width="0.8" />

                            <!-- Trackpad -->
                            <polygon points="320,308 375,280 405,295 350,323" fill="#E2E8F0" stroke="#818CF8" stroke-width="1.2" />

                            <!-- 3. Laptop Screen: Upright Isometric Display -->
                            <!-- Screen Back Aura / Border -->
                            <polygon points="250,75 495,5 495,185 250,255" fill="url(#screenBackGradLight)" stroke="#818CF8" stroke-width="2.5" filter="url(#screenSoftGlow)" />

                            <!-- Inner Display Frame -->
                            <polygon points="256,82 489,12 489,178 256,248" fill="url(#screenUiGradLight)" stroke="#6366F1" stroke-width="1.5" />

                            <!-- Display Top Header Bar -->
                            <polygon points="256,82 489,12 489,28 256,98" fill="#0F172A" />
                            <circle cx="270" cy="91" r="2.5" fill="#EF4444" />
                            <circle cx="278" cy="89" r="2.5" fill="#F59E0B" />
                            <circle cx="286" cy="87" r="2.5" fill="#10B981" />

                            <!-- 4. On-Screen Interactive Flowchart Diagram -->
                            <polyline points="290,135 340,118 370,140 430,120" stroke="#38BDF8" stroke-width="2.2" stroke-dasharray="4 2" stroke-opacity="0.9" />
                            <polyline points="370,140 370,175 410,162" stroke="#F472B6" stroke-width="2" stroke-opacity="0.9" />

                            <!-- Node 1: Cyan Step Box -->
                            <polygon points="275,130 330,112 330,130 275,148" fill="url(#nodeCyan)" opacity="0.95" />

                            <!-- Node 2: Central Flowchart Diamond Node with { / } -->
                            <polygon points="360,115 390,128 360,148 330,135" fill="url(#nodeAmber)" filter="url(#cyanGlow)" />
                            <text x="350" y="136" fill="#1E1B4B" font-family="'Fira Code', monospace" font-size="10" font-weight="900">{/}</text>

                            <!-- Node 3: Purple Step Box -->
                            <polygon points="340,165 395,148 395,166 340,183" fill="url(#nodePurple)" opacity="0.95" />

                            <!-- Node 4: Cyan Step Box -->
                            <polygon points="405,115 455,98 455,116 405,133" fill="url(#nodeCyan)" opacity="0.9" />

                            <!-- 5. On-Screen Binary Matrix Stream -->
                            <text x="430" y="70" fill="#38BDF8" font-family="'Fira Code', monospace" font-size="9.5" font-weight="700" opacity="0.9" letter-spacing="1">101010 1000</text>
                            <text x="435" y="86" fill="#38BDF8" font-family="'Fira Code', monospace" font-size="9.5" font-weight="700" opacity="0.75" letter-spacing="1">10011 11010</text>
                            <text x="440" y="102" fill="#38BDF8" font-family="'Fira Code', monospace" font-size="9.5" font-weight="700" opacity="0.6" letter-spacing="1">01 00 10</text>
                            <text x="445" y="118" fill="#38BDF8" font-family="'Fira Code', monospace" font-size="9.5" font-weight="700" opacity="0.7" letter-spacing="1">10 1100</text>
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
