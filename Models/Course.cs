using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Codelecta_2._0.Models
{
    public class Course
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(200)]
        public string Title { get; set; }

        public string Description { get; set; }

        /// <summary>Beginner | Intermediate | Professional</summary>
        [StringLength(50)]
        public string Level { get; set; }

        /// <summary>Short tag shown on the card badge, e.g. "Py", "JS", "C#"</summary>
        [StringLength(20)]
        public string ImageTag { get; set; }

        /// <summary>CSS class applied to the badge for colour, e.g. "python-badge"</summary>
        [StringLength(50)]
        public string BadgeClass { get; set; }

        public DateTime CreatedDate { get; set; } = DateTime.Now;

        // Connect to existing ApplicationUser as the Instructor
        public string InstructorId { get; set; }
        [ForeignKey("InstructorId")]
        public virtual ApplicationUser Instructor { get; set; }

        // Navigation properties
        public virtual ICollection<Lesson> Lessons { get; set; }
        public virtual ICollection<UserCourse> Enrollments { get; set; }
        public virtual ICollection<Quiz> Quizzes { get; set; }
    }
}
