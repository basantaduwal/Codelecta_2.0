<%@ Page Title="Course Certificate" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Certificate.aspx.cs" Inherits="Codelecta_2._0.Certificate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="background: var(--bg-page); min-height: calc(100vh - 76px); padding: 40px 0 80px 0;">
        <div class="container" style="max-width: 900px; margin: 0 auto; padding: 0 20px;">

            <!-- Actions Bar Above Certificate -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; flex-wrap: wrap; gap: 14px;">
                <a href="Dashboard.aspx" style="color: var(--primary); font-weight: 700; text-decoration: none; font-size: 0.92rem; display: inline-flex; align-items: center; gap: 6px;">
                    &larr; Back to Dashboard
                </a>
                <button type="button" onclick="window.print();" class="btn-primary" style="padding: 10px 22px; font-size: 0.88rem; font-weight: 700; border-radius: 8px; cursor: pointer; display: inline-flex; align-items: center; gap: 8px;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 6 2 18 2 18 9"></polyline><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path><rect x="6" y="14" width="12" height="8"></rect></svg>
                    Print / Save PDF
                </button>
            </div>

            <!-- ==================== CERTIFICATE CANVAS / CARD ==================== -->
            <div class="certificate-container" id="certificateNode" style="background: #FFFFFF; border-radius: 24px; padding: 60px 50px; border: 8px solid #F3F0FF; box-shadow: 0 20px 60px rgba(108, 92, 231, 0.15); text-align: center; position: relative; overflow: hidden;">
                
                <!-- Decorative Outer Gold & Purple Border -->
                <div style="position: absolute; top: 12px; left: 12px; right: 12px; bottom: 12px; border: 2px solid #DDD6FE; border-radius: 14px; pointer-events: none;"></div>

                <!-- Logo and Badge -->
                <div style="margin-bottom: 24px;">
                    <div style="width: 70px; height: 70px; border-radius: 50%; background: linear-gradient(135deg, #6C5CE7, #A855F7); display: inline-flex; align-items: center; justify-content: center; color: white; font-size: 1.8rem; box-shadow: 0 8px 24px rgba(108, 92, 231, 0.35); margin-bottom: 12px;">
                        🎓
                    </div>
                    <div style="font-size: 1.3rem; font-weight: 900; letter-spacing: 2px; color: #1E1B4B; text-transform: uppercase;">
                        CODELECTA
                    </div>
                    <div style="font-size: 0.78rem; font-weight: 700; letter-spacing: 3px; color: #A855F7; text-transform: uppercase;">
                        ACADEMY OF PROGRAMMING
                    </div>
                </div>

                <!-- Certificate Title -->
                <h1 style="font-size: 2.5rem; font-weight: 900; color: #1E1B4B; margin: 0 0 8px 0; letter-spacing: -0.02em;">
                    Certificate of Completion
                </h1>
                <p style="color: #64748B; font-size: 1rem; margin: 0 0 28px 0; text-transform: uppercase; letter-spacing: 1.5px; font-weight: 600;">
                    This is proudly presented to
                </p>

                <!-- Recipient Name -->
                <div style="border-bottom: 2px solid #6C5CE7; display: inline-block; padding: 0 40px 10px 40px; margin-bottom: 24px;">
                    <span style="font-size: 2.2rem; font-weight: 800; color: #1E1B4B; font-family: 'Inter', sans-serif;">
                        <asp:Label ID="lblStudentName" runat="server" Text="Student Name"></asp:Label>
                    </span>
                </div>

                <!-- Completion Statement -->
                <p style="color: #475569; font-size: 1.05rem; line-height: 1.8; max-width: 620px; margin: 0 auto 40px auto;">
                    For successfully mastering all lessons, practical programming exercises, and curriculum requirements for
                    <br />
                    <strong style="color: #6C5CE7; font-size: 1.25rem;"><asp:Label ID="lblCourseTitle" runat="server" Text="Course Title"></asp:Label></strong>.
                </p>

                <!-- Signatures & Verification Details Footer -->
                <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px; align-items: flex-end; margin-top: 40px; padding-top: 24px; border-top: 1px solid #EDE9FE;">
                    
                    <!-- Issue Date -->
                    <div style="text-align: left;">
                        <div style="font-size: 0.78rem; font-weight: 700; color: #94A3B8; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 4px;">Date of Issue</div>
                        <div style="font-size: 0.95rem; font-weight: 700; color: #1E1B4B;">
                            <asp:Label ID="lblIssueDate" runat="server"></asp:Label>
                        </div>
                    </div>

                    <!-- Seal / Verification Badge -->
                    <div style="text-align: center;">
                        <div style="display: inline-block; padding: 8px 16px; background: #FAF9FF; border: 1.5px dashed #C4B5FD; border-radius: 12px;">
                            <div style="font-size: 0.7rem; font-weight: 800; color: #6C5CE7; letter-spacing: 1px;">VERIFICATION ID</div>
                            <div style="font-size: 0.85rem; font-weight: 800; color: #1E1B4B; font-family: 'Fira Code', monospace;">
                                <asp:Label ID="lblCertificateId" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>

                    <!-- Instructor Signature -->
                    <div style="text-align: right;">
                        <div style="font-size: 1.1rem; font-family: 'Brush Script MT', cursive, sans-serif; color: #6C5CE7; margin-bottom: 2px;">
                            Codelecta Academic Board
                        </div>
                        <div style="font-size: 0.78rem; font-weight: 700; color: #94A3B8; text-transform: uppercase; letter-spacing: 1px;">
                            Authorized Signature
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </div>

    <!-- Print Specific Media Query -->
    <style>
        @media print {
            body {
                background: #FFFFFF !important;
            }
            .codelecta-nav, .codelecta-footer, .btn-primary, a {
                display: none !important;
            }
            .certificate-container {
                box-shadow: none !important;
                border: 2px solid #6C5CE7 !important;
                padding: 40px !important;
                margin: 0 !important;
                max-width: 100% !important;
            }
        }
    </style>
</asp:Content>
