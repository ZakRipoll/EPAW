package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

import com.mysql.jdbc.ResultSet;

import database.Database;
import models.BeanUser;

/**
 * Servlet implementation class FormController
 */
@WebServlet("/FormController")
public class FormController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public FormController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	   RequestDispatcher dispatcher = request.getRequestDispatcher("/register.jsp");
	   dispatcher.forward(request, response);

    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		BeanUser user = new BeanUser();

		try {

		   // Fill the bean with the request parmeters
		   BeanUtils.populate(user, request.getParameterMap());
		}
		catch (IllegalAccessException | InvocationTargetException e) {
				e.printStackTrace();
	    }

		String query = "INSERT INTO users VALUES(\""+user.getName()+"\", \""+user.getMiddle_name()+"\", \""
				+user.getLast_name()+"\", \""+user.getUsername()+"\", \""+user.getEmail()+"\", \""
				+user.getPassword()+"\", \""+user.getBirth_date()+"\", \""+user.getProfile_picture()+"\", \""
				+user.getSex()+"\""+");";

		Database d;
		try {
			d = new Database();
			d.insert(query);
			d.disconnectBD();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		consulta(request, response);
	}
	
	void consulta(HttpServletRequest request, HttpServletResponse response){
		try {
			Database prova = new Database();
			
			ResultSet resultSet = (ResultSet) prova.executeSQL("select * from users");
			
			PrintWriter out = response.getWriter();
			
			
			out.println

			(//ServletUtilities.headWithTitle() +

			"<body>\n" +

			"<h1>" + "hola" + "</h1>\n" 
			);
			 while (resultSet.next()) {
				 out.println("<h1>" + resultSet.getString("name") + " " + resultSet.getString("middle_name") + " " + "</h1>");
			 }
                
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
