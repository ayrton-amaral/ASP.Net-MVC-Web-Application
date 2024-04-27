using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using SMTIStudent_ProjectManagement.Models;

namespace SMTIStudent_ProjectManagement.Controllers
{
    [Authorize]
    public class ProjectAssignmentsController : Controller
    {
        private Entities1 db = new Entities1();

        // GET: ProjectAssignments
        public ActionResult Index()
        {
            var emptyUser = new User();
            List<User> students = new List<User>();
            students.Add(emptyUser);
            students.AddRange(db.Users.Where(s => s.UserType == "Student").ToList());
            ViewBag.studentId = new SelectList(students, "UserId", "FirstName");

            var emptyProject = new Project();
            List<Project> projects = new List<Project>();
            projects.Add(emptyProject);
            projects.AddRange(db.Projects.ToList());
            ViewBag.projectId = new SelectList(projects, "ProjectId", "ProjectTitle");
            
            var projectAssignments = db.ProjectAssignments.Include(p => p.Project).Include(p => p.User);
            
            return View(projectAssignments.ToList());
        }

        // GET: ProjectAssignments/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            ProjectAssignment projectAssignment = db.ProjectAssignments.Find(id);

            if (projectAssignment == null)
            {
                return HttpNotFound();
            }
            return View(projectAssignment);
        }

        // GET: ProjectAssignments/Create
        public ActionResult Create()
        {
            var students = db.Users.Where(s => s.UserType == "Student");
            ViewBag.StudentId = new SelectList(students, "UserId", "FirstName");

            ViewBag.ProjectId = new SelectList(db.Projects, "ProjectId", "ProjectTitle");

            return View();
        }

        // POST: ProjectAssignments/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ProjectAssignmentId,StudentId,ProjectId,SubmittedDate")] ProjectAssignment projectAssignment)
        {
            var existingAssignment = db.ProjectAssignments.FirstOrDefault(pa => pa.StudentId == projectAssignment.StudentId && pa.ProjectId == projectAssignment.ProjectId);

            if (ModelState.IsValid && existingAssignment == null)
            {
                var projectsAssignedCount = db.ProjectAssignments.Count(pa => pa.StudentId == projectAssignment.StudentId);
                if (projectsAssignedCount < 3)
                {
                    db.ProjectAssignments.Add(projectAssignment);
                    db.SaveChanges();

                    return RedirectToAction("Index");
                }
                else
                {
                    ModelState.AddModelError("StudentId", "Students cannot be assigned to more than 3 projects at the same time.");
                }
            }
            else
            {
                ModelState.AddModelError("ProjectId", "Student is already assigned to this project.");
            }

            var students = db.Users.Where(s => s.UserType == "Student");
            ViewBag.StudentId = new SelectList(students, "UserId", "FirstName");

            ViewBag.ProjectId = new SelectList(db.Projects, "ProjectId", "ProjectTitle");

            return View(projectAssignment);
        }

        // GET: ProjectAssignments/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            ProjectAssignment projectAssignment = db.ProjectAssignments.Find(id);

            if (projectAssignment == null)
            {
                return HttpNotFound();
            }

            var students = db.Users.Where(s => s.UserType == "Student");
            ViewBag.StudentId = new SelectList(students, "UserId", "FirstName");

            ViewBag.ProjectId = new SelectList(db.Projects, "ProjectId", "ProjectTitle");

            return View(projectAssignment);
        }

        // POST: ProjectAssignments/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ProjectAssignmentId,StudentId,ProjectId,SubmittedDate")] ProjectAssignment projectAssignment)
        {
            if (ModelState.IsValid)
            {
                db.Entry(projectAssignment).State = EntityState.Modified;
                db.SaveChanges();

                return RedirectToAction("Index");
            }

            var students = db.Users.Where(s => s.UserType == "Student");
            ViewBag.StudentId = new SelectList(students, "UserId", "FirstName");

            ViewBag.ProjectId = new SelectList(db.Projects, "ProjectId", "ProjectTitle");

            // Return with the fields previously populated by the user inputs
            return View(projectAssignment);
        }

        // GET: ProjectAssignments/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            ProjectAssignment projectAssignment = db.ProjectAssignments.Find(id);

            if (projectAssignment == null)
            {
                return HttpNotFound();
            }

            return View(projectAssignment);
        }

        // POST: ProjectAssignments/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ProjectAssignment projectAssignment = db.ProjectAssignments.Find(id);

            db.ProjectAssignments.Remove(projectAssignment);
            db.SaveChanges();

            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }

            base.Dispose(disposing);
        }


        public ActionResult Search(int? studentId, int? projectId)
        {
            var emptyUser = new User();
            List<User> students = new List<User>();
            students.Add(emptyUser);
            students.AddRange(db.Users.Where(s => s.UserType == "Student").ToList());
            ViewBag.studentId = new SelectList(students, "UserId", "FirstName");

            var emptyProject = new Project();
            List<Project> projects = new List<Project>();
            projects.Add(emptyProject);
            projects.AddRange(db.Projects.ToList());
            ViewBag.projectId = new SelectList(projects, "ProjectId", "ProjectTitle");

            // Table ProjectAssignments joining with Projects and with Users
            var projectAssignments = db.ProjectAssignments.Include(p => p.Project).Include(p => p.User);
            
            if (studentId == 0 && projectId == 0)
            {
                return View("Index", projectAssignments.ToList());
            }

            if(studentId != 0 && projectId != 0)
            {
                // studentId AND projectId
                var searchBy = projectAssignments.Where(u => u.StudentId == studentId).Where(u => u.ProjectId == projectId);

                return View("Index", searchBy.ToList());
            }

            if(studentId != 0)
            {
                var searchByStudent = projectAssignments.Where(u => u.StudentId == studentId);
                
                return View("Index", searchByStudent.ToList());
            }
            
            if(projectId != 0)
            {
                var searchByProject = projectAssignments.Where(u => u.ProjectId == projectId);

                return View("Index", searchByProject.ToList());
            }

            return View("Index");
        }
    }
}
