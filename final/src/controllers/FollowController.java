package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.BeanFollow;

/**
 * Servlet implementation class FollowController
 */
@WebServlet("/FollowController")
public class FollowController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FollowController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("FollowController.");
		
		BeanFollow beanFollow = new BeanFollow();
		
		if(request.getParameter("insert") != null){
			
			if( "false".equals( (String) request.getParameter("insert") ) ){
				
				if( beanFollow.insertFollow( (String) request.getSession().getAttribute("user"), request.getParameter("user") ) )
					response.sendError(HttpServletResponse.SC_OK);
				else
					response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
			else
			{
				if( beanFollow.deleteFollow( (String) request.getSession().getAttribute("user"), request.getParameter("user") ) )
					response.sendError(HttpServletResponse.SC_OK);
				else
					response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
		}
		else {
			
			RequestDispatcher dispatcher;
			
			String dispatch;
			
	    	request.setAttribute( "follow", beanFollow.listFollow( (String) request.getSession().getAttribute("user"), 
	    			"true".equals( request.getParameter( "friend" ).toLowerCase() ) ) );
	    	
			HttpSession session = request.getSession();
			
			session.setAttribute("friends", request.getParameter( "friend" ).toLowerCase() );
	    	
	    	dispatch = "ShowFollow.jsp";
		
	    	dispatcher = request.getRequestDispatcher( dispatch );
	    	
	    	dispatcher.forward(request, response);
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
