package models;

import java.sql.ResultSet;

import controllers.DAO;

public class BeanLogin {

	private String user = "";
	private String password = "";
	private int[] error = {0};
	
	public String getUser(){
		return user;
	}
	
	public String getPassword() {
		return password;
	}
	
	public int[] getError() {
		return error;
	}
	
	public void setUser(String user){
		this.user = user;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public void setError(int error) {
		this.error[0] = error;
	}
	
	public boolean isComplete() {
	   if (hasValue(getUser()) && hasValue(getPassword())){
		   DAO dao;
		   try {
			dao = new DAO();
			ResultSet f = dao.executeSQL("SELECT COUNT(*) FROM users WHERE user='" + this.user + "' AND password='" + this.password + "';");
			f.next(); int i = Integer.parseInt(f.getString(1));
			dao.disconnectBD();
			if(i!=0)return true;
			else {
				setError(1);
				return false;
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		   
	   }
	return false;
	}	
	
	private boolean hasValue(String val) {
		return((val != null) && (!val.equals("")));
	}	
}