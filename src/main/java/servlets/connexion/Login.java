package servlets.connexion;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdministratorDao;
import dao.DAOFactory;
import dao.StudentDao;
import dao.TeacherDao;
import forms.AdministratorForm;
import forms.StudentForm;
import forms.TeacherForm;

@SuppressWarnings("serial")
@WebServlet("/login")
public class Login extends HttpServlet {
    private static final String CONF_DAO_FACTORY      = "daofactory";
    private static final String USER                  = "user";
    private static final String STUDENT_SESSION       = "studentSession";
    private static final String TEACHER_SESSION       = "teacherSession";
    private static final String ADMINISTRATOR_SESSION = "administratorSession";
    private static final String STUDENT_FORM          = "studentForm";
    private static final String VIEW                  = "/WEB-INF/login.xhtml";
    private String           path;
    private AdministratorDao administratorDao;
    private StudentDao       studentDao;
    private TeacherDao       teacherForm;

    public Login() {
        super();
    }

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        this.path = config.getServletContext().getContextPath();
        this.administratorDao = ((DAOFactory) getServletContext().getAttribute(CONF_DAO_FACTORY)).getAdministratorDao();
        this.studentDao = ((DAOFactory) getServletContext().getAttribute(CONF_DAO_FACTORY)).getStudentDao();
        this.teacherForm = ((DAOFactory) getServletContext().getAttribute(CONF_DAO_FACTORY)).getTeacherDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute(ADMINISTRATOR_SESSION) != null) {
            response.sendRedirect(this.path + "/ai/administrator");
        }
        else if (session.getAttribute(TEACHER_SESSION) != null) {
            response.sendRedirect(this.path + "/pi/test");
        }
        else if (session.getAttribute(STUDENT_SESSION) != null) {
            response.sendRedirect(this.path + "/ei/gradebook");
        }
        else {
            this.getServletContext().getRequestDispatcher(VIEW).forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession         session           = request.getSession();
        StudentForm         studentForm       = new StudentForm(this.studentDao);
        TeacherForm         teacherForm       = new TeacherForm(this.teacherForm);
        AdministratorForm   administratorForm = new AdministratorForm(this.administratorDao);
        beans.Student       student           = studentForm.checkLogin(request);
        beans.Teacher       teacher           = teacherForm.checkLogin(request);
        beans.Administrator administrator     = administratorForm.checkLogin(request);

        if (student.getId() != null) {
            session.setAttribute(STUDENT_SESSION, student);
            response.sendRedirect(this.path + "/si/gradebook");
        }
        else if (teacher.getId() != null) {
            session.setAttribute(TEACHER_SESSION, teacher);
            response.sendRedirect(this.path + "/ti/test");
        }
        else if (administrator.getId() != null) {
            session.setAttribute(ADMINISTRATOR_SESSION, administrator);
            response.sendRedirect(this.path + "/ai/administrator");
        }
        else {
            request.setAttribute(USER, student);
            request.setAttribute(STUDENT_FORM, studentForm);
            this.getServletContext().getRequestDispatcher(VIEW).forward(request, response);
        }

    }

}