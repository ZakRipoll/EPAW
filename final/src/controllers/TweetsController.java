package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.BeanTweet;

/**
 * Servlet implementation class TweetsController
 */
@WebServlet("/TweetsController")
public class TweetsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TweetsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("TweetsController.");
		
		BeanTweet beanTweet = new BeanTweet();
		
		if(request.getParameter("introduce") != null)
		{			
			beanTweet.insertORdeletTweet( 
					(String) request.getParameter("user"), 
					request.getParameter("data"), 
					"TRUE".equals( request.getParameter("introduce").toUpperCase() ) );
		}
		else
		{
			RequestDispatcher dispatcher;
			
	    	request.setAttribute("tweets", beanTweet.listTweets( (String) request.getParameter("user"), 
	    			"profile".equals( (String) request.getParameter("profile") ),  
	    			(String) request.getSession().getAttribute("user")) );
	    	
	    	request.setAttribute("profile", (String) request.getParameter("profile"));
	    	
	    	String write = "no";
	    	
	    	if( ( request.getSession().getAttribute("user") != null ) &&
	    			( (String) request.getSession().getAttribute("user") ).equals( (String) request.getParameter("user") ) ) 
	    		
	    		write =  "yes";
	    	
	    	request.setAttribute("write", write);
	    		
	    	dispatcher = request.getRequestDispatcher( "ShowTweets.jsp" );
	    	
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
