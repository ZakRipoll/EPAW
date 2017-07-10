package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.BeanUser;

/**
 * Servlet implementation class IsAdminController
 */
@WebServlet("/IsAdmin")
public class IsAdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IsAdminController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		BeanUser users = new BeanUser();
		
		if(request.getParameter("type") != null)
		{
	    	if ( users.deleteUser( (String) request.getParameter("user") ) )
				response.sendError(HttpServletResponse.SC_OK);
			else
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
		else if( request.getParameter("user") != null )
		{ 
	    	if ( users.chekAdmin( (String) request.getParameter("user") ) )
				response.sendError(HttpServletResponse.SC_OK);
			else
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
		else if( request.getParameter("admin") != null )
		{
			RequestDispatcher dispatcher;
			
			HttpSession session = request.getSession();
			
	    	request.setAttribute( "information", users.listUsers( (String) request.getParameter("admin") ) );
		
	    	dispatcher = request.getRequestDispatcher( "Admin.jsp" );
	    	
	    	dispatcher.forward(request, response);
	    	
	    	session.setAttribute("admin", (String) request.getParameter("admin"));
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
