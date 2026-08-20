using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Codelecta_2._0.Models
{
    // Tracks a student's progress on a specific lesson
    public class LessonProgress
    {
        [Key]
        public int Id { get; set; }

        public bool IsCompleted { get; set; }
        
        public DateTime? CompletedDate { get; set; }

        // Connect to ApplicationUser (Student)
        [Required]
        public string UserId { get; set; }
        [ForeignKey("UserId")]
        public virtual ApplicationUser User { get; set; }

        // Connect to Lesson
        public int LessonId { get; set; }
        [ForeignKey("LessonId")]
        public virtual Lesson Lesson { get; set; }
    }
}
