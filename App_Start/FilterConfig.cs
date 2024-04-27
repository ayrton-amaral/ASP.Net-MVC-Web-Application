using System.Web;
using System.Web.Mvc;

namespace SMTIStudent_ProjectManagement
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
