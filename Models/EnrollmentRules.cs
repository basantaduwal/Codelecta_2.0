using System;

namespace Codelecta_2._0.Models
{
    /// <summary>
    /// Static class containing enrollment business rules based on user experience level and course level.
    /// </summary>
    public static class EnrollmentRules
    {
        /// <summary>
        /// Determines if a user with the given experience level can enroll in a course of the given level.
        /// </summary>
        /// <param name="userExperienceLevel">The user's experience level (Beginner, Intermediate, Professional, or null/empty)</param>
        /// <param name="courseLevel">The course's level (Beginner, Intermediate, Professional)</param>
        /// <returns>True if the user can enroll in the course, false otherwise.</returns>
        public static bool CanEnroll(string userExperienceLevel, string courseLevel)
        {
            // If user hasn't set their experience level yet, they cannot enroll
            if (string.IsNullOrEmpty(userExperienceLevel))
                return false;

            // Normalize inputs for comparison
            string userLevel = userExperienceLevel.Trim();
            string courseLvl = courseLevel.Trim();

            // Define the hierarchy: Beginner < Intermediate < Professional
            // Beginner can only take Beginner
            if (userLevel.Equals("Beginner", StringComparison.OrdinalIgnoreCase))
                return courseLvl.Equals("Beginner", StringComparison.OrdinalIgnoreCase);

            // Intermediate can take Beginner and Intermediate
            if (userLevel.Equals("Intermediate", StringComparison.OrdinalIgnoreCase))
                return courseLvl.Equals("Beginner", StringComparison.OrdinalIgnoreCase) ||
                       courseLvl.Equals("Intermediate", StringComparison.OrdinalIgnoreCase);

            // Professional can take any level
            if (userLevel.Equals("Professional", StringComparison.OrdinalIgnoreCase))
                return true;

            // Unknown experience level - deny enrollment
            return false;
        }

        /// <summary>
        /// Gets a user-friendly message explaining why enrollment is not allowed.
        /// </summary>
        /// <param name="userExperienceLevel">The user's experience level (Beginner, Intermediate, Professional, or null/empty)</param>
        /// <param name="courseLevel">The course's level (Beginner, Intermediate, Professional)</param>
        /// <returns>A message explaining the enrollment restriction.</returns>
        public static string GetRestrictionMessage(string userExperienceLevel, string courseLevel)
        {
            // If user hasn't set their experience level yet
            if (string.IsNullOrEmpty(userExperienceLevel))
                return "Please complete your onboarding to set your experience level before enrolling in courses.";

            // Normalize inputs for comparison
            string userLevel = userExperienceLevel.Trim();
            string courseLvl = courseLevel.Trim();

            // Define the hierarchy: Beginner < Intermediate < Professional
            // Beginner can only take Beginner
            if (userLevel.Equals("Beginner", StringComparison.OrdinalIgnoreCase))
            {
                if (!courseLvl.Equals("Beginner", StringComparison.OrdinalIgnoreCase))
                    return "As a Beginner, you can only enroll in Beginner-level courses. This course is " + courseLvl + " level.";
            }
            // Intermediate can take Beginner and Intermediate (not Professional)
            else if (userLevel.Equals("Intermediate", StringComparison.OrdinalIgnoreCase))
            {
                if (courseLvl.Equals("Professional", StringComparison.OrdinalIgnoreCase))
                    return "As an Intermediate learner, you can enroll in Beginner and Intermediate courses. Professional-level courses require Professional experience.";
            }
            // Professional can take any level - this case should not be reached if CanEnroll returned false
            else if (userLevel.Equals("Professional", StringComparison.OrdinalIgnoreCase))
            {
                // This is a fallback - Professionals can enroll in any course
                return "Unable to enroll in this course at this time.";
            }

            // Unknown experience level
            return "Unable to determine eligibility based on your experience level. Please update your profile in your account settings.";
        }
    }
}