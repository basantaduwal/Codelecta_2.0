using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Codelecta_2._0.Models
{
    // Represents a Student's enrollment in a Course
    public class UserCourse
    {
        [Key]
        public int Id { get; set; }

        public DateTime EnrollmentDate { get; set; } = DateTime.Now;

        // Connect to ApplicationUser (Student)
        [Required]
        public string UserId { get; set; }
        [ForeignKey("UserId")]
        public virtual ApplicationUser User { get; set; }

        // Connect to Course
        public int CourseId { get; set; }
        [ForeignKey("CourseId")]
        public virtual Course Course { get; set; }
    }
}
