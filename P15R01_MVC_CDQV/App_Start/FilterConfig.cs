using System.Web;
using System.Web.Mvc;

namespace P15R01_MVC_CDQV
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
