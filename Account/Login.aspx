<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Codelecta_2._0.Account.Login" Async="true" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="auth-page-container">
        <div class="auth-card">
            <!-- Left: Branding Panel (Matching Mockup Image 1) -->
            <div class="auth-brand-panel">
                <div class="auth-brand-logo">
                    <img src="<%= ResolveUrl("~/Logo.png") %>" alt="Codelecta Logo" class="auth-brand-logo-img" />
                    <span class="auth-brand-text">CODELECTA</span>
                </div>
                <div class="auth-brand-top">
                <h2 class="auth-brand-title">Learn. Code. Grow.</h2>
                <p class="auth-brand-subtitle">Build your programming skills through structured lessons, practical examples, and interactive learning.</p>
                </div>
                
                <!-- Code Editor Card Visual -->
                <div class="auth-code-card">
                    <div class="auth-code-header">
                        <div class="auth-code-dots">
                            <span class="dot red"></span>
                            <span class="dot yellow"></span>
                            <span class="dot green"></span>
                        </div>
                        <span class="auth-code-file">CodeLectaEngine.cs</span>
                    </div>
                    <div class="auth-code-body">
                        <div class="code-line"><span class="ln">1</span><span class="kw">using </span> <span class="type">System</span>;</div>
                        <div class="code-line"><span class="ln">2</span><span class="kw">public class</span> <span class="type">Learner</span> {</div>
                        <div class="code-line"><span class="ln">3</span>    <span class="kw">public void</span> <span class="fn">StartSession</span>() {</div>
                        <div class="code-line"><span class="ln">4</span>        <span class="type">Console</span>.<span class="fn">WriteLine</span>(<span class="str">"Welcome back!"</span>);</div>
                        <div class="code-line"><span class="ln">5</span>    }</div>
                        <div class="code-line"><span class="ln">6</span>}</div>
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

            <!-- Right: Login Form (100% UNCHANGED ASP.NET Identity controls) -->
            <div class="auth-form-panel">
                <div class="auth-form-container">
                    <h2>Welcome Back</h2>
                    <p class="auth-subtitle">Continue your programming journey with Codelecta.</p>

                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <div class="auth-error-message">
                            <asp:Literal runat="server" ID="FailureText" />
                        </div>
                    </asp:PlaceHolder>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Email" CssClass="form-label">Email Address</asp:Label>
                        <asp:TextBox runat="server" ID="Email" CssClass="form-control form-input" TextMode="Email" placeholder="example@gmail.com" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                            CssClass="text-danger field-validation-error" ErrorMessage="The email field is required." Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="form-label">Password</asp:Label>
                        <div class="password-wrapper">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control form-input" placeholder="Enter your password" />
                            <button type="button" class="password-toggle" onclick="return false;" aria-label="Toggle password visibility">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="eye-icon"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                            CssClass="text-danger field-validation-error" ErrorMessage="The password field is required." Display="Dynamic" />
                    </div>

                    <div class="form-check">
                        <asp:CheckBox runat="server" ID="RememberMe" />
                        <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me</asp:Label>
                    </div>

                    <asp:Button runat="server" OnClick="LogIn" Text="Login" CssClass="btn-auth" />

                    <p class="auth-footer-text">
                        Don't have an account? <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Sign Up</asp:HyperLink>
                    </p>

                    <div class="auth-divider">
                        <span>OR</span>
                    </div>

                    <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>