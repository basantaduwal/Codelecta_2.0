using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Codelecta_2._0.Models;

namespace Codelecta_2._0
{
    public partial class Leaderboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLeaderboard();
            }
        }

        private void LoadLeaderboard()
        {
            using (var db = new ApplicationDbContext())
            {
                // Overall stats
                int totalAttempts = db.QuizAttempts.Count();
                int totalLearners = db.QuizAttempts.Select(a => a.UserId).Distinct().Count();
                double globalAvg = totalAttempts > 0
                    ? db.QuizAttempts.Average(a => (double)a.ScorePercent)
                    : 0;

                lblTotalLearners.Text  = totalLearners.ToString();
                lblTotalAttempts.Text  = totalAttempts.ToString();
                lblAvgScore.Text       = Math.Round(globalAvg, 0) + "%";

                if (totalAttempts == 0)
                {
                    pnlLeaderboard.Visible = false;
                    pnlEmpty.Visible       = true;
                    pnlYourRank.Visible    = false;
                    return;
                }

                // Build leaderboard rows — group by user, rank by avg score desc, then passes desc
                var grouped = db.QuizAttempts
                    .GroupBy(a => a.UserId)
                    .Select(g => new
                    {
                        UserId       = g.Key,
                        TotalAttempts = g.Count(),
                        PassedCount  = g.Count(a => a.IsPassed),
                        AvgScore     = (int)Math.Round(g.Average(a => (double)a.ScorePercent)),
                        BestScore    = g.Max(a => a.ScorePercent)
                    })
                    .OrderByDescending(x => x.AvgScore)
                    .ThenByDescending(x => x.PassedCount)
                    .ThenByDescending(x => x.BestScore)
                    .Take(10)
                    .ToList();

                // Load user display names / levels
                var userIds = grouped.Select(x => x.UserId).ToList();
                var users   = db.Users
                    .Where(u => userIds.Contains(u.Id))
                    .Select(u => new { u.Id, u.UserName, u.FullName, ExperienceLevel = u.ExperienceLevel ?? "Beginner" })
                    .ToList()
                    .ToDictionary(u => u.Id);

                int rank = 1;
                var rows = grouped.Select(x =>
                {
                    string displayName = x.UserId;
                    string level       = "Beginner";
                    if (users.ContainsKey(x.UserId))
                    {
                        var u = users[x.UserId];
                        displayName = !string.IsNullOrWhiteSpace(u.FullName) ? u.FullName
                                    : (!string.IsNullOrEmpty(u.UserName) && u.UserName.Contains("@") ? u.UserName.Split('@')[0] : u.UserName);
                        level = u.ExperienceLevel;
                    }
                    return new LeaderboardRow
                    {
                        Rank          = rank++,
                        UserId        = x.UserId,
                        DisplayName   = displayName,
                        ExperienceLevel = level,
                        TotalAttempts = x.TotalAttempts,
                        PassedCount   = x.PassedCount,
                        AvgScore      = x.AvgScore,
                        BestScore     = x.BestScore
                    };
                }).ToList();

                rptLeaderboard.DataSource = rows;
                rptLeaderboard.DataBind();
                pnlLeaderboard.Visible = true;
                pnlEmpty.Visible       = false;

                // Current user's rank
                if (User.Identity.IsAuthenticated)
                {
                    string currentUserId = User.Identity.GetUserId();

                    // Find in top 10 first
                    var myRow = rows.FirstOrDefault(r => r.UserId == currentUserId);

                    // If not in top 10, compute their actual rank from full dataset
                    if (myRow == null)
                    {
                        var allGrouped = db.QuizAttempts
                            .GroupBy(a => a.UserId)
                            .Select(g => new
                            {
                                UserId   = g.Key,
                                AvgScore = (int)Math.Round(g.Average(a => (double)a.ScorePercent)),
                                PassedCount = g.Count(a => a.IsPassed),
                                BestScore = g.Max(a => a.ScorePercent),
                                TotalAttempts = g.Count()
                            })
                            .OrderByDescending(x => x.AvgScore)
                            .ThenByDescending(x => x.PassedCount)
                            .ThenByDescending(x => x.BestScore)
                            .ToList();

                        var myData = allGrouped.FirstOrDefault(x => x.UserId == currentUserId);
                        if (myData != null)
                        {
                            int fullRank = allGrouped.IndexOf(myData) + 1;
                            lblYourRank.Text       = "#" + fullRank + " of " + allGrouped.Count;
                            lblYourBestScore.Text  = myData.BestScore + "%";
                            lblYourAvgScore.Text   = myData.AvgScore + "%";
                            lblYourAttempts.Text   = myData.TotalAttempts.ToString();
                            pnlYourRank.Visible    = true;
                        }
                    }
                    else
                    {
                        lblYourRank.Text       = "#" + myRow.Rank + " of " + totalLearners;
                        lblYourBestScore.Text  = myRow.BestScore + "%";
                        lblYourAvgScore.Text   = myRow.AvgScore + "%";
                        lblYourAttempts.Text   = myRow.TotalAttempts.ToString();
                        pnlYourRank.Visible    = true;
                    }
                }
            }
        }

        // ─── Helper methods called from ASPX markup ─────────────────────────────

        protected string GetRankBadge(int rank)
        {
            switch (rank)
            {
                case 1: return "<span style=\"display:inline-flex;align-items:center;justify-content:center;width:34px;height:34px;border-radius:50%;background:linear-gradient(135deg,#F59E0B,#FBBF24);color:white;font-weight:900;font-size:1.1rem;\">🥇</span>";
                case 2: return "<span style=\"display:inline-flex;align-items:center;justify-content:center;width:34px;height:34px;border-radius:50%;background:linear-gradient(135deg,#94A3B8,#CBD5E1);color:white;font-weight:900;font-size:1.1rem;\">🥈</span>";
                case 3: return "<span style=\"display:inline-flex;align-items:center;justify-content:center;width:34px;height:34px;border-radius:50%;background:linear-gradient(135deg,#CD7C3A,#D97706);color:white;font-weight:900;font-size:1.1rem;\">🥉</span>";
                default: return "<span style=\"display:inline-flex;align-items:center;justify-content:center;width:34px;height:34px;border-radius:50%;background:#F3F0FF;color:#6C5CE7;font-weight:800;font-size:0.9rem;\">#" + rank + "</span>";
            }
        }

        protected string GetInitial(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) return "?";
            return name.Trim().Substring(0, 1).ToUpper();
        }

        protected string GetAvatarColor(int index)
        {
            var colors = new[]
            {
                "linear-gradient(135deg,#6C5CE7,#A855F7)",
                "linear-gradient(135deg,#0EA5E9,#38BDF8)",
                "linear-gradient(135deg,#10B981,#34D399)",
                "linear-gradient(135deg,#F59E0B,#FBBF24)",
                "linear-gradient(135deg,#EF4444,#F87171)",
                "linear-gradient(135deg,#8B5CF6,#C084FC)",
                "linear-gradient(135deg,#EC4899,#F472B6)",
                "linear-gradient(135deg,#14B8A6,#2DD4BF)",
                "linear-gradient(135deg,#F97316,#FB923C)",
                "linear-gradient(135deg,#6366F1,#818CF8)"
            };
            return colors[index % colors.Length];
        }
    }

    public class LeaderboardRow
    {
        public int    Rank            { get; set; }
        public string UserId          { get; set; }
        public string DisplayName     { get; set; }
        public string ExperienceLevel { get; set; }
        public int    TotalAttempts   { get; set; }
        public int    PassedCount     { get; set; }
        public int    AvgScore        { get; set; }
        public int    BestScore       { get; set; }
    }
}
