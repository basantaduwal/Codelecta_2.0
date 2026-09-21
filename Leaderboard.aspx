<%@ Page Title="Quiz Leaderboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Leaderboard.aspx.cs" Inherits="Codelecta_2._0.Leaderboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div style="background: var(--bg-page); min-height: calc(100vh - 76px); padding: 40px 0 80px 0;">
        <div class="container" style="max-width: 1000px; margin: 0 auto; padding: 0 24px;">

            <!-- ==================== PAGE HEADER ==================== -->
            <div style="background: linear-gradient(135deg, #21094E 0%, #170638 50%, #0D0226 100%); border-radius: 24px; padding: 44px 48px; color: #FFFFFF; margin-bottom: 44px; box-shadow: 0 16px 40px rgba(33,9,78,0.25); position: relative; overflow: hidden; border: 1px solid rgba(255,255,255,0.1);">
                <div style="position: absolute; top: -50px; right: -50px; width: 220px; height: 220px; border-radius: 50%; background: radial-gradient(circle, rgba(139,92,246,0.3) 0%, transparent 70%); pointer-events: none;"></div>
                <div style="position: absolute; bottom: -40px; left: -40px; width: 180px; height: 180px; border-radius: 50%; background: radial-gradient(circle, rgba(99,102,241,0.2) 0%, transparent 70%); pointer-events: none;"></div>
                <div style="position: relative; z-index: 2;">
                    <span style="display: inline-block; font-size: 0.78rem; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; color: #C4B5FD; background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.15); padding: 4px 14px; border-radius: 999px; margin-bottom: 14px;">QUIZ LEADERBOARD</span>
                    <h1 style="font-size: 2.4rem; font-weight: 800; margin: 0 0 10px 0; letter-spacing: -0.02em;">Top Performers 🏆</h1>
                    <p style="color: rgba(255,255,255,0.7); font-size: 1rem; margin: 0 0 32px 0;">See how you rank against fellow learners based on quiz scores and performance.</p>

                    <!-- Summary stats -->
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 16px;">
                        <div style="background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.12); border-radius: 14px; padding: 18px; backdrop-filter: blur(8px);">
                            <span style="font-size: 0.8rem; color: rgba(255,255,255,0.6); font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Total Learners</span>
                            <div style="font-size: 2rem; font-weight: 900; color: #FFFFFF; margin-top: 4px;"><asp:Label ID="lblTotalLearners" runat="server" Text="0"></asp:Label></div>
                        </div>
                        <div style="background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.12); border-radius: 14px; padding: 18px; backdrop-filter: blur(8px);">
                            <span style="font-size: 0.8rem; color: rgba(255,255,255,0.6); font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Total Attempts</span>
                            <div style="font-size: 2rem; font-weight: 900; color: #34D399; margin-top: 4px;"><asp:Label ID="lblTotalAttempts" runat="server" Text="0"></asp:Label></div>
                        </div>
                        <div style="background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.12); border-radius: 14px; padding: 18px; backdrop-filter: blur(8px);">
                            <span style="font-size: 0.8rem; color: rgba(255,255,255,0.6); font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Avg Score</span>
                            <div style="font-size: 2rem; font-weight: 900; color: #A78BFA; margin-top: 4px;"><asp:Label ID="lblAvgScore" runat="server" Text="0%"></asp:Label></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==================== YOUR RANK BANNER (logged in only) ==================== -->
            <asp:Panel ID="pnlYourRank" runat="server" Visible="false">
                <div style="background: #FFFFFF; border: 2px solid #DDD6FE; border-radius: 16px; padding: 20px 28px; margin-bottom: 28px; display: flex; align-items: center; gap: 20px; box-shadow: 0 4px 16px rgba(108,92,231,0.08); flex-wrap: wrap;">
                    <div style="width: 48px; height: 48px; border-radius: 50%; background: linear-gradient(135deg, #6C5CE7, #A855F7); display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                    </div>
                    <div style="flex: 1;">
                        <span style="font-size: 0.78rem; font-weight: 700; color: #6C5CE7; text-transform: uppercase; letter-spacing: 0.5px;">Your Standing</span>
                        <div style="font-size: 1.05rem; font-weight: 800; color: #1E1B4B; margin-top: 2px;">
                            You are ranked <asp:Label ID="lblYourRank" runat="server" style="color: #6C5CE7;"></asp:Label>
                            &nbsp;&bull;&nbsp; Best Score: <asp:Label ID="lblYourBestScore" runat="server" style="color: #059669;"></asp:Label>
                            &nbsp;&bull;&nbsp; Avg Score: <asp:Label ID="lblYourAvgScore" runat="server" style="color: #6C5CE7;"></asp:Label>
                            &nbsp;&bull;&nbsp; Quizzes Taken: <asp:Label ID="lblYourAttempts" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <!-- ==================== LEADERBOARD TABLE ==================== -->
            <asp:Panel ID="pnlLeaderboard" runat="server">
                <div style="background: #FFFFFF; border-radius: 20px; border: 1px solid var(--border); box-shadow: var(--shadow-sm); overflow: hidden;">
                    <div style="padding: 24px 28px 16px; border-bottom: 1px solid #F1F0FB;">
                        <h2 style="font-size: 1.4rem; font-weight: 800; color: #1E1B4B; margin: 0 0 4px 0;">Top 10 Performers</h2>
                        <p style="font-size: 0.88rem; color: #64748B; margin: 0;">Ranked by average quiz score. Ties broken by quizzes completed.</p>
                    </div>
                    <asp:Repeater ID="rptLeaderboard" runat="server">
                        <HeaderTemplate>
                            <table style="width: 100%; border-collapse: collapse; font-size: 0.9rem;">
                                <thead>
                                    <tr style="background: #F8F7FF; border-bottom: 2px solid #EDE9FE;">
                                        <th style="padding: 12px 20px; text-align: left; font-weight: 700; color: #475569; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.5px; width: 60px;">Rank</th>
                                        <th style="padding: 12px 16px; text-align: left; font-weight: 700; color: #475569; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.5px;">Learner</th>
                                        <th style="padding: 12px 16px; text-align: center; font-weight: 700; color: #475569; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.5px;">Avg Score</th>
                                        <th style="padding: 12px 16px; text-align: center; font-weight: 700; color: #475569; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.5px;">Best Score</th>
                                        <th style="padding: 12px 16px; text-align: center; font-weight: 700; color: #475569; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.5px;">Quizzes</th>
                                        <th style="padding: 12px 20px; text-align: center; font-weight: 700; color: #475569; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.5px;">Passed</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr style='<%# Container.ItemIndex % 2 == 0 ? "background: #FFFFFF;" : "background: #FAFAFA;" %> border-bottom: 1px solid #F1F0FB; transition: background 0.15s;'>
                                <!-- Rank -->
                                <td style="padding: 16px 20px; text-align: left;">
                                    <%# GetRankBadge((int)Eval("Rank")) %>
                                </td>
                                <!-- Learner -->
                                <td style="padding: 16px 16px;">
                                    <div style="display: flex; align-items: center; gap: 12px;">
                                        <div style='width: 38px; height: 38px; border-radius: 50%; background: <%# GetAvatarColor(Container.ItemIndex) %>; display: flex; align-items: center; justify-content: center; font-size: 0.95rem; font-weight: 800; color: white; flex-shrink: 0;'>
                                            <%# GetInitial((string)Eval("DisplayName")) %>
                                        </div>
                                        <div>
                                            <div style="font-weight: 700; color: #1E1B4B; font-size: 0.95rem;"><%# Eval("DisplayName") %></div>
                                            <div style="font-size: 0.78rem; color: #94A3B8;"><%# Eval("ExperienceLevel") %> Learner</div>
                                        </div>
                                    </div>
                                </td>
                                <!-- Avg Score -->
                                <td style="padding: 16px; text-align: center;">
                                    <div style="font-weight: 800; font-size: 1.1rem; color: #6C5CE7;"><%# Eval("AvgScore") %>%</div>
                                    <div style="margin-top: 4px; height: 4px; background: #EDE9FE; border-radius: 9999px; width: 70px; margin-left: auto; margin-right: auto; overflow: hidden;">
                                        <div style='height: 100%; background: linear-gradient(90deg, #6C5CE7, #A855F7); border-radius: 9999px; width: <%# Eval("AvgScore") %>%;'></div>
                                    </div>
                                </td>
                                <!-- Best Score -->
                                <td style="padding: 16px; text-align: center; font-weight: 700; color: #059669; font-size: 1rem;"><%# Eval("BestScore") %>%</td>
                                <!-- Quizzes Taken -->
                                <td style="padding: 16px; text-align: center; color: #475569; font-weight: 600;"><%# Eval("TotalAttempts") %></td>
                                <!-- Pass Rate -->
                                <td style="padding: 16px 20px; text-align: center;">
                                    <span style='<%# (int)Eval("PassedCount") > 0 ? "background: #ECFDF5; color: #065F46; border: 1px solid #6EE7B7;" : "background: #F8FAFC; color: #94A3B8; border: 1px solid #E2E8F0;" %> padding: 4px 12px; border-radius: 20px; font-size: 0.78rem; font-weight: 700;'>
                                        <%# Eval("PassedCount") %> / <%# Eval("TotalAttempts") %>
                                    </span>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </asp:Panel>

            <!-- Empty state -->
            <asp:Panel ID="pnlEmpty" runat="server" Visible="false"
                style="background: #FFFFFF; border-radius: 20px; border: 1px dashed #DDD6FE; padding: 60px 40px; text-align: center; box-shadow: var(--shadow-sm);">
                <div style="font-size: 3rem; margin-bottom: 16px;">🏆</div>
                <h3 style="font-size: 1.4rem; font-weight: 800; color: var(--text-primary); margin: 0 0 8px 0;">No Quiz Data Yet</h3>
                <p style="color: var(--text-secondary); font-size: 0.95rem; max-width: 400px; margin: 0 auto 24px auto; line-height: 1.6;">
                    Be the first on the leaderboard! Complete a course quiz to see your name here.
                </p>
                <a href="Courses" class="btn-primary" style="padding: 12px 28px; font-size: 0.95rem; font-weight: 700; border-radius: 8px; text-decoration: none;">Browse Courses</a>
            </asp:Panel>

        </div>
    </div>
</asp:Content>
