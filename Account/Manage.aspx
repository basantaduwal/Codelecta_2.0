<%@ Page Title="Profile & Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="Codelecta_2._0.Account.Manage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div style="background: var(--bg-page); min-height: calc(100vh - 76px); padding: 40px 0 80px 0;">
        <div class="container" style="max-width: 900px; margin: 0 auto; padding: 0 20px;">

            <!-- ==================== HEADER BANNER ==================== -->
            <div style="background: #FFFFFF; border-radius: 20px; border: 1px solid var(--border); box-shadow: var(--shadow-sm); padding: 36px; margin-bottom: 28px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 20px;">
                <div style="display: flex; align-items: center; gap: 20px;">
                    <!-- User Avatar -->
                    <div style="width: 64px; height: 64px; border-radius: 50%; background: linear-gradient(135deg, #6C5CE7, #A855F7); display: flex; align-items: center; justify-content: center; color: white; font-size: 1.8rem; font-weight: 800; box-shadow: var(--shadow-sm); flex-shrink: 0;">
                        <asp:Label ID="lblAvatarInitial" runat="server" Text="U"></asp:Label>
                    </div>
                    <div>
                        <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 4px;">
                            <h1 style="font-size: 1.7rem; font-weight: 800; color: #1E1B4B; margin: 0; letter-spacing: -0.02em;">
                                <asp:Label ID="lblProfileHeading" runat="server" Text="Learner Profile"></asp:Label>
                            </h1>
                            <span style="padding: 3px 10px; background: #F3F0FF; color: #6C5CE7; border: 1px solid #DDD6FE; border-radius: 20px; font-size: 0.78rem; font-weight: 800;">
                                <asp:Label ID="lblAccountRole" runat="server" Text="Student"></asp:Label>
                            </span>
                        </div>
                        <p style="color: #64748B; font-size: 0.95rem; margin: 0;">
                            <asp:Label ID="lblEmailAddress" runat="server"></asp:Label>
                        </p>
                    </div>
                </div>

                <!-- Stats summary chips -->
                <div style="display: flex; gap: 12px; flex-wrap: wrap;">
                    <div style="background: #FAF9FF; border: 1px solid #ECE7FF; border-radius: 12px; padding: 10px 16px; text-align: center;">
                        <div style="font-size: 1.2rem; font-weight: 800; color: #6C5CE7;"><asp:Label ID="lblStatCourses" runat="server" Text="0"></asp:Label></div>
                        <div style="font-size: 0.72rem; font-weight: 700; color: #64748B; text-transform: uppercase;">Enrolled</div>
                    </div>
                    <div style="background: #FAF9FF; border: 1px solid #ECE7FF; border-radius: 12px; padding: 10px 16px; text-align: center;">
                        <div style="font-size: 1.2rem; font-weight: 800; color: #10B981;"><asp:Label ID="lblStatCertificates" runat="server" Text="0"></asp:Label></div>
                        <div style="font-size: 0.72rem; font-weight: 700; color: #64748B; text-transform: uppercase;">Certificates</div>
                    </div>
                </div>
            </div>

            <!-- ==================== STATUS FEEDBACK ==================== -->
            <asp:Panel ID="pnlStatusMessage" runat="server" Visible="false" style="margin-bottom: 24px; padding: 14px 20px; border-radius: 12px; font-weight: 600; font-size: 0.92rem;">
                <asp:Label ID="lblStatusMessage" runat="server"></asp:Label>
            </asp:Panel>

            <!-- ==================== PROFILE & SETTINGS FORMS ==================== -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px;">

                <!-- 1. Edit Personal Details -->
                <div class="feature-card" style="background: #FFFFFF; border-radius: 20px; border: 1px solid var(--border); box-shadow: var(--shadow-sm); padding: 32px;">
                    <h3 style="font-size: 1.15rem; font-weight: 800; color: #1E1B4B; margin: 0 0 6px 0;">Personal Details</h3>
                    <p style="color: #64748B; font-size: 0.88rem; margin: 0 0 24px 0;">Update your name and personalized learning track.</p>

                    <div style="margin-bottom: 20px;">
                        <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" placeholder="e.g. John Doe"
                            style="width: 100%; padding: 11px 14px; border: 1.5px solid #EDE9FE; border-radius: 10px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
                    </div>

                    <div style="margin-bottom: 28px;">
                        <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Programming Experience Level</label>
                        <asp:DropDownList ID="ddlExperienceLevel" runat="server"
                            style="width: 100%; padding: 11px 14px; border: 1.5px solid #EDE9FE; border-radius: 10px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box; cursor: pointer;">
                            <asp:ListItem Value="Beginner"     Text="Beginner — New to coding" />
                            <asp:ListItem Value="Intermediate" Text="Intermediate — Basic coding knowledge" />
                            <asp:ListItem Value="Professional" Text="Professional — Experienced developer" />
                        </asp:DropDownList>
                    </div>

                    <asp:Button ID="btnSaveProfile" runat="server" Text="Save Changes" OnClick="btnSaveProfile_Click"
                        style="width: 100%; padding: 12px 24px; background: linear-gradient(135deg, #6C5CE7, #A855F7); color: white; border: none; border-radius: 10px; font-weight: 700; font-size: 0.92rem; cursor: pointer; box-shadow: 0 4px 14px rgba(108, 92, 231, 0.25);" />
                </div>

                <!-- 2. Change Password -->
                <div class="feature-card" style="background: #FFFFFF; border-radius: 20px; border: 1px solid var(--border); box-shadow: var(--shadow-sm); padding: 32px;">
                    <h3 style="font-size: 1.15rem; font-weight: 800; color: #1E1B4B; margin: 0 0 6px 0;">Change Password</h3>
                    <p style="color: #64748B; font-size: 0.88rem; margin: 0 0 24px 0;">Ensure your account remains safe and secure.</p>

                    <div style="margin-bottom: 16px;">
                        <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Current Password</label>
                        <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" placeholder="••••••••"
                            style="width: 100%; padding: 11px 14px; border: 1.5px solid #EDE9FE; border-radius: 10px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
                    </div>

                    <div style="margin-bottom: 16px;">
                        <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">New Password</label>
                        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="Minimum 6 characters"
                            style="width: 100%; padding: 11px 14px; border: 1.5px solid #EDE9FE; border-radius: 10px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
                    </div>

                    <div style="margin-bottom: 24px;">
                        <label style="display: block; font-size: 0.85rem; font-weight: 700; color: #475569; margin-bottom: 6px;">Confirm New Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Repeat new password"
                            style="width: 100%; padding: 11px 14px; border: 1.5px solid #EDE9FE; border-radius: 10px; font-size: 0.9rem; font-family: inherit; color: #1E1B4B; background: #FAFAFA; box-sizing: border-box;" />
                    </div>

                    <asp:Button ID="btnChangePassword" runat="server" Text="Update Password" OnClick="btnChangePassword_Click"
                        style="width: 100%; padding: 12px 24px; background: #FAF9FF; color: #6C5CE7; border: 1.5px solid #DDD6FE; border-radius: 10px; font-weight: 700; font-size: 0.92rem; cursor: pointer; transition: all 0.2s ease;" />
                </div>

            </div>

        </div>
    </div>
</asp:Content>
