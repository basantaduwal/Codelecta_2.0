<%@ Page Title="Take Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TakeQuiz.aspx.cs" Inherits="Codelecta_2._0.TakeQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="background: var(--bg-page); min-height: calc(100vh - 76px); padding: 40px 0 80px 0;">
        <div class="container" style="max-width: 820px; margin: 0 auto; padding: 0 20px;">

            <!-- Header Card -->
            <div class="feature-card" style="background: #FFFFFF; border-radius: 20px; border: 1px solid var(--border); box-shadow: var(--shadow-sm); padding: 36px; margin-bottom: 28px;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; flex-wrap: wrap; gap: 12px;">
                    <a id="lnkBackCourse" runat="server" style="color: var(--primary); font-weight: 700; text-decoration: none; font-size: 0.9rem;">
                        &larr; Back to Course
                    </a>
                    <span style="padding: 4px 14px; background: #F3F0FF; color: #6C5CE7; border: 1px solid #DDD6FE; border-radius: 20px; font-weight: 700; font-size: 0.8rem;">
                        <asp:Label ID="lblCourseName" runat="server"></asp:Label>
                    </span>
                </div>

                <h1 style="color: #1E1B4B; font-size: 2.2rem; font-weight: 800; margin: 0 0 10px 0; letter-spacing: -0.02em;">
                    <asp:Label ID="lblQuizTitle" runat="server"></asp:Label>
                </h1>
                <p style="color: #475569; font-size: 1rem; margin: 0 0 20px 0; line-height: 1.6;">
                    <asp:Label ID="lblQuizDescription" runat="server"></asp:Label>
                </p>

                <!-- Passing condition notice -->
                <div style="display: inline-flex; align-items: center; gap: 8px; padding: 6px 14px; background: #FAF9FF; border: 1px solid #EDE9FE; border-radius: 8px; font-size: 0.85rem; color: #475569; font-weight: 600;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#6C5CE7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                    Passing Score Requirement: <strong style="color: #6C5CE7;"><asp:Label ID="lblPassingRequirement" runat="server">70%</asp:Label></strong>
                </div>
            </div>

            <!-- Result Box (Hidden until submitted) -->
            <asp:Panel ID="pnlResult" runat="server" Visible="false" style="margin-bottom: 28px; padding: 32px; border-radius: 20px; text-align: center; box-shadow: var(--shadow-md);">
                <div id="divResultIcon" runat="server" style="width: 60px; height: 60px; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; font-size: 1.8rem; margin-bottom: 14px;">
                </div>
                <h2 id="hResultHeading" runat="server" style="font-size: 1.8rem; font-weight: 800; margin: 0 0 8px 0;"></h2>
                <p id="pResultSub" runat="server" style="font-size: 1.05rem; margin: 0 0 20px 0;"></p>
                <div style="display: inline-flex; gap: 14px;">
                    <a id="lnkRetake" runat="server" class="btn-primary" style="padding: 10px 24px; border-radius: 8px; text-decoration: none; font-size: 0.9rem;">Try Again</a>
                    <a href="Dashboard.aspx" class="btn-secondary" style="padding: 10px 24px; border-radius: 8px; text-decoration: none; font-size: 0.9rem;">View Dashboard</a>
                </div>
            </asp:Panel>

            <!-- Quiz Questions Form -->
            <asp:Panel ID="pnlQuizForm" runat="server">
                <asp:Repeater ID="rptQuestions" runat="server" OnItemDataBound="rptQuestions_ItemDataBound">
                    <ItemTemplate>
                        <div class="feature-card" style="background: #FFFFFF; border-radius: 16px; border: 1px solid var(--border); box-shadow: var(--shadow-sm); padding: 28px; margin-bottom: 20px;">
                            
                            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 14px;">
                                <span style="background: var(--gradient-primary); color: white; width: 28px; height: 28px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.82rem; flex-shrink: 0;">
                                    <%# Eval("OrderIndex") %>
                                </span>
                                <h3 style="font-size: 1.1rem; font-weight: 700; color: #1E1B4B; margin: 0;">
                                    <%# Eval("QuestionText") %>
                                </h3>
                            </div>

                            <asp:HiddenField ID="hfQuestionId" runat="server" Value='<%# Eval("Id") %>' />
                            <asp:HiddenField ID="hfCorrectOption" runat="server" Value='<%# Eval("CorrectOption") %>' />

                            <!-- Multiple Choice Radio Buttons -->
                            <div style="display: flex; flex-direction: column; gap: 10px; margin-top: 16px;">
                                <asp:RadioButtonList ID="rblOptions" runat="server" RepeatLayout="UnorderedList" CssClass="quiz-radio-list">
                                    <asp:ListItem Value="A"></asp:ListItem>
                                    <asp:ListItem Value="B"></asp:ListItem>
                                    <asp:ListItem Value="C"></asp:ListItem>
                                    <asp:ListItem Value="D"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <!-- Submit Button -->
                <div style="text-align: right; margin-top: 28px;">
                    <asp:Button ID="btnSubmitQuiz" runat="server" Text="Submit Assessment &rarr;" OnClick="btnSubmitQuiz_Click"
                        style="padding: 14px 38px; background: linear-gradient(135deg, #6C5CE7 0%, #A855F7 100%); color: #FFFFFF; border: none; border-radius: 12px; font-weight: 800; font-size: 1rem; cursor: pointer; box-shadow: 0 8px 24px rgba(108, 92, 231, 0.35); font-family: inherit;" />
                </div>
            </asp:Panel>

        </div>
    </div>

    <!-- Custom Styling for Quiz Choices -->
    <style>
        .quiz-radio-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .quiz-radio-list li {
            background: #FAFAFA;
            border: 1.5px solid #EDE9FE;
            border-radius: 10px;
            padding: 12px 18px;
            display: flex;
            align-items: center;
            transition: all 0.2s ease;
            cursor: pointer;
        }
        .quiz-radio-list li:hover {
            background: #F5F3FF;
            border-color: #C4B5FD;
        }
        .quiz-radio-list li input[type="radio"] {
            margin-right: 12px;
            accent-color: #6C5CE7;
            transform: scale(1.2);
            cursor: pointer;
        }
        .quiz-radio-list li label {
            color: #1E1B4B;
            font-size: 0.95rem;
            font-weight: 500;
            cursor: pointer;
            width: 100%;
        }
    </style>
</asp:Content>
