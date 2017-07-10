package models;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import controllers.DAO;

public class BeanFollow {
	
	private String user = "";
	private String name = "";
	private String middleName = "";
	private String lastName = "";
	private String profilePicture = "";
	
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getProfilePicture() {
		return profilePicture;
	}
	public void setProfilePicture(String profilePicture) {
		this.profilePicture = profilePicture;
	}
	
	public List<BeanFollow> listFollow(String usuari, boolean friends ) {
			
		DAO dao;
		
		try {
			
			List<BeanFollow> llista = new ArrayList<BeanFollow>();
			
			dao = new DAO();
			
			String query = "SELECT user, name, middleName, lastName, profilePicture FROM users WHERE user IN "
					+ "(SELECT user1 FROM follow WHERE user1 ";
			
			if(!friends) query += "NOT ";
			
			query += "IN (SELECT user2 FROM follow WHERE user1 LIKE '" + usuari + "')";
			
			if(friends) query += " AND user1 NOT LIKE '" + usuari + "'";
			
			query += " );";
			
			ResultSet resultats = dao.executeSQL(query);
			
			 while(resultats.next()) {
				 
				 	BeanFollow nou = new BeanFollow();
				 	
				 	nou.setUser(resultats.getString(1));
				 	nou.setName(resultats.getString(2));
				 	nou.setMiddleName(resultats.getString(3));
				 	nou.setLastName(resultats.getString(4));
				 	nou.setProfilePicture(( resultats.getString(5).length() != 0) ? resultats.getString(5) :
				 		"imatges/logo.png");
				 	
				 	llista.add(nou);
			 }
			 
			 dao.disconnectBD();
			 
			 return llista;
			 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return null;
		}
	}

	public boolean insertFollow(String usuari1, String usuari2){
		DAO dao;
		try {
			dao = new DAO();
			   
			String query = "INSERT INTO follow VALUES ('" + usuari1 + "', '" + usuari2 + "');";
			
			int result = dao.executeInsert(query);
			
			dao.disconnectBD();
			
			return result != 0;
			 
		} catch (Exception e) {
			return false;
		}
	}
	
	public boolean deleteFollow(String usuari1, String usuari2){
		DAO dao;
		try {
			dao = new DAO();
			   
			String query = "DELETE FROM follow WHERE user1 LIKE '" + usuari1 + "' AND user2 LIKE '" + usuari2 + "';";
			
			int result = dao.executeInsert(query);
			
			dao.disconnectBD();
			
			return result != 0;
			 
		} catch (Exception e) {
			return false;
		}
	}
}
