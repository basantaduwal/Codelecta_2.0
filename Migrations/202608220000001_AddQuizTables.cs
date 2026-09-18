namespace Codelecta_2._0.Migrations
{
    using System.Data.Entity.Migrations;

    public partial class AddQuizTables : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Quizzes",
                c => new
                {
                    Id = c.Int(nullable: false, identity: true),
                    CourseId = c.Int(nullable: false),
                    Title = c.String(nullable: false, maxLength: 200),
                    PassingScorePercent = c.Int(nullable: false),
                    CreatedDate = c.DateTime(nullable: false),
                })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Courses", t => t.CourseId, cascadeDelete: true)
                .Index(t => t.CourseId);

            CreateTable(
                "dbo.QuizQuestions",
                c => new
                {
                    Id = c.Int(nullable: false, identity: true),
                    QuizId = c.Int(nullable: false),
                    QuestionText = c.String(nullable: false),
                    OptionA = c.String(nullable: false, maxLength: 500),
                    OptionB = c.String(nullable: false, maxLength: 500),
                    OptionC = c.String(nullable: false, maxLength: 500),
                    OptionD = c.String(nullable: false, maxLength: 500),
                    CorrectOption = c.String(nullable: false, maxLength: 1),
                    Explanation = c.String(maxLength: 1000),
                    OrderIndex = c.Int(nullable: false),
                })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Quizzes", t => t.QuizId, cascadeDelete: true)
                .Index(t => t.QuizId);

            CreateTable(
                "dbo.QuizAttempts",
                c => new
                {
                    Id = c.Int(nullable: false, identity: true),
                    QuizId = c.Int(nullable: false),
                    UserId = c.String(nullable: false, maxLength: 128),
                    TotalQuestions = c.Int(nullable: false),
                    CorrectAnswers = c.Int(nullable: false),
                    ScorePercent = c.Int(nullable: false),
                    Passed = c.Boolean(nullable: false),
                    AttemptDate = c.DateTime(nullable: false),
                })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Quizzes", t => t.QuizId, cascadeDelete: false)
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: false)
                .Index(t => t.QuizId)
                .Index(t => t.UserId);
        }

        public override void Down()
        {
            DropForeignKey("dbo.QuizAttempts", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.QuizAttempts", "QuizId", "dbo.Quizzes");
            DropForeignKey("dbo.QuizQuestions", "QuizId", "dbo.Quizzes");
            DropForeignKey("dbo.Quizzes", "CourseId", "dbo.Courses");
            DropIndex("dbo.QuizAttempts", new[] { "UserId" });
            DropIndex("dbo.QuizAttempts", new[] { "QuizId" });
            DropIndex("dbo.QuizQuestions", new[] { "QuizId" });
            DropIndex("dbo.Quizzes", new[] { "CourseId" });
            DropTable("dbo.QuizAttempts");
            DropTable("dbo.QuizQuestions");
            DropTable("dbo.Quizzes");
        }
    }
}
