using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Codelecta_2._0.Models
{
    public class Lesson
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(200)]
        public string Title { get; set; }

        public string Content { get; set; } // Could be HTML, Text, or Video URL

        public int OrderIndex { get; set; }

        // Connect to Course
        public int CourseId { get; set; }
        [ForeignKey("CourseId")]
        public virtual Course Course { get; set; }

        // Navigation property
        public virtual ICollection<LessonProgress> Progresses { get; set; }
    }
}
