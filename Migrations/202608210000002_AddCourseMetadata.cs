namespace Codelecta_2._0.Migrations
{
    using System.Data.Entity.Migrations;

    public partial class AddCourseMetadata : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Courses", "Level",      c => c.String(maxLength: 50));
            AddColumn("dbo.Courses", "ImageTag",   c => c.String(maxLength: 20));
            AddColumn("dbo.Courses", "BadgeClass", c => c.String(maxLength: 50));
        }

        public override void Down()
        {
            DropColumn("dbo.Courses", "BadgeClass");
            DropColumn("dbo.Courses", "ImageTag");
            DropColumn("dbo.Courses", "Level");
        }
    }
}
