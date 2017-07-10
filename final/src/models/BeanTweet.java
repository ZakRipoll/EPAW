package models;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import controllers.DAO; 

public class BeanTweet {
	
	private int id = 0;
	private String user = "";
	private String name = "";
	private String middleName = "";
	private String lastName = "";
	private String profilePicture = "";
	private String text = "";
	private String data;
	private int likes = 0;
	private int retweet = 0;
	private int share = 0;
	private boolean userLove;
	private boolean userRetweet;
	private boolean userComment;
		
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

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

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getData() {
		return data;
	}

	public void setData(Timestamp data) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date date = data;
		this.data = dateFormat.format(date);
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	public int getRetweet() {
		return retweet;
	}

	public void setRetweet(int retweet) {
		this.retweet = retweet;
	}

	public int getShare() {
		return share;
	}

	public void setShare(int share) {
		this.share = share;
	}

	public boolean isUserLove() {
		return userLove;
	}

	public void setUserLove(boolean userLove) {
		this.userLove = userLove;
	}

	public boolean isUserRetweet() {
		return userRetweet;
	}

	public void setUserRetweet(boolean userRetweet) {
		this.userRetweet = userRetweet;
	}

	public boolean isUserComment() {
		return userComment;
	}

	public void setUserComment(boolean userComment) {
		this.userComment = userComment;
	}

	public List<BeanTweet> listTweets(String usuari, boolean profile, String userInSession ) {
		
		DAO dao;
		
		try {
			
			List<BeanTweet> llista = new ArrayList<BeanTweet>();
			
			dao = new DAO();
			
			String query = "SELECT *, interaction(id, '" + userInSession + "', TRUE), "
					+ "interaction(id, '" + userInSession + "', FALSE), "
					+ "interaction(id, '" + userInSession + "', NULL) "
					+ "FROM tweetsView ";
			
			if( usuari == null)
				
				query += "ORDER BY retweets DESC, likes DESC, shares DESC, id DESC LIMIT 20;";
			
			else{
				
				query += "WHERE user ";
				
				query += (profile) ? "LIKE '" + usuari + "' ORDER BY" : "IN (SELECT user2 FROM follow WHERE user1 LIKE '" 
				+ usuari + "') ORDER BY DATE DESC,";
				
				query += " id DESC;";
			}
				
			ResultSet resultats = dao.executeSQL(query);
			
			 while(resultats.next()) {
				 
				 	BeanTweet nou = new BeanTweet();
				 	
				 	nou.setId(resultats.getInt(1));
				 	nou.setUser(resultats.getString(2));
				 	nou.setName(resultats.getString(3));
				 	nou.setMiddleName(resultats.getString(4));
				 	nou.setLastName(resultats.getString(5));
				 	nou.setProfilePicture(( resultats.getString(6).length() != 0) ? resultats.getString(6) : "imatges/logo.png");
				 	nou.setText(resultats.getString(7));
				 	nou.setData(resultats.getTimestamp(8));
				 	nou.setLikes(resultats.getInt(9));
				 	nou.setRetweet(resultats.getInt(10));
				 	nou.setShare(resultats.getInt(11));
				 	nou.setUserLove(resultats.getBoolean(12));
				 	nou.setUserRetweet(resultats.getBoolean(13));
				 	nou.setUserComment(resultats.getBoolean(14));
				 	
				 	llista.add(nou);
			 }
			 
			dao.disconnectBD();
			 
			return llista;
			 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
	public boolean insertORdeletTweet( String usuari, String text, boolean action){
		
		DAO dao;
		try {
			dao = new DAO();
			   
			String query = ((action) ? "INSERT INTO tweets (user, text) VALUES" : "CALL deleteTweet") 
					+ " ('"+ usuari + "', '"+ text +"'";
			
			if( !action ) query += ", TRUE";
			
			query += ");";
			
			int result = dao.executeInsert(query);
			
			dao.disconnectBD();
			
			return result !=0;
			 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return false;
		}
	}
	
public boolean lrc( String id, String user, String type ){
		
		DAO dao;
		
		try {
			dao = new DAO();
		
			int result;
			   
			String query = "CALL updateORinsertLRC (" + id + ", '" + user +"', ";
			
			switch ( type ){
				case "like":	query += "FALSE";	break;
				case "retweet":	query += "TRUE";	break;
				default:		query += "NULL";
			}
			
			query += ");";
			
			result = dao.executeInsert(query);
			
			dao.disconnectBD();
			
			return result !=0;
			 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return false;
		}
	}
}
