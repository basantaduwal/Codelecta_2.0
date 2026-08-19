using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Codelecta_2._0.Startup))]
namespace Codelecta_2._0
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
