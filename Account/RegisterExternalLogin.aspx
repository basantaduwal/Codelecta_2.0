<%@ Page Title="Register External Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterExternalLogin.aspx.cs" Inherits="Codelecta_2._0.Account.RegisterExternalLogin" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="auth-page-container">
        <div class="auth-card">
            <!-- Left: Branding Panel -->
            <div class="auth-brand-panel">
                <div class="auth-brand-logo">
                    <img src="<%= ResolveUrl("~/Logo.png") %>" alt="Codelecta Logo" class="auth-brand-logo-img" />
                    <span class="auth-brand-text">CODELECTA</span>
                </div>
                <div class="auth-brand-top">
                    <h2 class="auth-brand-title">Connect & Learn.</h2>
                    <p class="auth-subtitle" style="color: #c4b5fd;">Complete your registration using your <%: ProviderName %> account to start your learning journey.</p>
                </div>

                <!-- Code Editor Card Visual -->
                <div class="auth-code-card">
                    <div class="auth-code-header">
                        <div class="auth-code-dots">
                            <span class="dot red"></span>
                            <span class="dot yellow"></span>
                            <span class="dot green"></span>
                        </div>
                        <span class="auth-code-file">AuthProfile.cs</span>
                    </div>
                    <div class="auth-code-body">
                        <div class="code-line"><span class="ln">1</span><span class="kw">var</span> account = <span class="kw">new</span> <span class="type">ConnectedUser</span>();</div>
                        <div class="code-line"><span class="ln">2</span>account.<span class="fn">Provider</span> = <span class="str">"<%: ProviderName %>"</span>;</div>
                        <div class="code-line"><span class="ln">3</span>account.<span class="fn">Status</span> = <span class="str">"Verified"</span>;</div>
                    </div>
                </div>

                <!-- Pill Badges -->
                <div class="auth-tags">
                    <span class="auth-tag">&bull; C#</span>
                    <span class="auth-tag">&bull; ASP.NET</span>
                    <span class="auth-tag">&bull; SQL</span>
                    <span class="auth-tag">&bull; JavaScript</span>
                </div>
            </div>

            <!-- Right: Form Panel -->
            <div class="auth-form-panel">
                <div class="auth-form-container">
                    <h2>Complete Profile</h2>
                    <p class="auth-subtitle">
                        You've authenticated with <strong><%: ProviderName %></strong>. Confirm your details to complete your account setup.
                    </p>

                    <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger validation-summary" />

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="fullName" CssClass="form-label">Full Name</asp:Label>
                        <asp:TextBox runat="server" ID="fullName" CssClass="form-control form-input" placeholder="Your full name" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="fullName"
                            Display="Dynamic" CssClass="text-danger field-validation-error" ErrorMessage="Full Name is required" />
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="email" CssClass="form-label">Email Address</asp:Label>
                        <asp:TextBox runat="server" ID="email" CssClass="form-control form-input" TextMode="Email" placeholder="example@gmail.com" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="email"
                            Display="Dynamic" CssClass="text-danger field-validation-error" ErrorMessage="Email is required" />
                        <asp:ModelErrorMessage runat="server" ModelStateKey="email" CssClass="text-danger field-validation-error" />
                    </div>

                    <asp:Button runat="server" Text="Complete Registration" CssClass="btn-auth" OnClick="LogIn_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
