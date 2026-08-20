<%@ Page Title="View Lesson" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewLesson.aspx.cs" Inherits="Codelecta_2._0.ViewLesson" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container section-padding">
        <a id="lnkBack" runat="server" style="color: var(--primary-light); text-decoration: none; font-size: 0.95rem;">&larr; Back to Course</a>

        <!-- Lesson Content -->
        <div class="feature-card" style="margin-top: 20px; padding: 40px; max-width: 900px; margin-left: auto; margin-right: auto;">
            <div style="display: flex; align-items: center; gap: 15px; margin-bottom: 30px;">
                <span style="background: var(--gradient-primary); color: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 1rem; flex-shrink: 0;">
                    <asp:Label ID="lblOrder" runat="server"></asp:Label>
                </span>
                <h2 style="color: var(--text-primary); font-size: 1.8rem; margin: 0;">
                    <asp:Label ID="lblTitle" runat="server"></asp:Label>
                </h2>
            </div>

            <!-- Video Embed (if available) -->
            <asp:Panel ID="pnlVideo" runat="server" Visible="false" style="margin-bottom: 30px;">
                <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: var(--radius-md);">
                    <iframe id="videoFrame" runat="server" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none; border-radius: var(--radius-md);" allowfullscreen="true"></iframe>
                </div>
            </asp:Panel>

            <!-- Lesson Text Content -->
            <div style="color: var(--text-secondary); font-size: 1.05rem; line-height: 1.8;">
                <asp:Literal ID="litContent" runat="server"></asp:Literal>
            </div>

            <!-- Mark Complete / Navigation -->
            <div style="margin-top: 40px; padding-top: 24px; border-top: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px;">
                <asp:Label ID="lblCompleted" runat="server" Visible="false"
                    style="color: var(--success); font-weight: 600; font-size: 0.95rem;">&#10003; Completed</asp:Label>
                <asp:Button ID="btnMarkComplete" runat="server" Text="Mark as Complete" CssClass="btn-primary" OnClick="btnMarkComplete_Click" />
                <asp:HyperLink ID="lnkNextLesson" runat="server" CssClass="btn-secondary" style="padding: 10px 24px; text-decoration: none;">
                    Next Lesson &rarr;
                </asp:HyperLink>
            </div>
        </div>
    </div>
</asp:Content>
