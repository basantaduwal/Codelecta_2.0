namespace Codelecta_2._0.Migrations
{
    using System;
    using System.Data.Entity.Migrations;

    public partial class AddOnboarding : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.AspNetUsers", "ExperienceLevel", c => c.String(maxLength: 50));
            AddColumn("dbo.AspNetUsers", "OnboardingCompleted", c => c.Boolean(nullable: false, defaultValue: false));
        }

        public override void Down()
        {
            DropColumn("dbo.AspNetUsers", "OnboardingCompleted");
            DropColumn("dbo.AspNetUsers", "ExperienceLevel");
        }
    }
}
