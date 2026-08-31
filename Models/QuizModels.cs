using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Codelecta_2._0.Models
{
    public class Quiz
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(200)]
        public string Title { get; set; }

        public string Description { get; set; }

        /// <summary>Minimum percentage required to pass (e.g. 70%)</summary>
        public int PassingScorePercent { get; set; } = 70;

        public int CourseId { get; set; }
        [ForeignKey("CourseId")]
        public virtual Course Course { get; set; }

        public DateTime CreatedDate { get; set; } = DateTime.Now;

        // Navigation
        public virtual ICollection<QuizQuestion> Questions { get; set; }
        public virtual ICollection<QuizAttempt> Attempts { get; set; }
    }

    public class QuizQuestion
    {
        [Key]
        public int Id { get; set; }

        public int QuizId { get; set; }
        [ForeignKey("QuizId")]
        public virtual Quiz Quiz { get; set; }

        public int OrderIndex { get; set; }

        [Required]
        public string QuestionText { get; set; }

        [Required]
        [StringLength(250)]
        public string OptionA { get; set; }

        [Required]
        [StringLength(250)]
        public string OptionB { get; set; }

        [Required]
        [StringLength(250)]
        public string OptionC { get; set; }

        [Required]
        [StringLength(250)]
        public string OptionD { get; set; }

        /// <summary>Correct option key: "A", "B", "C", or "D"</summary>
        [Required]
        [StringLength(5)]
        public string CorrectOption { get; set; }

        public string Explanation { get; set; }
    }

    public class QuizAttempt
    {
        [Key]
        public int Id { get; set; }

        public int QuizId { get; set; }
        [ForeignKey("QuizId")]
        public virtual Quiz Quiz { get; set; }

        [Required]
        public string UserId { get; set; }
        [ForeignKey("UserId")]
        public virtual ApplicationUser User { get; set; }

        public int TotalQuestions { get; set; }

        public int CorrectAnswers { get; set; }

        public int ScorePercent { get; set; }

        public bool IsPassed { get; set; }

        public DateTime AttemptDate { get; set; } = DateTime.Now;
    }
}
