<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Codelecta_2._0.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main style="padding: 40px 0 80px 0; background: var(--bg-page);">
        <div class="container" style="max-width: 1060px; margin: 0 auto; padding: 0 24px;">
            
            <!-- ==================== TOP HERO SECTION ==================== -->
            <div style="display: grid; grid-template-columns: 1.15fr 0.85fr; gap: 40px; align-items: center; margin-bottom: 48px;">
                <!-- Left Text -->
                <div>
                    <span style="display: inline-block; font-size: 0.78rem; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; color: var(--primary); background: var(--primary-subtle); border: 1px solid var(--border); padding: 5px 14px; border-radius: var(--radius-full); margin-bottom: 18px;">GET IN TOUCH</span>
                    <h1 style="font-size: 2.85rem; font-weight: 800; color: var(--text-primary); line-height: 1.18; margin: 0 0 16px 0; letter-spacing: -0.03em;">
                        Have a Question? We'd<br />
                        <span class="purple-highlight">Love to Hear From You.</span>
                    </h1>
                    <p style="font-size: 1.05rem; color: var(--text-secondary); line-height: 1.65; margin: 0; max-width: 480px;">
                        Whether you have a question about Codelecta, need help getting started, or want to share feedback, we're here to help.
                    </p>
                </div>

                <!-- Right Graphic Visual Card -->
                <div style="display: flex; justify-content: flex-end;">
                    <div style="width: 100%; max-width: 400px; height: 240px; background: linear-gradient(135deg, #F3F0FF 0%, #E9E5FF 50%, #F5F3FF 100%); border-radius: 24px; border: 1px solid #E4DEFF; box-shadow: var(--shadow-md); display: flex; align-items: center; justify-content: center; position: relative; overflow: hidden;">
                        
                        <!-- Decorative Background Circles -->
                        <div style="position: absolute; width: 140px; height: 140px; border-radius: 50%; background: rgba(108, 92, 231, 0.08); top: -20px; right: -20px;"></div>
                        <div style="position: absolute; width: 100px; height: 100px; border-radius: 50%; background: rgba(168, 85, 247, 0.08); bottom: -10px; left: -10px;"></div>

                        <!-- 3D-styled Central Illustration -->
                        <div style="position: relative; z-index: 2; display: flex; align-items: center; gap: 12px;">
                            <!-- Code Braces Graphic -->
                            <div style="background: linear-gradient(135deg, #6C5CE7, #8B5CF6); color: white; width: 68px; height: 68px; border-radius: 18px; display: flex; align-items: center; justify-content: center; font-size: 2rem; font-weight: 800; font-family: 'Fira Code', monospace; box-shadow: 0 10px 25px rgba(108, 92, 231, 0.35); transform: rotate(-6deg);">
                                { / }
                            </div>

                            <!-- Chat Bubble Graphic -->
                            <div style="background: #A78BFA; color: white; width: 58px; height: 58px; border-radius: 50% 50% 10px 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 8px 20px rgba(167, 139, 250, 0.35); margin-top: 20px;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 24 24" fill="currentColor">
                                    <circle cx="8" cy="12" r="1.5"></circle>
                                    <circle cx="12" cy="12" r="1.5"></circle>
                                    <circle cx="16" cy="12" r="1.5"></circle>
                                </svg>
                            </div>

                            <!-- Email Envelope Graphic -->
                            <div style="background: linear-gradient(135deg, #7C3AED, #4F46E5); color: white; width: 64px; height: 64px; border-radius: 18px; display: flex; align-items: center; justify-content: center; box-shadow: 0 10px 25px rgba(79, 70, 229, 0.35); transform: rotate(8deg);">
                                <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="12" cy="12" r="4"></circle>
                                    <path d="M16 8v5a3 3 0 0 0 6 0v-1a10 10 0 1 0-3.92 7.94"></path>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==================== MAIN FORM & SUPPORT CARD ==================== -->
            <div style="background: #FFFFFF; border-radius: 24px; border: 1px solid var(--border); box-shadow: 0 12px 36px rgba(108, 92, 231, 0.07); padding: 44px 40px; margin-bottom: 70px;">
                <div style="display: grid; grid-template-columns: 0.75fr 1.25fr; gap: 44px; align-items: start;">
                    
                    <!-- Left: Developer Support Card -->
                    <div style="background: #F8F7FF; border: 1px solid #ECE7FF; border-radius: 18px; padding: 32px 28px;">
                        <!-- Terminal Icon Badge -->
                        <div style="width: 44px; height: 44px; border-radius: 12px; background: #FFFFFF; border: 1px solid #E4DEFF; display: flex; align-items: center; justify-content: center; margin-bottom: 20px; box-shadow: 0 2px 8px rgba(108, 92, 231, 0.08);">
                            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="2" y="4" width="20" height="16" rx="2"></rect>
                                <path d="M6 8h.01"></path>
                                <path d="M10 8h.01"></path>
                                <path d="M14 8h.01"></path>
                                <path d="m8 13 2 2-2 2"></path>
                                <path d="M12 17h4"></path>
                            </svg>
                        </div>

                        <h3 style="font-size: 1.3rem; font-weight: 800; color: var(--text-primary); margin: 0 0 10px 0;">Developer Support</h3>
                        <p style="color: var(--text-secondary); font-size: 0.92rem; line-height: 1.65; margin: 0 0 22px 0;">
                            Our technical team is ready to help you debug issues, understand complex concepts, and guide you through our curriculum.
                        </p>

                        <!-- Code Snippet Box -->
                        <div style="background: #FFFFFF; border: 1px solid #E5E0FB; border-radius: 10px; padding: 16px; font-family: 'Fira Code', 'Courier New', monospace; font-size: 0.85rem; color: #6C5CE7; line-height: 1.6;">
                            <div><span style="color: #A855F7;">function</span> <span style="color: #4F46E5;">contactSupport</span>() {</div>
                            <div style="padding-left: 14px;"><span style="color: #A855F7;">return</span> <span style="color: #059669;">"We reply fast!"</span>;</div>
                            <div>}</div>
                        </div>
                    </div>

                    <!-- Right: Form -->
                    <div>
                        <h2 style="font-size: 1.85rem; font-weight: 800; color: var(--text-primary); margin: 0 0 6px 0; letter-spacing: -0.02em;">Send Us a Message</h2>
                        <p style="color: var(--text-secondary); font-size: 0.95rem; margin: 0 0 28px 0;">We'll get back to you as soon as possible.</p>

                        <!-- Success Banner -->
                        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" 
                            style="background: #ECFDF5; border: 1px solid var(--success); color: #065F46; padding: 14px 18px; border-radius: 10px; margin-bottom: 20px; font-weight: 600; font-size: 0.92rem;">
                            &#10003; Thank you! Your message has been received. We'll reply shortly.
                        </asp:Panel>

                        <!-- Row 1: Full Name & Email -->
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 18px;">
                            <div>
                                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: var(--text-primary); margin-bottom: 6px;">Full Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control form-input" placeholder="Enter your name" Width="100%"
                                    style="padding: 12px 14px; border-radius: 8px; border: 1px solid var(--border); font-size: 0.92rem;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                    ErrorMessage="Name is required." Display="Dynamic" ValidationGroup="ContactGroup"
                                    style="color: var(--error); font-size: 0.8rem; margin-top: 4px; display: block;"></asp:RequiredFieldValidator>
                            </div>
                            <div>
                                <label style="display: block; font-size: 0.85rem; font-weight: 700; color: var(--text-primary); margin-bottom: 6px;">Email Address</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control form-input" TextMode="Email" placeholder="example@gmail.com" Width="100%"
                                    style="padding: 12px 14px; border-radius: 8px; border: 1px solid var(--border); font-size: 0.92rem;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                    ErrorMessage="Email is required." Display="Dynamic" ValidationGroup="ContactGroup"
                                    style="color: var(--error); font-size: 0.8rem; margin-top: 4px; display: block;"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <!-- Row 2: Subject -->
                        <div style="margin-bottom: 18px;">
                            <label style="display: block; font-size: 0.85rem; font-weight: 700; color: var(--text-primary); margin-bottom: 6px;">Subject</label>
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control form-input" placeholder="How can we help you?" Width="100%"
                                style="padding: 12px 14px; border-radius: 8px; border: 1px solid var(--border); font-size: 0.92rem;"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtSubject"
                                ErrorMessage="Subject is required." Display="Dynamic" ValidationGroup="ContactGroup"
                                style="color: var(--error); font-size: 0.8rem; margin-top: 4px; display: block;"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Row 3: Message -->
                        <div style="margin-bottom: 24px;">
                            <label style="display: block; font-size: 0.85rem; font-weight: 700; color: var(--text-primary); margin-bottom: 6px;">Message</label>
                            <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control form-input" TextMode="MultiLine" Rows="5" placeholder="Write your message here..." Width="100%"
                                style="padding: 12px 14px; border-radius: 8px; border: 1px solid var(--border); font-size: 0.92rem;"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage"
                                ErrorMessage="Message is required." Display="Dynamic" ValidationGroup="ContactGroup"
                                style="color: var(--error); font-size: 0.8rem; margin-top: 4px; display: block;"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Submit Button -->
                        <div>
                            <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn-primary"
                                ValidationGroup="ContactGroup" OnClick="btnSubmit_Click"
                                style="padding: 12px 28px; font-size: 0.95rem; font-weight: 700; border-radius: 8px; cursor: pointer; width: 100%; text-align: center" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==================== FAQ SECTION ==================== -->
            <div style="max-width: 760px; margin: 0 auto; text-align: center;">
                <h2 style="font-size: 2.1rem; font-weight: 800; color: var(--text-primary); margin: 0 0 8px 0; letter-spacing: -0.02em;">Frequently Asked Questions</h2>
                <p style="color: var(--text-secondary); font-size: 0.98rem; margin: 0 0 36px 0;">Quick answers to common questions about Codelecta.</p>

                <!-- Accordion Items using standard HTML5 details/summary for 100% Pure .NET without heavy JS -->
                <div style="display: flex; flex-direction: column; gap: 14px; text-align: left;">
                    
                    <!-- FAQ 1 -->
                    <details style="background: #FFFFFF; border: 1px solid var(--border); border-radius: 12px; padding: 18px 22px; cursor: pointer; transition: all 0.2s ease; box-shadow: var(--shadow-sm);">
                        <summary style="font-weight: 700; color: var(--text-primary); font-size: 1rem; list-style: none; display: flex; justify-content: space-between; align-items: center; outline: none;">
                            <span>Who is Codelecta for?</span>
                            <span style="color: var(--text-muted); font-size: 1.25rem; font-weight: 400;">+</span>
                        </summary>
                        <p style="margin: 14px 0 0 0; color: var(--text-secondary); font-size: 0.92rem; line-height: 1.65; cursor: default;">
                            Codelecta is designed for university students, self-taught developers, and coding enthusiasts who want structured programming lessons with clear practical examples and step-by-step curriculum.
                        </p>
                    </details>

                    <!-- FAQ 2 -->
                    <details style="background: #FFFFFF; border: 1px solid var(--border); border-radius: 12px; padding: 18px 22px; cursor: pointer; transition: all 0.2s ease; box-shadow: var(--shadow-sm);">
                        <summary style="font-weight: 700; color: var(--text-primary); font-size: 1rem; list-style: none; display: flex; justify-content: space-between; align-items: center; outline: none;">
                            <span>What can I learn on Codelecta?</span>
                            <span style="color: var(--text-muted); font-size: 1.25rem; font-weight: 400;">+</span>
                        </summary>
                        <p style="margin: 14px 0 0 0; color: var(--text-secondary); font-size: 0.92rem; line-height: 1.65; cursor: default;">
                            You can learn C#, ASP.NET Web Forms, database modeling with Entity Framework, SQL Server, and full-stack software development principles.
                        </p>
                    </details>

                    <!-- FAQ 3 -->
                    <details style="background: #FFFFFF; border: 1px solid var(--border); border-radius: 12px; padding: 18px 22px; cursor: pointer; transition: all 0.2s ease; box-shadow: var(--shadow-sm);">
                        <summary style="font-weight: 700; color: var(--text-primary); font-size: 1rem; list-style: none; display: flex; justify-content: space-between; align-items: center; outline: none;">
                            <span>Do I need previous programming experience?</span>
                            <span style="color: var(--text-muted); font-size: 1.25rem; font-weight: 400;">+</span>
                        </summary>
                        <p style="margin: 14px 0 0 0; color: var(--text-secondary); font-size: 0.92rem; line-height: 1.65; cursor: default;">
                            No prior experience is necessary! Our courses are structured starting from absolute fundamentals and gradually guide you through intermediate and advanced topics.
                        </p>
                    </details>

                    <!-- FAQ 4 -->
                    <details style="background: #FFFFFF; border: 1px solid var(--border); border-radius: 12px; padding: 18px 22px; cursor: pointer; transition: all 0.2s ease; box-shadow: var(--shadow-sm);">
                        <summary style="font-weight: 700; color: var(--text-primary); font-size: 1rem; list-style: none; display: flex; justify-content: space-between; align-items: center; outline: none;">
                            <span>How can I get started?</span>
                            <span style="color: var(--text-muted); font-size: 1.25rem; font-weight: 400;">+</span>
                        </summary>
                        <p style="margin: 14px 0 0 0; color: var(--text-secondary); font-size: 0.92rem; line-height: 1.65; cursor: default;">
                            Simply register for a free account, browse our Course Catalog, click "Enroll", and start reading lessons and watching video tutorials right away!
                        </p>
                    </details>

                </div>
            </div>

        </div>
    </main>
</asp:Content>
