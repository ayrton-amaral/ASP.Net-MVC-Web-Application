using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SMTIStudent_ProjectManagement.Models;
using System.Web.Security;

namespace SMTIStudent_ProjectManagement.Controllers
{
    public class AccountsController : Controller
    {
        // GET: Accounts
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(User model)
        {
            using (Entities1 context = new Entities1())
            {
                var loggedUser = context.Users.FirstOrDefault(user => user.UserName.ToLower() == model.UserName.ToLower() && user.Password == model.Password); 
                
                if (loggedUser != null)
                {
                    Session["userTypeLogged"] = loggedUser.UserType;
                    Session["userNameLogged"] = loggedUser.UserName;

                    FormsAuthentication.SetAuthCookie(model.UserName, false);

                    return RedirectToAction("Index", "Home");
                }

                ModelState.AddModelError("", "Invalid UserName or Password."); 
                
                return View();
            }
        }

        public ActionResult Signup()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Signup(User user)
        {
            using (Entities1 context = new Entities1())
            {
                context.Users.Add(user);
                context.SaveChanges();
            }

            return RedirectToAction("Login");
        }

        public ActionResult Logout()
        {
            Session.Clear();

            FormsAuthentication.SignOut();
            
            return RedirectToAction("Login");
        }
    }
}