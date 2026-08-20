<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Codelecta_2._0.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main style="padding: 40px 0 80px 0; background: var(--bg-page);">
        <div class="container" style="max-width: 1060px; margin: 0 auto; padding: 0 24px;">

            <!-- ==================== 1. HERO SECTION ==================== -->
            <div style="display: grid; grid-template-columns: 1.15fr 0.85fr; gap: 40px; align-items: center; margin-bottom: 50px;">
                <!-- Left Text -->
                <div>
                    <span style="display: inline-block; font-size: 0.78rem; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; color: var(--primary); background: var(--primary-subtle); border: 1px solid var(--border); padding: 5px 14px; border-radius: var(--radius-full); margin-bottom: 18px;">ABOUT CODELECTA</span>
                    <h1 style="font-size: 2.85rem; font-weight: 800; color: var(--text-primary); line-height: 1.18; margin: 0 0 16px 0; letter-spacing: -0.03em;">
                        Learning to Code,<br />
                        <span class="purple-highlight">Made Clearer.</span>
                    </h1>
                    <p style="font-size: 1.05rem; color: var(--text-secondary); line-height: 1.65; margin: 0 0 28px 0; max-width: 480px;">
                        Codelecta is a web-based interactive programming learning platform designed to make programming education more structured, practical, and accessible.
                    </p>
                    <div style="display: flex; gap: 14px; flex-wrap: wrap;">
                        <a href="Account/Register" class="btn-primary" style="padding: 12px 28px; font-size: 0.95rem; font-weight: 700; border-radius: 8px; text-decoration: none;">Start Learning</a>
                        <a href="Courses" class="btn-secondary" style="padding: 12px 26px; font-size: 0.95rem; font-weight: 700; border-radius: 8px; text-decoration: none;">View Courses</a>
                    </div>
                </div>

                <!-- Right 3D Visual Graphic -->
                <div style="display: flex; justify-content: flex-end;">
                    <div style="width: 100%; max-width: 400px; height: 240px; background: linear-gradient(135deg, #F3F0FF 0%, #E9E5FF 50%, #F5F3FF 100%); border-radius: 24px; border: 1px solid #E4DEFF; box-shadow: var(--shadow-md); display: flex; align-items: center; justify-content: center; position: relative; overflow: hidden;">
                        <div style="position: absolute; width: 140px; height: 140px; border-radius: 50%; background: rgba(108, 92, 231, 0.08); top: -20px; right: -20px;"></div>
                        <div style="position: absolute; width: 100px; height: 100px; border-radius: 50%; background: rgba(168, 85, 247, 0.08); bottom: -10px; left: -10px;"></div>

                        <!-- Code Window Graphic -->
                        <div style="position: relative; z-index: 2; width: 84%; background: #FFFFFF; border-radius: 14px; border: 1px solid #DDD6FE; box-shadow: 0 10px 30px rgba(108, 92, 231, 0.2); overflow: hidden;">
                            <div style="background: #EDE9FE; padding: 8px 12px; display: flex; align-items: center; justify-content: space-between;">
                                <div style="display: flex; gap: 6px;">
                                    <span style="width: 9px; height: 9px; border-radius: 50%; background: #EF4444; display: inline-block;"></span>
                                    <span style="width: 9px; height: 9px; border-radius: 50%; background: #F59E0B; display: inline-block;"></span>
                                    <span style="width: 9px; height: 9px; border-radius: 50%; background: #10B981; display: inline-block;"></span>
                                </div>
                                <span style="font-size: 0.72rem; color: #6C5CE7; font-family: 'Fira Code', monospace; font-weight: 700;">&lt;/&gt;</span>
                            </div>
                            <div style="padding: 16px 18px; font-family: 'Fira Code', 'Courier New', monospace; font-size: 0.82rem; line-height: 1.6; color: var(--text-primary);">
                                <div><span style="color: #A855F7; font-weight: 600;">function</span> <span style="color: #4F46E5; font-weight: 600;">learn</span>(code) {</div>
                                <div style="padding-left: 14px;"><span style="color: #A855F7; font-weight: 600;">return</span> <span style="color: #059669; font-weight: 600;">code.mastery();</span></div>
                                <div>}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==================== 2. WHAT IS CODELECTA CARD ==================== -->
            <div style="background: #FFFFFF; border-radius: 24px; border: 1px solid var(--border); box-shadow: 0 10px 32px rgba(108, 92, 231, 0.06); padding: 44px 40px; margin-bottom: 44px;">
                <div style="display: grid; grid-template-columns: 1.05fr 0.95fr; gap: 40px; align-items: center;">
                    <!-- Left: Description -->
                    <div>
                        <h2 style="font-size: 2rem; font-weight: 800; color: var(--text-primary); margin: 0 0 16px 0; letter-spacing: -0.02em;">What is Codelecta?</h2>
                        <p style="color: var(--text-secondary); font-size: 0.96rem; line-height: 1.75; margin: 0 0 14px 0;">
                            We believe that mastering programming requires more than just reading tutorials. It demands a structured approach where concepts are introduced clearly, followed immediately by practical application and rigorous testing.
                        </p>
                        <p style="color: var(--text-secondary); font-size: 0.96rem; line-height: 1.75; margin: 0;">
                            Codelecta provides a unified environment to learn syntax, practice logic, and validate understanding through interactive exercises and structured modules.
                        </p>
                    </div>

                    <!-- Right: 4 Staggered Staircase Cards with Hover Motion -->
                    <div class="staircase-cards-container" style="display: flex; flex-direction: column; gap: 14px;">
                        <style>
                            .stair-card {
                                background: #FAF9FF;
                                border: 1px solid #ECE7FF;
                                border-radius: 14px;
                                padding: 15px 20px;
                                display: flex;
                                align-items: center;
                                gap: 16px;
                                transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
                                cursor: pointer;
                                box-shadow: 0 2px 8px rgba(108, 92, 231, 0.03);
                            }
                            .stair-card-1 {
                                margin-left: 0;
                                margin-right: 48px;
                            }
                            .stair-card-2 {
                                margin-left: 16px;
                                margin-right: 32px;
                            }
                            .stair-card-3 {
                                margin-left: 32px;
                                margin-right: 16px;
                            }
                            .stair-card-4 {
                                margin-left: 48px;
                                margin-right: 0;
                            }
                            .stair-card:hover {
                                transform: translateX(8px) translateY(-2px);
                                background: #FFFFFF;
                                border-color: #C4B5FD;
                                box-shadow: 0 10px 25px rgba(108, 92, 231, 0.12);
                            }
                            .stair-card:hover .stair-icon {
                                background: var(--primary);
                                transform: scale(1.08);
                            }
                            .stair-card:hover .stair-icon svg {
                                stroke: #FFFFFF;
                            }
                            .stair-icon {
                                width: 40px;
                                height: 40px;
                                border-radius: 10px;
                                background: #EDE9FE;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                flex-shrink: 0;
                                transition: all 0.3s ease;
                            }
                            @media (max-width: 768px) {
                                .stair-card-1, .stair-card-2, .stair-card-3, .stair-card-4 {
                                    margin-left: 0 !important;
                                    margin-right: 0 !important;
                                }
                            }
                        </style>

                        <!-- Row 1: Learn -->
                        <div class="stair-card stair-card-1">
                            <div class="stair-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                                    <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
                                </svg>
                            </div>
                            <div>
                                <h4 style="font-size: 1rem; font-weight: 800; color: var(--text-primary); margin: 0;">Learn</h4>
                                <p style="font-size: 0.85rem; color: var(--text-secondary); margin: 2px 0 0 0;">Structured curriculum</p>
                            </div>
                        </div>

                        <!-- Row 2: Practice -->
                        <div class="stair-card stair-card-2">
                            <div class="stair-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polyline points="16 18 22 12 16 6"></polyline>
                                    <polyline points="8 6 2 12 8 18"></polyline>
                                </svg>
                            </div>
                            <div>
                                <h4 style="font-size: 1rem; font-weight: 800; color: var(--text-primary); margin: 0;">Practice</h4>
                                <p style="font-size: 0.85rem; color: var(--text-secondary); margin: 2px 0 0 0;">Interactive coding environments</p>
                            </div>
                        </div>

                        <!-- Row 3: Test -->
                        <div class="stair-card stair-card-3">
                            <div class="stair-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                    <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
                                    <line x1="12" y1="17" x2="12.01" y2="17"></line>
                                </svg>
                            </div>
                            <div>
                                <h4 style="font-size: 1rem; font-weight: 800; color: var(--text-primary); margin: 0;">Test</h4>
                                <p style="font-size: 0.85rem; color: var(--text-secondary); margin: 2px 0 0 0;">Validate your knowledge</p>
                            </div>
                        </div>

                        <!-- Row 4: Improve -->
                        <div class="stair-card stair-card-4">
                            <div class="stair-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polyline points="23 6 13.5 15.5 8.5 10.5 1 18"></polyline>
                                    <polyline points="17 6 23 6 23 12"></polyline>
                                </svg>
                            </div>
                            <div>
                                <h4 style="font-size: 1rem; font-weight: 800; color: var(--text-primary); margin: 0;">Improve</h4>
                                <p style="font-size: 0.85rem; color: var(--text-secondary); margin: 2px 0 0 0;">Track your progress continuously</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==================== 3. MISSION CALLOUT BANNER ==================== -->
            <div style="background: linear-gradient(135deg, #F6F3FF 0%, #ECE7FF 100%); border-radius: 24px; border: 1px solid #DDD6FE; padding: 44px 36px; text-align: center; margin-bottom: 50px; box-shadow: var(--shadow-sm);">
                <!-- Flag Icon -->
                <div style="width: 46px; height: 46px; border-radius: 50%; background: #6C5CE7; color: white; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px auto; box-shadow: 0 6px 18px rgba(108, 92, 231, 0.35);">
                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"></path>
                        <line x1="4" y1="22" x2="4" y2="15"></line>
                    </svg>
                </div>

                <h3 style="font-size: 1.6rem; font-weight: 800; color: var(--text-primary); margin: 0 0 14px 0;">Our Mission</h3>
                <p style="font-size: 1.15rem; font-weight: 600; color: #5B4BD8; max-width: 780px; margin: 0 auto; line-height: 1.65; font-style: italic;">
                    "To make programming education more structured, practical, and accessible by providing learners with a clear environment to learn, practice, and improve their programming skills."
                </p>
            </div>

            <!-- ==================== 4. WHAT CODELECTA OFFERS ==================== -->
            <div style="text-align: center; margin-bottom: 50px;">
                <h2 style="font-size: 2.1rem; font-weight: 800; color: var(--text-primary); margin: 0 0 8px 0; letter-spacing: -0.02em;">What Codelecta Offers</h2>
                <p style="color: var(--text-secondary); font-size: 0.98rem; margin: 0 0 34px 0;">Core features designed for effective, self-paced learning.</p>

                <!-- 4 Feature Cards Grid -->
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; text-align: left;">
                    
                    <!-- Card 1 -->
                    <div style="background: #FFFFFF; border: 1px solid var(--border); border-radius: 16px; padding: 28px 22px; box-shadow: var(--shadow-sm); transition: transform 0.2s ease;">
                        <div style="width: 40px; height: 40px; border-radius: 10px; background: #F3F0FF; display: flex; align-items: center; justify-content: center; margin-bottom: 18px;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <line x1="6" y1="3" x2="6" y2="15"></line>
                                <circle cx="18" cy="6" r="3"></circle>
                                <circle cx="6" cy="18" r="3"></circle>
                                <path d="M18 9a9 9 0 0 1-9 9"></path>
                            </svg>
                        </div>
                        <h4 style="font-size: 1.05rem; font-weight: 800; color: var(--text-primary); margin: 0 0 8px 0;">Structured Learning</h4>
                        <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6; margin: 0;">Carefully designed paths that guide you from foundational concepts to advanced techniques.</p>
                    </div>

                    <!-- Card 2 -->
                    <div style="background: #FFFFFF; border: 1px solid var(--border); border-radius: 16px; padding: 28px 22px; box-shadow: var(--shadow-sm); transition: transform 0.2s ease;">
                        <div style="width: 40px; height: 40px; border-radius: 10px; background: #F3F0FF; display: flex; align-items: center; justify-content: center; margin-bottom: 18px;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                                <line x1="8" y1="21" x2="16" y2="21"></line>
                                <line x1="12" y1="17" x2="12" y2="21"></line>
                            </svg>
                        </div>
                        <h4 style="font-size: 1.05rem; font-weight: 800; color: var(--text-primary); margin: 0 0 8px 0;">Practical Learning</h4>
                        <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6; margin: 0;">Comprehensive tutorials, code examples, and multimedia lectures right in your browser.</p>
                    </div>

                    <!-- Card 3 -->
                    <div style="background: #FFFFFF; border: 1px solid var(--border); border-radius: 16px; padding: 28px 22px; box-shadow: var(--shadow-sm); transition: transform 0.2s ease;">
                        <div style="width: 40px; height: 40px; border-radius: 10px; background: #F3F0FF; display: flex; align-items: center; justify-content: center; margin-bottom: 18px;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                                <polyline points="22 4 12 14.01 9 11.01"></polyline>
                            </svg>
                        </div>
                        <h4 style="font-size: 1.05rem; font-weight: 800; color: var(--text-primary); margin: 0 0 8px 0;">Interactive Quizzes</h4>
                        <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6; margin: 0;">Immediate feedback on your understanding through engaging, context-aware assessments.</p>
                    </div>

                    <!-- Card 4 -->
                    <div style="background: #FFFFFF; border: 1px solid var(--border); border-radius: 16px; padding: 28px 22px; box-shadow: var(--shadow-sm); transition: transform 0.2s ease;">
                        <div style="width: 40px; height: 40px; border-radius: 10px; background: #F3F0FF; display: flex; align-items: center; justify-content: center; margin-bottom: 18px;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12 6 12 12 14 14"></polyline>
                            </svg>
                        </div>
                        <h4 style="font-size: 1.05rem; font-weight: 800; color: var(--text-primary); margin: 0 0 8px 0;">Learning Progress</h4>
                        <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6; margin: 0;">Visual progress tracking to celebrate completed milestones and maintain your momentum.</p>
                    </div>

                </div>
            </div>

            <!-- ==================== 5. LEARN AT YOUR OWN PACE (STEPPER) ==================== -->
            <div style="background: #FFFFFF; border-radius: 24px; border: 1px solid var(--border); box-shadow: var(--shadow-sm); padding: 44px 36px; margin-bottom: 50px; text-align: center;">
                <h2 style="font-size: 1.95rem; font-weight: 800; color: var(--text-primary); margin: 0 0 36px 0; letter-spacing: -0.02em;">Learn at Your Own Pace</h2>

                <!-- 3 Step Flow -->
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 30px; position: relative;">
                    <!-- Step 1 -->
                    <div>
                        <div style="width: 46px; height: 46px; border-radius: 50%; background: #6C5CE7; color: white; display: flex; align-items: center; justify-content: center; font-size: 1.05rem; font-weight: 800; margin: 0 auto 16px auto; box-shadow: 0 6px 18px rgba(108, 92, 231, 0.3);">
                            01
                        </div>
                        <h4 style="font-size: 1.1rem; font-weight: 800; color: var(--text-primary); margin: 0 0 8px 0;">Choose</h4>
                        <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6; margin: 0;">Select a learning path and course tailored to your goals.</p>
                    </div>

                    <!-- Step 2 -->
                    <div>
                        <div style="width: 46px; height: 46px; border-radius: 50%; background: #7C3AED; color: white; display: flex; align-items: center; justify-content: center; font-size: 1.05rem; font-weight: 800; margin: 0 auto 16px auto; box-shadow: 0 6px 18px rgba(124, 58, 237, 0.3);">
                            02
                        </div>
                        <h4 style="font-size: 1.1rem; font-weight: 800; color: var(--text-primary); margin: 0 0 8px 0;">Learn & Practice</h4>
                        <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6; margin: 0;">Consume bite-sized content, watch videos, and review code.</p>
                    </div>

                    <!-- Step 3 -->
                    <div>
                        <div style="width: 46px; height: 46px; border-radius: 50%; background: #8B5CF6; color: white; display: flex; align-items: center; justify-content: center; font-size: 1.05rem; font-weight: 800; margin: 0 auto 16px auto; box-shadow: 0 6px 18px rgba(139, 92, 246, 0.3);">
                            03
                        </div>
                        <h4 style="font-size: 1.1rem; font-weight: 800; color: var(--text-primary); margin: 0 0 8px 0;">Improve</h4>
                        <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6; margin: 0;">Mark lessons complete and master advanced concepts.</p>
                    </div>
                </div>
            </div>

            <!-- ==================== 6. BOTTOM CTA ==================== -->
            <div style="text-align: center; padding: 20px 0;">
                <h2 style="font-size: 2.1rem; font-weight: 800; color: var(--text-primary); margin: 0 0 20px 0; letter-spacing: -0.02em;">Ready to Start Learning?</h2>
                <div style="display: flex; gap: 14px; justify-content: center; flex-wrap: wrap;">
                    <a href="Account/Register" class="btn-primary" style="padding: 13px 32px; font-size: 0.95rem; font-weight: 700; border-radius: 8px; text-decoration: none;">Create Your Account</a>
                    <a href="Courses" class="btn-secondary" style="padding: 13px 30px; font-size: 0.95rem; font-weight: 700; border-radius: 8px; text-decoration: none;">Explore Courses</a>
                </div>
            </div>

        </div>
    </main>
</asp:Content>
