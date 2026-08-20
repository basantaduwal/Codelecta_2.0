<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Codelecta_2._0.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="auth-page-container">
        <div class="auth-card">
            <!-- Left: Branding Panel (Matching Mockup Image 2) -->
            <div class="auth-brand-panel">
                <div class="auth-brand-logo">
                    <img src="<%= ResolveUrl("~/Logo.png") %>" alt="Codelecta Logo" class="auth-brand-logo-img" />
                    <span class="auth-brand-text">CODELECTA</span>
                </div>
                <div class="auth-brand-top">
                <h2 class="auth-brand-title">Start Your Coding Journey</h2>
                <p class="auth-brand-subtitle">Create your account and begin learning programming at your own pace.</p>
                </div>
                
                <!-- Code Editor Card Visual -->
                <div class="auth-code-card">
                    <div class="auth-code-header">
                        <div class="auth-code-dots">
                            <span class="dot red"></span>
                            <span class="dot yellow"></span>
                            <span class="dot green"></span>
                        </div>
                        <span class="auth-code-file">Register.cs</span>
                    </div>
                    <div class="auth-code-body">
                        <div class="code-line"><span class="ln">1</span><span class="kw">var </span> <span class="var">learner</span> = <span class="kw">new</span> <span class="type">Student</span>();</div>
                        <div class="code-line"><span class="ln">2</span><span class="var">learner</span>.<span class="fn">Enroll</span>(<span class="str">"Fundamentals"</span>);</div>
                        <div class="code-line"><span class="ln">3</span><span class="var">learner</span>.<span class="fn">TrackProgress</span>();</div>
                        <div class="code-line"><span class="ln">4</span><span class="comment">// Output: Ready to build software!</span></div>
                    </div>
                </div>
                
                <!-- Pill Badges -->
                <div class="auth-tags">
                    <span class="auth-tag">&bull; Interactive Lessons</span>
                    <span class="auth-tag">&bull; Practical Exercises</span>
                    <span class="auth-tag">&bull; Self-Paced</span>
                </div>
            </div>

            <!-- Right: Registration Form (100% UNCHANGED ASP.NET Identity controls) -->
            <div class="auth-form-panel">
                <div class="auth-form-container">
                    <h2>Create Your Codelecta Account</h2>
                    <p class="auth-subtitle">Start your programming journey with structured, self-paced learning.</p>

                    <p class="text-danger">
                        <asp:Literal runat="server" ID="ErrorMessage" />
                    </p>
                    <asp:ValidationSummary runat="server" CssClass="text-danger validation-summary" />

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="FullName" CssClass="form-label">Full Name</asp:Label>
                        <asp:TextBox runat="server" ID="FullName" CssClass="form-control form-input" placeholder="Enter your name" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="FullName"
                            CssClass="text-danger field-validation-error" ErrorMessage="Full Name is required." Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Email" CssClass="form-label">Email Address</asp:Label>
                        <asp:TextBox runat="server" ID="Email" CssClass="form-control form-input" TextMode="Email" placeholder="example@gmail.com" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                            CssClass="text-danger field-validation-error" ErrorMessage="The email field is required." Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="form-label">Password</asp:Label>
                        <div class="password-wrapper">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control form-input" placeholder="Create a password" />
                            <button type="button" class="password-toggle" onclick="return false;" aria-label="Toggle password visibility">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="eye-icon"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                            CssClass="text-danger field-validation-error" ErrorMessage="The password field is required." Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="form-label">Confirm Password</asp:Label>
                        <div class="password-wrapper">
                            <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control form-input" placeholder="Confirm your password" />
                            <button type="button" class="password-toggle" onclick="return false;" aria-label="Toggle password visibility">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="eye-icon"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                            CssClass="text-danger field-validation-error" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                        <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                            CssClass="text-danger field-validation-error" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
                    </div>

                    <asp:Button runat="server" OnClick="CreateUser_Click" Text="Sign Up" CssClass="btn-auth" />

                    <p class="auth-footer-text">
                        Already have an account? <a href="Login">Sign in</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>