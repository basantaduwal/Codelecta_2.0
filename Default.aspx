<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Codelecta_2._0._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <!-- ==================== HERO SECTION ==================== -->
        <section class="hero-section" aria-labelledby="heroTitle">
            <div class="hero-container">
                <div class="hero-content">
                    <h1 id="heroTitle" class="hero-title">
                        Code. Learn.<br />
                        Innovate. <span class="purple-text">Repeat.</span>
                    </h1>
                    <p class="hero-text">
                        Interactive lessons, real projects and endless possibilities.
                    </p>
                    <div class="hero-buttons">
                        <a href="Account/Register" class="btn-primary btn-lg">Start Learning</a>
                        <a href="Courses" class="btn-secondary btn-lg">Explore Courses</a>
                    </div>
                </div>

                <!-- Monitor / Desktop Visual -->
                <div class="hero-visual">
                    <div class="monitor-wrapper">
                        <div class="monitor-badge">&lt;/&gt;</div>
                        <div class="monitor-screen">
                            <div class="monitor-bar">
                                <div class="monitor-dot" style="background: #EF4444;"></div>
                                <div class="monitor-dot" style="background: #F59E0B;"></div>
                                <div class="monitor-dot" style="background: #10B981;"></div>
                            </div>
                            <div class="monitor-code">
                                <div><span class="kw">class</span> <span class="type">Codelecta</span> {</div>
                                <div>&nbsp;&nbsp;<span class="kw">public static void</span> <span class="fn">Main</span>() {</div>
                                <div>&nbsp;&nbsp;&nbsp;&nbsp;<span class="type">Console</span>.<span class="fn">WriteLine</span>(<span class="str">"Hello, Learner!"</span>);</div>
                                <div>&nbsp;&nbsp;}</div>
                                <div>}</div>
                            </div>
                        </div>
                        <div class="monitor-stand"></div>
                        <div class="monitor-base"></div>
                        <div class="desk-props">
                            <div class="prop-plant"></div>
                            <div class="prop-books">
                                <div class="book-1"></div>
                                <div class="book-2"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==================== FEATURES BAR SECTION (Matching Mockup) ==================== -->
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

        <!-- ==================== TOP COURSES SECTION (Matching Mockup) ==================== -->
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
                <a href="Account/Register" class="btn-primary btn-lg">Create Your Free Account</a>
            </div>
        </section>
    </main>

</asp:Content>
