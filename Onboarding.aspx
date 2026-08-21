<%@ Page Title="Welcome to Codelecta" Language="C#" MasterPageFile="~/Onboarding.Master" AutoEventWireup="true" CodeBehind="Onboarding.aspx.cs" Inherits="Codelecta_2._0.Onboarding" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="OnboardingContent" runat="server">

    <div class="ob-wrapper">

        <!-- ── LOGO ────────────────────────────────── -->
        <div class="ob-logo">
            <img src="<%= ResolveUrl("~/Logo.png") %>" alt="Codelecta" class="ob-logo-img" />
            <span class="ob-logo-text">CODELECTA</span>
        </div>

        <!-- ── HEADING ────────────────────────────────── -->
        <div class="ob-header">
            <h1 class="ob-title">Welcome to Codelecta</h1>
            <p class="ob-subtitle">Let's personalise your learning experience.</p>
        </div>

        <div class="ob-question-block">
            <h2 class="ob-question">What's your programming experience level?</h2>
            <p class="ob-hint">Choose the option that best describes you. You can change this later.</p>
        </div>

        <!-- Error message -->
        <asp:Label ID="lblError" runat="server" Visible="false"
            style="display:block; background:#FEF2F2; border:1px solid #FECACA; color:#B91C1C; padding:12px 18px; border-radius:10px; font-size:0.9rem; font-weight:600; margin-bottom:24px; text-align:center;">
        </asp:Label>

        <!-- ── EXPERIENCE CARDS (hidden radio inputs styled as cards) ── -->
        <div class="ob-cards" role="radiogroup" aria-labelledby="ob-question-label">

            <!-- BEGINNER -->
            <label class="ob-card" for="rdoBeginner" tabindex="0" onkeydown="handleCardKey(event, 'rdoBeginner')">
                <input type="radio" id="rdoBeginner" name="experienceLevel" value="Beginner" class="ob-radio" onchange="onLevelChange()" />
                <div class="ob-card-check">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#8338AE" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
                </div>
                <div class="ob-card-icon ob-icon-beginner">
                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path>
                        <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path>
                    </svg>
                </div>
                <div class="ob-card-body">
                    <span class="ob-card-badge">BEGINNER</span>
                    <h3 class="ob-card-title">I'm New to Programming</h3>
                    <p class="ob-card-desc">I have little or no programming experience and want to build a strong foundation from the beginning.</p>
                </div>
            </label>

            <!-- INTERMEDIATE -->
            <label class="ob-card" for="rdoIntermediate" tabindex="0" onkeydown="handleCardKey(event, 'rdoIntermediate')">
                <input type="radio" id="rdoIntermediate" name="experienceLevel" value="Intermediate" class="ob-radio" onchange="onLevelChange()" />
                <div class="ob-card-check">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#8338AE" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
                </div>
                <div class="ob-card-icon ob-icon-intermediate">
                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="16 18 22 12 16 6"></polyline>
                        <polyline points="8 6 2 12 8 18"></polyline>
                    </svg>
                </div>
                <div class="ob-card-body">
                    <span class="ob-card-badge">INTERMEDIATE</span>
                    <h3 class="ob-card-title">I Have Some Experience</h3>
                    <p class="ob-card-desc">I understand programming fundamentals and want to strengthen my skills and learn more advanced concepts.</p>
                </div>
            </label>

            <!-- PROFESSIONAL -->
            <label class="ob-card" for="rdoProfessional" tabindex="0" onkeydown="handleCardKey(event, 'rdoProfessional')">
                <input type="radio" id="rdoProfessional" name="experienceLevel" value="Professional" class="ob-radio" onchange="onLevelChange()" />
                <div class="ob-card-check">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#8338AE" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
                </div>
                <div class="ob-card-icon ob-icon-professional">
                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                        <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                    </svg>
                </div>
                <div class="ob-card-body">
                    <span class="ob-card-badge">PROFESSIONAL</span>
                    <h3 class="ob-card-title">I'm an Experienced Developer</h3>
                    <p class="ob-card-desc">I already have professional or advanced programming experience and want to expand or specialise my skills.</p>
                </div>
            </label>

        </div>

        <!-- Hidden field carries the selected value to the server -->
        <asp:HiddenField ID="hfSelectedLevel" runat="server" Value="" />

        <!-- ── BUTTONS ────────────────────────────────── -->
        <div class="ob-actions">
            <asp:Button ID="btnContinue" runat="server" Text="Continue"
                CssClass="ob-btn-continue ob-btn-disabled" Enabled="false"
                OnClick="btnContinue_Click" />

            <asp:LinkButton ID="lnkSkip" runat="server" CssClass="ob-skip-link"
                OnClick="lnkSkip_Click">Skip for now</asp:LinkButton>
        </div>

        <p class="ob-footer-note">
            Your experience level helps us recommend the right courses for you.
        </p>

    </div>

    <script type="text/javascript">
        function onLevelChange() {
            var radios = document.querySelectorAll('.ob-radio');
            var cards  = document.querySelectorAll('.ob-card');
            var btn    = document.getElementById('<%= btnContinue.ClientID %>');
            var hf     = document.getElementById('<%= hfSelectedLevel.ClientID %>');

            var selected = '';
            radios.forEach(function(r, i) {
                if (r.checked) {
                    selected = r.value;
                    cards[i].classList.add('ob-card-selected');
                } else {
                    cards[i].classList.remove('ob-card-selected');
                }
            });

            hf.value = selected;

            if (selected) {
                btn.disabled = false;
                btn.classList.remove('ob-btn-disabled');
            } else {
                btn.disabled = true;
                btn.classList.add('ob-btn-disabled');
            }
        }

        // Allow keyboard selection (Enter / Space) on the card labels
        function handleCardKey(e, radioId) {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                var radio = document.getElementById(radioId);
                if (radio) {
                    radio.checked = true;
                    onLevelChange();
                }
            }
        }
    </script>

</asp:Content>
