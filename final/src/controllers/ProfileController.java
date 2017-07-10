package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import models.BeanUser;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/ProfileController")
public class ProfileController extends HttpServlet {
  private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileController() {
        super();
        // TODO Auto-generated constructor stub
    }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    String username = (String) request.getSession().getAttribute("user");
      BeanUser user = new BeanUser();
      user = user.getUsuari(username);
      request.setAttribute( "usuari", user );
      RequestDispatcher dispatcher = request.getRequestDispatcher( "ViewProfile.jsp" );
      dispatcher.forward(request, response);
    
    try {
      BeanUtils.populate(user, request.getParameterMap());
      DAO dao;
      try {
        dao = new DAO();
        String query2="UPDATE users SET name='"+user.getName()+"', middleName='"+user.getMiddleName()
        +"', lastName='"+user.getLastName()+"', mail='"+user.getMail()+"', password='"+user.getPassword()
        +"', profilePicture='"+user.getProfilePicture()+"' WHERE user = '"+user.getUser()+"'";
         int result = dao.executeInsert(query2);
      } catch (Exception e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }
        
    } catch (IllegalAccessException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } catch (InvocationTargetException e) {
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