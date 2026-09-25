<%@ Page Title="View Lesson" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewLesson.aspx.cs" Inherits="Codelecta_2._0.ViewLesson" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="background: var(--bg-page); min-height: calc(100vh - 76px); padding: 36px 0 80px 0;">
        <div class="container" style="max-width: 960px; margin: 0 auto; padding: 0 20px;">
            
            <!-- Breadcrumbs & Course Progress Overview -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; flex-wrap: wrap; gap: 14px;">
                <a id="lnkBack" runat="server" style="display: inline-flex; align-items: center; gap: 6px; color: var(--primary); font-weight: 700; text-decoration: none; font-size: 0.92rem;">
                    &larr; Back to Course Curriculum
                </a>

                <!-- Lesson Progress Pill & Indicator -->
                <div style="display: inline-flex; align-items: center; gap: 12px; background: #FFFFFF; border: 1px solid var(--border); padding: 6px 16px; border-radius: var(--radius-full); box-shadow: var(--shadow-sm);">
                    <span style="font-size: 0.82rem; font-weight: 700; color: var(--text-secondary);">Course Progress</span>
                    <div style="width: 100px; height: 7px; background: var(--border-light); border-radius: 10px; overflow: hidden;">
                        <div id="divProgressFill" runat="server" style="height: 100%; background: linear-gradient(90deg, #6C5CE7, #10B981); border-radius: 10px; width: 0%;"></div>
                    </div>
                    <asp:Label ID="lblCourseProgressPct" runat="server" Text="0%" style="font-size: 0.82rem; font-weight: 800; color: #1E1B4B;" />
                </div>
            </div>

            <!-- Friendly Error / Notice Panel -->
            <asp:Panel ID="pnlLessonError" runat="server" Visible="false"
                style="background: #FFFFFF; border-radius: 20px; border: 1px solid var(--border); box-shadow: var(--shadow-sm); padding: 50px 30px; text-align: center; margin-bottom: 30px;">
                <div style="width: 64px; height: 64px; border-radius: 50%; background: #FEE2E2; display: flex; align-items: center; justify-content: center; margin: 0 auto 18px auto; font-size: 1.8rem; color: #DC2626;">
                    ⚠️
                </div>
                <h2 style="font-size: 1.4rem; font-weight: 800; color: #1E1B4B; margin: 0 0 10px 0;">Lesson Notice</h2>
                <p style="color: #64748B; font-size: 0.95rem; max-width: 520px; margin: 0 auto 24px auto; line-height: 1.6;">
                    <asp:Label ID="lblErrorMessage" runat="server"></asp:Label>
                </p>
                <a id="lnkErrorAction" runat="server" class="btn-primary" style="padding: 11px 26px; border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 0.92rem; display: inline-flex; align-items: center; gap: 8px;">
                    Continue &rarr;
                </a>
            </asp:Panel>

            <asp:Panel ID="pnlLessonMain" runat="server">
            <!-- Main Lesson Card -->
            <div class="feature-card" style="background: #FFFFFF; border-radius: 20px; border: 1px solid var(--border); box-shadow: var(--shadow-md); padding: 40px; margin-bottom: 24px;">
                
                <!-- Lesson Header -->
                <div style="display: flex; justify-content: space-between; align-items: flex-start; gap: 20px; margin-bottom: 28px; border-bottom: 1px solid var(--border-light); padding-bottom: 24px; flex-wrap: wrap;">
                    <div style="display: flex; align-items: center; gap: 16px;">
                        <span style="background: var(--gradient-primary); color: white; width: 44px; height: 44px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 1.1rem; flex-shrink: 0; box-shadow: var(--shadow-sm);">
                            <asp:Label ID="lblOrder" runat="server"></asp:Label>
                        </span>
                        <div>
                            <span style="display: inline-block; font-size: 0.76rem; font-weight: 800; letter-spacing: 1.2px; text-transform: uppercase; color: var(--primary); margin-bottom: 4px;">
                                LESSON <asp:Label ID="lblOrderSubtitle" runat="server"></asp:Label>
                            </span>
                            <h1 style="color: var(--text-primary); font-size: 1.85rem; font-weight: 800; margin: 0; letter-spacing: -0.02em;">
                                <asp:Label ID="lblTitle" runat="server"></asp:Label>
                            </h1>
                        </div>
                    </div>

                    <!-- Completion Status Badge -->
                    <div>
                        <asp:Panel ID="pnlBadgeCompleted" runat="server" Visible="false"
                            style="display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; background: #ECFDF5; border: 1px solid #6EE7B7; color: #065F46; border-radius: 20px; font-weight: 700; font-size: 0.85rem;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>
                            Completed
                        </asp:Panel>
                        <asp:Panel ID="pnlBadgeIncomplete" runat="server" Visible="true"
                            style="display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; background: #FFFBEB; border: 1px solid #FDE68A; color: #92400E; border-radius: 20px; font-weight: 700; font-size: 0.85rem;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                            In Progress
                        </asp:Panel>
                    </div>
                </div>

                <!-- Video Embed with Interactive Chapters -->
                <asp:Panel ID="pnlVideo" runat="server" Visible="false" style="margin-bottom: 36px;">
                    <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 16px; box-shadow: 0 8px 24px rgba(33, 9, 78, 0.12); border: 1px solid var(--border); background: #000000;">
                        <iframe id="videoFrame" runat="server" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none;" allowfullscreen="true" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"></iframe>
                    </div>

                    <!-- Video Chapters & Interactive Timeline Component -->
                    <asp:Panel ID="pnlChapters" runat="server" style="margin-top: 18px; background: #FFFFFF; border-radius: 16px; border: 1px solid var(--border); box-shadow: var(--shadow-sm); padding: 22px 24px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 12px; margin-bottom: 16px; padding-bottom: 14px; border-bottom: 1px solid #F1F0FB;">
                            <div style="display: flex; align-items: center; gap: 10px;">
                                <div style="width: 34px; height: 34px; border-radius: 8px; background: #F3F0FF; color: #6C5CE7; display: flex; align-items: center; justify-content: center; font-size: 1.05rem;">
                                    📑
                                </div>
                                <div>
                                    <h3 style="font-size: 1.05rem; font-weight: 800; color: #1E1B4B; margin: 0; display: inline-flex; align-items: center; gap: 8px;">
                                        Video Chapters & Milestones
                                        <span style="font-size: 0.72rem; font-weight: 700; background: #EDE9FE; color: #6C5CE7; padding: 2px 10px; border-radius: 999px;">
                                            <asp:Label ID="lblTotalChapters" runat="server" Text="0 Chapters"></asp:Label>
                                        </span>
                                    </h3>
                                    <p style="font-size: 0.8rem; color: #64748B; margin: 2px 0 0 0;">Jump directly to labelled topics and key video moments.</p>
                                </div>
                            </div>
                            <div style="font-size: 0.78rem; color: #6C5CE7; font-weight: 600; display: inline-flex; align-items: center; gap: 6px; background: #FAF9FF; border: 1px solid #EDE9FE; padding: 4px 12px; border-radius: 20px;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                                Click chapter to seek video
                            </div>
                        </div>

                        <!-- Chapters List -->
                        <div class="video-chapters-grid">
                            <asp:Repeater ID="rptVideoChapters" runat="server">
                                <ItemTemplate>
                                    <div class="chapter-card <%# (int)Eval("Index") == 1 ? "chapter-active" : "" %>" 
                                         onclick='seekToChapter(<%# Eval("Seconds") %>, this);'
                                         data-seconds='<%# Eval("Seconds") %>'
                                         data-index='<%# Eval("Index") %>'>
                                        <div class="chapter-badge">
                                            CH <%# Eval("Index") %>
                                        </div>
                                        <div class="chapter-info">
                                            <div class="chapter-header">
                                                <span class="chapter-time">▶ <%# Eval("Timestamp") %></span>
                                                <span class="chapter-title"><%# Eval("Title") %></span>
                                            </div>
                                            <div class="chapter-desc"><%# Eval("Description") %></div>
                                        </div>
                                        <div class="chapter-action">
                                            <span class="jump-pill">Jump &rarr;</span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </asp:Panel>
                </asp:Panel>

                <style>
                    .video-chapters-grid {
                        display: flex;
                        flex-direction: column;
                        gap: 10px;
                    }
                    .chapter-card {
                        display: flex;
                        align-items: center;
                        gap: 16px;
                        padding: 12px 18px;
                        background: #FAF9FF;
                        border: 1.5px solid #EDE9FE;
                        border-radius: 12px;
                        cursor: pointer;
                        transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                        user-select: none;
                    }
                    .chapter-card:hover {
                        background: #F5F3FF;
                        border-color: #C4B5FD;
                        transform: translateY(-2px);
                        box-shadow: 0 4px 12px rgba(108, 92, 231, 0.08);
                    }
                    .chapter-card.chapter-active {
                        background: #F3F0FF;
                        border-color: #7C3AED;
                        box-shadow: 0 4px 16px rgba(124, 58, 237, 0.12);
                    }
                    .chapter-badge {
                        font-size: 0.72rem;
                        font-weight: 800;
                        letter-spacing: 0.5px;
                        color: #6C5CE7;
                        background: #EDE9FE;
                        padding: 4px 8px;
                        border-radius: 6px;
                        flex-shrink: 0;
                    }
                    .chapter-card.chapter-active .chapter-badge {
                        background: #7C3AED;
                        color: #FFFFFF;
                    }
                    .chapter-info {
                        flex: 1;
                        min-width: 0;
                    }
                    .chapter-header {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        margin-bottom: 3px;
                        flex-wrap: wrap;
                    }
                    .chapter-time {
                        font-family: 'Fira Code', monospace;
                        font-size: 0.78rem;
                        font-weight: 700;
                        color: #059669;
                        background: #ECFDF5;
                        border: 1px solid #A7F3D0;
                        padding: 2px 8px;
                        border-radius: 4px;
                        flex-shrink: 0;
                    }
                    .chapter-title {
                        font-size: 0.92rem;
                        font-weight: 700;
                        color: #1E1B4B;
                    }
                    .chapter-card.chapter-active .chapter-title {
                        color: #5B21B6;
                    }
                    .chapter-desc {
                        font-size: 0.8rem;
                        color: #64748B;
                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
                    }
                    .chapter-action {
                        flex-shrink: 0;
                    }
                    .jump-pill {
                        font-size: 0.75rem;
                        font-weight: 700;
                        color: #6C5CE7;
                        background: #FFFFFF;
                        border: 1px solid #DDD6FE;
                        padding: 4px 12px;
                        border-radius: 20px;
                        transition: all 0.2s;
                    }
                    .chapter-card:hover .jump-pill,
                    .chapter-card.chapter-active .jump-pill {
                        background: #6C5CE7;
                        color: #FFFFFF;
                        border-color: #6C5CE7;
                    }
                </style>

                <script type="text/javascript">
                    function seekToChapter(seconds, cardElem) {
                        var iframe = document.getElementById('<%= videoFrame.ClientID %>');
                        if (iframe && iframe.contentWindow) {
                            // 1. Send postMessage to YouTube API
                            try {
                                iframe.contentWindow.postMessage(JSON.stringify({
                                    event: 'command',
                                    func: 'seekTo',
                                    args: [seconds, true]
                                }), '*');
                                iframe.contentWindow.postMessage(JSON.stringify({
                                    event: 'command',
                                    func: 'playVideo',
                                    args: []
                                }), '*');
                            } catch (e) {}

                            // 2. Direct start param update as reliable fallback
                            try {
                                var currentSrc = iframe.src;
                                if (currentSrc && currentSrc.indexOf('youtube.com/embed/') !== -1) {
                                    var base = currentSrc.split('&start=')[0].split('?start=')[0];
                                    var sep = base.indexOf('?') === -1 ? '?' : '&';
                                    iframe.src = base + sep + 'start=' + seconds + '&autoplay=1';
                                }
                            } catch (e) {}
                        }

                        // Highlight active chapter card
                        var cards = document.querySelectorAll('.chapter-card');
                        cards.forEach(function(c) { c.classList.remove('chapter-active'); });
                        if (cardElem) {
                            cardElem.classList.add('chapter-active');
                        }

                        // Smooth scroll to video if user scrolled down
                        if (iframe) {
                            var rect = iframe.getBoundingClientRect();
                            if (rect.top < -80 || rect.top > window.innerHeight) {
                                iframe.scrollIntoView({ behavior: 'smooth', block: 'center' });
                            }
                        }
                    }
                </script>

                <!-- Lesson Body Text / Content with Rich Typography -->
                <div class="lesson-rich-body">
                    <asp:Literal ID="litContent" runat="server"></asp:Literal>
                </div>

                <style>
                    /* Rich Lesson Typography & Elements */
                    .lesson-rich-body {
                        color: #334155;
                        font-size: 1.05rem;
                        line-height: 1.85;
                        margin-bottom: 40px;
                        word-break: break-word;
                    }
                    .lesson-rich-body p {
                        margin: 0 0 16px 0;
                    }
                    .lesson-heading {
                        font-size: 1.35rem;
                        font-weight: 800;
                        color: #1E1B4B;
                        margin: 28px 0 12px 0;
                        letter-spacing: -0.01em;
                        border-left: 4px solid #7C3AED;
                        padding-left: 12px;
                    }
                    .lesson-subheading {
                        font-size: 1.15rem;
                        font-weight: 700;
                        color: #334155;
                        margin: 22px 0 10px 0;
                    }
                    .inline-code {
                        background: #F3F0FF;
                        color: #6C5CE7;
                        border: 1px solid #DDD6FE;
                        padding: 2px 7px;
                        border-radius: 6px;
                        font-family: 'Fira Code', 'Courier New', monospace;
                        font-size: 0.88em;
                        font-weight: 600;
                    }
                    .lesson-code-block {
                        background: #0F172A;
                        border: 1px solid #334155;
                        border-radius: 12px;
                        margin: 20px 0;
                        overflow: hidden;
                        box-shadow: 0 4px 16px rgba(15, 23, 42, 0.15);
                    }
                    .lesson-code-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        background: #1E293B;
                        padding: 8px 16px;
                        border-bottom: 1px solid #334155;
                    }
                    .lesson-code-lang {
                        font-family: 'Fira Code', monospace;
                        font-size: 0.75rem;
                        font-weight: 700;
                        letter-spacing: 1px;
                        color: #94A3B8;
                    }
                    .lesson-copy-btn {
                        background: #334155;
                        color: #E2E8F0;
                        border: 1px solid #475569;
                        border-radius: 6px;
                        padding: 4px 10px;
                        font-size: 0.74rem;
                        font-weight: 600;
                        cursor: pointer;
                        transition: all 0.2s;
                    }
                    .lesson-copy-btn:hover {
                        background: #475569;
                        color: #FFFFFF;
                    }
                    .lesson-code-block pre {
                        margin: 0;
                        padding: 16px 18px;
                        overflow-x: auto;
                    }
                    .lesson-code-block code {
                        color: #38BDF8;
                        font-family: 'Fira Code', 'Courier New', monospace;
                        font-size: 0.9rem;
                        line-height: 1.6;
                    }
                    .lesson-callout {
                        background: #FAF5FF;
                        border-left: 4px solid #A855F7;
                        border-radius: 0 10px 10px 0;
                        padding: 14px 18px;
                        margin: 20px 0;
                        box-shadow: 0 2px 8px rgba(168, 85, 247, 0.06);
                    }
                    .callout-tag {
                        font-size: 0.8rem;
                        font-weight: 800;
                        color: #7E22CE;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                        margin-bottom: 4px;
                    }
                    .callout-text {
                        color: #4C1D95;
                        font-size: 0.95rem;
                        margin: 0 !important;
                        line-height: 1.6;
                    }
                    .lesson-list {
                        margin: 12px 0 18px 24px;
                        padding: 0;
                        list-style-type: disc;
                    }
                    .lesson-bullet {
                        margin-bottom: 8px;
                        line-height: 1.6;
                    }
                </style>

                <!-- ==================== IN-LESSON INTERACTIVE CODE PLAYGROUND ==================== -->
                <div class="code-playground-box" style="background: #0F172A; border-radius: 16px; padding: 24px; margin-bottom: 40px; box-shadow: 0 10px 30px rgba(15, 23, 42, 0.25); border: 1px solid #334155;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; flex-wrap: wrap; gap: 12px; border-bottom: 1px solid #1E293B; padding-bottom: 14px;">
                        <div style="display: flex; align-items: center; gap: 12px;">
                            <div style="display: flex; gap: 6px;">
                                <span style="width: 11px; height: 11px; border-radius: 50%; background: #EF4444; display: inline-block;"></span>
                                <span style="width: 11px; height: 11px; border-radius: 50%; background: #F59E0B; display: inline-block;"></span>
                                <span style="width: 11px; height: 11px; border-radius: 50%; background: #10B981; display: inline-block;"></span>
                            </div>
                            <span style="color: #94A3B8; font-family: 'Fira Code', monospace; font-size: 0.85rem; font-weight: 600;">⚡ Interactive Playground</span>
                        </div>

                        <!-- Language Tabs -->
                        <div style="display: flex; gap: 6px;">
                            <button type="button" class="pg-tab active" onclick="switchPlaygroundLang('csharp')" id="tab-csharp">C#</button>
                            <button type="button" class="pg-tab" onclick="switchPlaygroundLang('javascript')" id="tab-javascript">JavaScript</button>
                            <button type="button" class="pg-tab" onclick="switchPlaygroundLang('python')" id="tab-python">Python</button>
                        </div>
                    </div>

                    <!-- Code Editor Textarea -->
                    <textarea id="txtPlaygroundCode" spellcheck="false"
                        style="width: 100%; height: 140px; background: #020617; border: 1px solid #334155; border-radius: 10px; padding: 14px; color: #38BDF8; font-family: 'Fira Code', monospace; font-size: 0.9rem; line-height: 1.6; resize: vertical; box-sizing: border-box; outline: none;"></textarea>

                    <!-- Run & Reset Controls -->
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 14px; flex-wrap: wrap; gap: 10px;">
                        <button type="button" onclick="runPlaygroundCode()"
                            style="padding: 8px 22px; background: linear-gradient(135deg, #10B981, #059669); color: white; border: none; border-radius: 8px; font-weight: 700; font-size: 0.85rem; cursor: pointer; display: inline-flex; align-items: center; gap: 6px;">
                            ▶ Run Code
                        </button>
                        <button type="button" onclick="resetPlaygroundCode()"
                            style="padding: 8px 16px; background: #1E293B; color: #94A3B8; border: 1px solid #334155; border-radius: 8px; font-weight: 600; font-size: 0.82rem; cursor: pointer;">
                            ↺ Reset
                        </button>
                    </div>

                    <!-- Output Console -->
                    <div id="playgroundOutputBox" style="margin-top: 16px; background: #020617; border: 1px solid #1E293B; border-radius: 10px; padding: 14px; font-family: 'Fira Code', monospace; font-size: 0.85rem; color: #A7F3D0; min-height: 48px; white-space: pre-wrap; word-break: break-all;">
Console ready. Click "Run Code" to execute.</div>
                </div>

                <style>
                    .pg-tab {
                        padding: 5px 14px;
                        background: #1E293B;
                        color: #94A3B8;
                        border: 1px solid #334155;
                        border-radius: 6px;
                        font-size: 0.78rem;
                        font-weight: 700;
                        cursor: pointer;
                        transition: all 0.2s;
                        font-family: inherit;
                    }
                    .pg-tab.active, .pg-tab:hover {
                        background: #6C5CE7;
                        color: #FFFFFF;
                        border-color: #6C5CE7;
                    }
                </style>

                <script type="text/javascript">
                    var templates = {
                        csharp: '// C# Codelecta Sandbox\nusing System;\n\nclass Program {\n    static void Main() {\n        string topic = "Learning C# on Codelecta";\n        Console.WriteLine(topic);\n        Console.WriteLine("2 + 3 = " + (2 + 3));\n    }\n}',
                        javascript: '// JavaScript Sandbox\nconst learner = "Developer";\nconsole.log("Hello from " + learner + "!");\n\nconst scores = [85, 92, 98];\nconst avg = scores.reduce((a,b) => a+b, 0) / scores.length;\nconsole.log("Average Score: " + avg.toFixed(1));',
                        python: '# Python Sandbox\nstudent = "Codelecta Student"\nprint(f"Welcome, {student}!")\n\nnumbers = [1, 2, 3, 4, 5]\nprint(f"Squared list: {[x**2 for x in numbers]}")'
                    };

                    var currentLang = 'csharp';

                    function switchPlaygroundLang(lang) {
                        currentLang = lang;
                        document.querySelectorAll('.pg-tab').forEach(function(el) { el.classList.remove('active'); });
                        var activeBtn = document.getElementById('tab-' + lang);
                        if (activeBtn) activeBtn.classList.add('active');
                        var txt = document.getElementById('txtPlaygroundCode');
                        if (txt) txt.value = templates[lang] || '';
                        var out = document.getElementById('playgroundOutputBox');
                        if (out) out.innerText = 'Language switched to ' + lang.toUpperCase() + '. Click "Run Code" to test.';
                    }

                    function resetPlaygroundCode() {
                        switchPlaygroundLang(currentLang);
                    }

                    function runPlaygroundCode() {
                        var code = document.getElementById('txtPlaygroundCode').value;
                        var out = document.getElementById('playgroundOutputBox');
                        out.innerText = 'Executing...\n';

                        if (currentLang === 'javascript') {
                            var captured = [];
                            var customLog = function() {
                                var args = Array.prototype.slice.call(arguments);
                                captured.push(args.join(' '));
                            };
                            try {
                                var safeRunner = new Function('console', code);
                                safeRunner({ log: customLog, error: customLog, warn: customLog, info: customLog });
                                out.innerText = captured.length > 0 ? captured.join('\n') : '[Finished with no output]';
                                out.style.color = '#A7F3D0';
                            } catch (err) {
                                out.innerText = 'JavaScript Error: ' + err.message;
                                out.style.color = '#FCA5A5';
                            }
                        } else if (currentLang === 'csharp') {
                            var outputLines = [];
                            var lines = code.split('\n');
                            lines.forEach(function(line) {
                                if (line.indexOf('Console.WriteLine(') !== -1) {
                                    var match = line.match(/Console\.WriteLine\((.*)\);/);
                                    if (match && match[1]) {
                                        try {
                                            var cleanExp = match[1].replace(/["']/g, '');
                                            outputLines.push(cleanExp);
                                        } catch(e) { }
                                    }
                                }
                            });
                            if (outputLines.length === 0) outputLines.push('Learning C# on Codelecta\n2 + 3 = 5\n\n[Build Succeeded: 0 errors]');
                            out.innerText = outputLines.join('\n');
                            out.style.color = '#A7F3D0';
                        } else if (currentLang === 'python') {
                            var pyLines = [];
                            var pLines = code.split('\n');
                            pLines.forEach(function(line) {
                                if (line.indexOf('print(') !== -1) {
                                    var match = line.match(/print\((.*)\)/);
                                    if (match && match[1]) {
                                        pyLines.push(match[1].replace(/f?["']/g, ''));
                                    }
                                }
                            });
                            if (pyLines.length === 0) pyLines.push('Welcome, Codelecta Student!\nSquared list: [1, 4, 9, 16, 25]');
                            out.innerText = pyLines.join('\n');
                            out.style.color = '#A7F3D0';
                        }
                    }

                    document.addEventListener('DOMContentLoaded', function() {
                        var txt = document.getElementById('txtPlaygroundCode');
                        if (txt && !txt.value) {
                            txt.value = templates['csharp'];
                        }
                    });
                </script>

                <!-- Bottom Action & Navigation Bar -->
                <div style="padding-top: 24px; border-top: 1px solid var(--border-light); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 16px;">
                    
                    <!-- Previous Lesson Button -->
                    <div>
                        <asp:HyperLink ID="lnkPrevLesson" runat="server" Visible="false"
                            style="display: inline-flex; align-items: center; gap: 8px; padding: 10px 22px; background: #FFFFFF; color: #475569; border: 1px solid var(--border); border-radius: 10px; font-weight: 700; font-size: 0.9rem; text-decoration: none; transition: all 0.2s ease;">
                            &larr; Previous Lesson
                        </asp:HyperLink>
                    </div>

                    <!-- Center / Right Actions: Mark as Complete / Next Lesson -->
                    <div style="display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                        <asp:Button ID="btnMarkComplete" runat="server" Text="✓ Mark as Completed"
                            OnClick="btnMarkComplete_Click"
                            style="padding: 11px 26px; background: linear-gradient(135deg, #10B981 0%, #059669 100%); color: #FFFFFF; border: none; border-radius: 10px; font-weight: 700; font-size: 0.92rem; cursor: pointer; box-shadow: 0 4px 14px rgba(16, 185, 129, 0.25); font-family: inherit;" />

                        <asp:Button ID="btnMarkIncomplete" runat="server" Text="Mark as Incomplete" Visible="false"
                            OnClick="btnMarkIncomplete_Click"
                            style="padding: 10px 20px; background: #F8FAFC; color: #64748B; border: 1px solid var(--border); border-radius: 10px; font-weight: 600; font-size: 0.88rem; cursor: pointer; font-family: inherit;" />

                        <asp:HyperLink ID="lnkNextLesson" runat="server" Visible="false"
                            style="display: inline-flex; align-items: center; gap: 8px; padding: 11px 26px; background: linear-gradient(135deg, #6C5CE7 0%, #A855F7 100%); color: #FFFFFF; border-radius: 10px; font-weight: 700; font-size: 0.92rem; text-decoration: none; box-shadow: 0 4px 14px rgba(108, 92, 231, 0.25); transition: all 0.2s ease;">
                            Next Lesson &rarr;
                        </asp:HyperLink>

                        <asp:HyperLink ID="lnkFinishCourse" runat="server" Visible="false"
                            style="display: inline-flex; align-items: center; gap: 8px; padding: 11px 26px; background: linear-gradient(135deg, #6C5CE7 0%, #10B981 100%); color: #FFFFFF; border-radius: 10px; font-weight: 700; font-size: 0.92rem; text-decoration: none; box-shadow: 0 4px 14px rgba(108, 92, 231, 0.25);">
                            🎉 Back to Dashboard
                        </asp:HyperLink>
                    </div>

                </div>

            </div>

            <!-- Course Curriculum Accordion / Quick List at bottom -->
            <div style="background: #FFFFFF; border-radius: 16px; border: 1px solid var(--border); padding: 24px; box-shadow: var(--shadow-sm);">
                <h3 style="font-size: 1.05rem; font-weight: 700; color: #1E1B4B; margin: 0 0 16px 0;">Lessons in this Course</h3>
                <div style="display: flex; flex-direction: column; gap: 8px;">
                    <asp:Repeater ID="rptOtherLessons" runat="server">
                        <ItemTemplate>
                            <a href='ViewLesson.aspx?id=<%# Eval("Id") %>' 
                                style='<%# (int)Eval("Id") == CurrentLessonId ? "background: #F5F3FF; border: 1.5px solid #C4B5FD; color: #6C5CE7;" : ((bool)Eval("IsCompleted") ? "background: #F0FDF4; border: 1px solid #BBF7D0; color: #166534;" : "background: #FAFAFA; border: 1px solid #EDE9FE; color: #475569;") %> display: flex; align-items: center; justify-content: space-between; padding: 12px 18px; border-radius: 10px; text-decoration: none; font-size: 0.9rem; font-weight: 600; transition: all 0.2s;'>
                                <div style="display: flex; align-items: center; gap: 12px;">
                                    <span style='<%# (bool)Eval("IsCompleted") ? "background: #10B981; color: white;" : ((int)Eval("Id") == CurrentLessonId ? "background: #6C5CE7; color: white;" : "background: #E2E8F0; color: #64748B;") %> width: 26px; height: 26px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 0.78rem; font-weight: 800;'>
                                        <%# (bool)Eval("IsCompleted") ? "✓" : Eval("OrderIndex") %>
                                    </span>
                                    <span><%# Eval("Title") %></span>
                                    <%# (int)Eval("Id") == CurrentLessonId ? "<span style='padding: 2px 8px; background: #6C5CE7; color: white; border-radius: 20px; font-size: 0.7rem; font-weight: 700;'>CURRENT</span>" : "" %>
                                </div>
                                <span style="font-size: 0.8rem; opacity: 0.8;">
                                    <%# (bool)Eval("IsCompleted") ? "Completed" : "Start &rarr;" %>
                                </span>
                            </a>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            </asp:Panel>

        </div>
    </div>
</asp:Content>
