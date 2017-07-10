package models;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import controllers.DAO;

//import controllers.DAO;
public class BeanUser implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	
	private String user = "";
	private String mail = "";
	private String name = "";
	private String middleName = "";
	private String lastName = "";
	private String password = "";
	private String confirmationPassword = "";
	private String birthdate = "";
	private String profilePicture = "";

	
	public String getProfilePicture() {
		return profilePicture;
	}

	public void setProfilePicture(String profilePicture) {
		this.profilePicture = profilePicture;
	}

	/*  Control which parameters have been correctly filled */
	private int[] error = {0,0}; 
	
	/* Getters */
	public String getUser(){
		return user;
	}
	
	public String getMail() {
		return mail;
	}
	
	public String getName() {
		return name;
	}

	public String getMiddleName() {
		return middleName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getPassword() {
		return password;
	}

	public String getConfirmationPassword() {
		return confirmationPassword;
	}
	
	public String getBirthdate() {
		return birthdate;
	}
	
	public int[] getError() {
		return error;
	}
	
	/*Setters*/
	public void setUser(String user){
		this.user = user;
	}
	
	public void setMail(String mail){
		this.mail = mail;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setConfirmationPassword(String confirmationPassword) {
		this.confirmationPassword = confirmationPassword;
	}
	
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}
	
	public void setData(Timestamp data) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date date = data;
		this.birthdate = dateFormat.format(date);
	}

	public void setError(int pos, int error) {
		//En la primera posicin va el error del user, 
		// en la segunda el error del mail
		this.error[pos] = error;
	}
	
	public void checkMail(String mail){
		try {
			DAO dao = new DAO();
			ResultSet f = dao.executeSQL("SELECT COUNT(*) FROM users WHERE mail='" + mail + "';");
			f.next(); int i = Integer.parseInt(f.getString(1));
			if(i!=0)setError(1,1); 
			else {
				this.mail = mail;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void checkUser(String user){
		try {
			
			DAO dao = new DAO();
			
			ResultSet f = dao.executeSQL("SELECT COUNT(*) FROM users WHERE user='" + user + "';");
			
			f.next(); 
			
			int i = Integer.parseInt(f.getString(1));
			
			dao.disconnectBD();
			
			if(i!=0)setError(0,1);
			
			else this.user = user;
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	/* Logic Functions */
	public boolean isComplete() {
	    return(hasValue(getUser()) &&
	           hasValue(getMail()) &&
	           hasValue(getName()) &&
	           hasValue(getLastName()) &&
	           hasValue(getPassword()) &&
	           hasValue(getBirthdate())
	           );
	}
	
	private boolean hasValue(String val) {
		return((val != null) && (!val.equals("")));
	}
	
	public List<BeanUser> listUsers(String user) {
		
		DAO dao;
		
		try {
			
			List<BeanUser> llista = new ArrayList<BeanUser>();
			
			dao = new DAO();
			
			String query = "SELECT user, name, middleName, lastName, mail, password, birthdate, profilePicture FROM users"
					+ " WHERE user NOT LIKE '" + user + "';";
			
			ResultSet resultats = dao.executeSQL(query);
			
			 while(resultats.next()) {
				 
				 	BeanUser nou = new BeanUser();
				 	
				 	nou.setUser(resultats.getString(1));
				 	nou.setName(resultats.getString(2));
				 	nou.setMiddleName(resultats.getString(3));
				 	nou.setLastName(resultats.getString(4));
				 	nou.setMail(resultats.getString(5));
				 	nou.setPassword(resultats.getString(6));
				 	nou.setData(resultats.getTimestamp(7));
				 	nou.setProfilePicture(( resultats.getString(8).length() != 0) ? resultats.getString(8) :
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

	public boolean deleteUser(String user) {
		DAO dao;
		try {
			dao = new DAO();
			   
			String query = "CALL deleteUser( '" + user + "');";
			
			int result = dao.executeInsert(query);
			
			dao.disconnectBD();
			
			return result !=0;
			 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return false;
		}
		
	}

	public boolean chekAdmin(String parameter) {
		
		DAO dao;
		try {
		
			dao = new DAO();
			
			ResultSet result;
			
			String query = "SELECT * FROM admin WHERE user LIKE '" + parameter + "';";
			
			result = dao.executeSQL(query);
			
			boolean admin = result.isBeforeFirst();
			
			dao.disconnectBD();
					
			return admin ;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return false;
		}
	}
	
	public BeanUser getUsuari(String user){
	    BeanUser nou = new BeanUser();
	    try {
	      DAO dao = new DAO();
	      String query = "SELECT user, name, middleName, lastName, mail, password, birthdate, profilePicture FROM users"
	          + " WHERE user LIKE '" + user + "';";
	      ResultSet resultat = dao.executeSQL(query);
	      
	      resultat.next();
	      
	      nou.setUser(resultat.getString(1));
	       nou.setName(resultat.getString(2));
	       nou.setMiddleName(resultat.getString(3));
	       nou.setLastName(resultat.getString(4));
	       nou.setMail(resultat.getString(5));
	       nou.setPassword(resultat.getString(6));
	       nou.setData(resultat.getTimestamp(7));
	       nou.setProfilePicture(( resultat.getString(8).length() != 0) ? resultat.getString(8) :
	         "imatges/logo.png");
	       
	       return nou;
	      
	    } catch (Exception e) {
	      // TODO Auto-generated catch block
	      e.printStackTrace();
	    }
	    return nou;
	  }
	
	public boolean checkUserExists(String parameter) {
		
		DAO dao;
		try {
		
			dao = new DAO();
			
			ResultSet result;
			
			String query = "SELECT * FROM users WHERE user LIKE '" + parameter + "';";
			
			result = dao.executeSQL(query);
			
			boolean admin = result.isBeforeFirst();
			
			dao.disconnectBD();
					
			return admin ;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return false;
		}
	}
}
