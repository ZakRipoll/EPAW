package models;

import java.sql.ResultSet;

import controllers.DAO;

public class BeanUserLogged {
	
	private String user = "";
	private String name = "";
	private String middleName = "";
	private String lastName = "";
	private String profilePicture = "";
	private int follow = 0;
	private int followed = 0;
	private int tweets = 0;
	private int friends = 0;
	
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

	public int getFollow() {
		return follow;
	}

	public void setFollow(int follow) {
		this.follow = follow;
	}

	public int getFollowed() {
		return followed;
	}

	public void setFollowed(int followed) {
		this.followed = followed;
	}

	public int getTweets() {
		return tweets;
	}

	public void setTweets(int tweets) {
		this.tweets = tweets;
	}

	public int getFriends() {
		return friends;
	}

	public void setFriends(int friends) {
		this.friends = friends;
	}

	public BeanUserLogged user( String usuari, String friend ) {
		
		DAO dao;
		
		try {
			dao = new DAO();
			
			String query = "SELECT user, name, middleName, lastName, profilePicture, follow, followed, tweets, "
					+ "( SELECT friends('" + friend + "', '" + usuari  + "') ) FROM users WHERE user LIKE '" + usuari +"';";
			
			ResultSet result = dao.executeSQL(query);
			
			result.next();
			
			BeanUserLogged nou = new BeanUserLogged();
			
		 	nou.setUser(result.getString(1));
		 	nou.setName(result.getString(2));
		 	nou.setMiddleName(result.getString(3));
		 	nou.setLastName(result.getString(4));
		 	nou.setProfilePicture((result.getString(5).length() != 0) ? result.getString(5) : "imatges/logo.png");
		 	nou.setFollow(result.getInt(6));
		 	nou.setFollowed(result.getInt(7));
		 	nou.setTweets(result.getInt(8));
		 	nou.setFriends(result.getInt(9));
		 	
		 	dao.disconnectBD();
		 	
		 	return nou;
			 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return null;
		}
	}
}
