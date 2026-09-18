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

                <!-- Right: Refined Cohesive 3D Programming Illustration -->
                <div class="hero-visual">
                    <div class="hero-composition-wrapper">
                        <!-- Subtle Background Depth Accent -->
                        <div class="hero-depth-backdrop" aria-hidden="true">
                            <div class="depth-glow"></div>
                            <svg class="depth-geo-ring" viewBox="0 0 420 420" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <circle cx="210" cy="210" r="160" stroke="#DDD6FE" stroke-width="1.2" stroke-dasharray="4 8" opacity="0.4" />
                                <ellipse cx="210" cy="240" rx="190" ry="110" stroke="#C084FC" stroke-width="1" stroke-dasharray="6 6" opacity="0.25" />
                            </svg>
                        </div>

                        <!-- Top Floating Code Card (Subtle Overlap on Upper Screen) -->
                        <div class="floating-code-card">
                            <div class="code-card-header">
                                <span class="card-dot dot-red"></span>
                                <span class="card-dot dot-yellow"></span>
                                <span class="card-dot dot-green"></span>
                                <span class="card-file-name">learn.js</span>
                            </div>
                            <div class="code-card-snippet">
                                <div><span class="tok-kw">function</span> <span class="tok-fn">learn</span>() {</div>
                                <div>&nbsp;&nbsp;<span class="tok-kw">return</span> <span class="tok-str">"Codelecta"</span>;</div>
                                <div>}</div>
                            </div>
                        </div>

                        <!-- 3D Modern Laptop Artwork (Perspective Angled Illustration) -->
                        <div class="laptop-3d-scene">
                            <svg class="laptop-svg-artwork" viewBox="0 0 600 460" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <defs>
                                    <!-- Ambient Ground Shadow & Glow -->
                                    <radialGradient id="laptopFloorGlow" cx="50%" cy="50%" r="50%">
                                        <stop offset="0%" stop-color="#C084FC" stop-opacity="0.32" />
                                        <stop offset="55%" stop-color="#818CF8" stop-opacity="0.1" />
                                        <stop offset="100%" stop-color="#FAF9FF" stop-opacity="0" />
                                    </radialGradient>

                                    <!-- Screen Display Gradient -->
                                    <linearGradient id="screenDisplayGrad" x1="230" y1="84" x2="475" y2="176" gradientUnits="userSpaceOnUse">
                                        <stop offset="0%" stop-color="#1E1B4B" />
                                        <stop offset="100%" stop-color="#0F172A" />
                                    </linearGradient>

                                    <!-- Laptop Silver-Slate Metallic Chassis Gradients -->
                                    <linearGradient id="laptopBaseDeckGrad" x1="160" y1="285" x2="550" y2="225" gradientUnits="userSpaceOnUse">
                                        <stop offset="0%" stop-color="#F8FAFC" />
                                        <stop offset="40%" stop-color="#E2E8F0" />
                                        <stop offset="85%" stop-color="#CBD5E1" />
                                        <stop offset="100%" stop-color="#94A3B8" />
                                    </linearGradient>

                                    <linearGradient id="screenBezelGrad" x1="220" y1="72" x2="485" y2="188" gradientUnits="userSpaceOnUse">
                                        <stop offset="0%" stop-color="#312E81" />
                                        <stop offset="100%" stop-color="#0F172A" />
                                    </linearGradient>

                                    <!-- Neon Accent Gradient -->
                                    <linearGradient id="neonAccentGrad" x1="0%" y1="0%" x2="100%" y2="0%">
                                        <stop offset="0%" stop-color="#8B5CF6" />
                                        <stop offset="60%" stop-color="#A855F7" />
                                        <stop offset="100%" stop-color="#06B6D4" />
                                    </linearGradient>

                                    <!-- Screen Glass Sheen Overlay -->
                                    <linearGradient id="glassReflectionGrad" x1="240" y1="20" x2="440" y2="240" gradientUnits="userSpaceOnUse">
                                        <stop offset="0%" stop-color="#FFFFFF" stop-opacity="0.12" />
                                        <stop offset="35%" stop-color="#FFFFFF" stop-opacity="0.03" />
                                        <stop offset="70%" stop-color="#FFFFFF" stop-opacity="0" />
                                    </linearGradient>

                                    <!-- Soft Shadow Filter -->
                                    <filter id="softScreenGlow" x="-15%" y="-15%" width="130%" height="130%">
                                        <feGaussianBlur stdDeviation="5" result="blur" />
                                        <feComposite in="SourceGraphic" in2="blur" operator="over" />
                                    </filter>
                                </defs>

                                <!-- 1. Ground Shadow & Soft Floor Glow -->
                                <ellipse cx="360" cy="370" rx="195" ry="58" fill="url(#laptopFloorGlow)" />
                                <ellipse cx="355" cy="372" rx="145" ry="30" fill="#0F172A" opacity="0.08" />

                                <!-- 2. 3D Laptop Base Chassis (Angled Isometric Extrusion) -->
                                <!-- Base Top Deck Surface -->
                                <polygon points="160,285 415,155 550,225 295,355" fill="url(#laptopBaseDeckGrad)" stroke="#CBD5E1" stroke-width="1.2" />

                                <!-- Base Front-Left Edge -->
                                <polygon points="160,285 295,355 295,368 160,298" fill="#94A3B8" />

                                <!-- Base Front-Right Edge -->
                                <polygon points="295,355 550,225 550,238 295,368" fill="#64748B" />

                                <!-- Front Rim Glow Highlight Line -->
                                <line x1="295" y1="368" x2="550" y2="238" stroke="url(#neonAccentGrad)" stroke-width="2.2" stroke-linecap="round" />

                                <!-- Keyboard Recessed Well -->
                                <polygon points="220,260 398,168 495,217 318,309" fill="#0F172A" stroke="#1E293B" stroke-width="1" />

                                <!-- Isometric Keyboard Key Rows with Sleek Backlighting -->
                                <polygon points="238,252 384,178 394,183 248,257" fill="#1E293B" stroke="#334155" stroke-width="0.8" />
                                <polygon points="252,260 398,186 408,191 262,265" fill="#1E293B" stroke="#334155" stroke-width="0.8" />
                                <polygon points="266,268 412,194 422,199 276,273" fill="#1E293B" stroke="#334155" stroke-width="0.8" />
                                <polygon points="280,276 426,202 436,207 290,281" fill="#1E293B" stroke="#334155" stroke-width="0.8" />

                                <!-- Spacebar -->
                                <polygon points="305,288 395,242 405,247 315,293" fill="#334155" stroke="#475569" stroke-width="0.8" />

                                <!-- Precision Trackpad -->
                                <polygon points="296,316 354,286 386,302 328,332" fill="#E2E8F0" stroke="#818CF8" stroke-width="1.2" />

                                <!-- 3. Upright 3D Laptop Display Screen -->
                                <!-- Screen Outer Lid Frame with Subtle Shadow -->
                                <polygon points="224,72 485,2 485,188 224,258" fill="url(#screenBezelGrad)" stroke="#6366F1" stroke-width="2" filter="url(#softScreenGlow)" />

                                <!-- Inner Screen Bezel Rim -->
                                <polygon points="230,78 479,10 479,182 230,250" fill="#0F172A" />

                                <!-- Active High-Contrast Glass Display Surface -->
                                <polygon points="235,84 474,16 474,176 235,244" fill="url(#screenDisplayGrad)" />

                                <!-- Integrated Webcam Dot -->
                                <circle cx="358" cy="46" r="2" fill="#334155" />
                                <circle cx="358" cy="46" r="0.8" fill="#10B981" />

                                <!-- Display Header Bar: Window Controls & Lesson Pill -->
                                <polygon points="235,84 474,16 474,36 235,104" fill="#1E293B" />
                                <circle cx="248" cy="97" r="2.5" fill="#EF4444" />
                                <circle cx="256" cy="94" r="2.5" fill="#F59E0B" />
                                <circle cx="264" cy="91" r="2.5" fill="#10B981" />
                                <text x="278" y="94" fill="#C084FC" font-family="'Inter', -apple-system, sans-serif" font-size="7.5" font-weight="700" letter-spacing="0.5">Lesson 03 &bull; Functions &amp; Logic</text>

                                <!-- Sleek Course Progress Indicator Line -->
                                <line x1="245" y1="112" x2="455" y2="52" stroke="#334155" stroke-width="2.5" stroke-linecap="round" />
                                <line x1="245" y1="112" x2="413" y2="64" stroke="url(#neonAccentGrad)" stroke-width="2.5" stroke-linecap="round" />

                                <!-- Clean Syntax-Highlighted Code Editor Lines -->
                                <text x="246" y="132" fill="#64748B" font-family="'Fira Code', monospace" font-size="8" font-weight="600">// Interactive Lesson</text>
                                <text x="248" y="148" fill="#93C5FD" font-family="'Fira Code', monospace" font-size="8.5" font-weight="600"><tspan fill="#C084FC">var</tspan> dev = <tspan fill="#FDE047">Codelecta</tspan>.<tspan fill="#38BDF8">Init</tspan>();</text>
                                <text x="250" y="164" fill="#93C5FD" font-family="'Fira Code', monospace" font-size="8.5" font-weight="600"><tspan fill="#C084FC">await</tspan> dev.<tspan fill="#38BDF8">Learn</tspan>();</text>

                                <!-- Small Interactive Elements on Screen -->
                                <!-- Interactive "RUN >" Action Button -->
                                <polygon points="380,88 440,71 440,87 380,104" fill="url(#neonAccentGrad)" />
                                <text x="395" y="96" fill="#FFFFFF" font-family="'Inter', -apple-system, sans-serif" font-size="7.2" font-weight="800">RUN &gt;</text>

                                <!-- Verified Output Toast Badge -->
                                <polygon points="365,116 455,90 455,106 365,132" fill="#065F46" fill-opacity="0.6" stroke="#10B981" stroke-width="0.8" />
                                <text x="374" y="123" fill="#34D399" font-family="'Inter', -apple-system, sans-serif" font-size="6.8" font-weight="700">&#10003; Output: OK (80%)</text>

                                <!-- Diagonal Glass Screen Sheen Reflection -->
                                <polygon points="260,80 340,56 410,194 330,218" fill="url(#glassReflectionGrad)" pointer-events="none" />
                            </svg>
                        </div>

                        <!-- Bottom Floating Quiz Card (Subtle Overlap on Lower Chassis) -->
                        <div class="floating-quiz-card">
                            <div class="quiz-card-content">
                                <div class="quiz-badge-icon">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                                        <polyline points="20 6 9 17 4 12"></polyline>
                                    </svg>
                                </div>
                                <div class="quiz-card-info">
                                    <span class="quiz-title">Quiz Completed</span>
                                    <span class="quiz-sub">Progress: <strong>80%</strong></span>
                                </div>
                            </div>
                            <div class="quiz-progress-track">
                                <div class="quiz-progress-bar" style="width: 80%;"></div>
                            </div>
                        </div>

                        <!-- Carefully Positioned Programming Indicators (Trio Capsule) -->
                        <div class="hero-tech-capsule">
                            <span class="tech-indicator ind-cs">C#</span>
                            <span class="tech-indicator ind-py">Python</span>
                            <span class="tech-indicator ind-js">JS</span>
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
