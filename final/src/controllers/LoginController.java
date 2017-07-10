package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import models.BeanLogin;
import models.BeanUserLogged;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("LoginController.");
		
		RequestDispatcher dispatcher;
		
		String dispatch;
		
		BeanLogin login = new BeanLogin();
		
	    try {
			
	    	BeanUtils.populate(login, request.getParameterMap());
	    	
	    	HttpSession session = request.getSession();
	    	
	    	System.out.println(request.getSession().getAttribute("user"));
	    	
	    	if( session.getAttribute("user") != null)
	    	{
	    		BeanUserLogged beanUserLogged = new BeanUserLogged();
	    		
	    		request.setAttribute("information", beanUserLogged.user( (String) request.getParameter("user"), 
	    				(String) session.getAttribute("user") ) );
		    	
	    		dispatch = "ViewLoginDone.jsp";
	    	}
	    	else if (login.isComplete()) 
	    	{    	    
		    	session.setAttribute("user",login.getUser());
		    	dispatch = "LogOk.jsp";
		    } 
			else
			    dispatch = "ViewLoginForm.jsp";

	    	dispatcher = request.getRequestDispatcher( dispatch );
	    	dispatcher.forward(request, response);
	    	
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
