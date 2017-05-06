package models;

import java.io.Serializable;

public class BeanUser implements Serializable  {

	private static final long serialVersionUID = 1L;

	private String name = "";
	private String middle_name = "";
	private String last_name = "";
	private String username = "";
	private String email = "";
	private String password = "";
	private String repeat_password = "";
	private String birth_date = "";
	private String profile_picture = "";
	private String sex = "";
	private String terms_of_use = "";
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMiddle_name() {
		return middle_name;
	}

	public void setMiddle_name(String middle_name) {
		this.middle_name = middle_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRepeat_password() {
		return repeat_password;
	}

	public void setRepeat_password(String repeat_password) {
		this.repeat_password = repeat_password;
	}

	public String getBirth_date() {
		return birth_date;
	}

	public void setBirth_date(String birth_date) {
		String[] parts = birth_date.split("/", 3);
		this.birth_date = parts[2]+"-"+parts[1]+"-"+parts[0];
	}

	public String getProfile_picture() {
		return profile_picture;
	}

	public void setProfile_picture(String profile_picture) {
		this.profile_picture = profile_picture;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getTerms_of_use() {
		return terms_of_use;
	}

	public void setTerms_of_use(String terms_of_use) {
		this.terms_of_use = terms_of_use;
	}
	
	@Override
	public String toString() {
		return "BeanUser [name=" + name + ", middle_name=" + middle_name + ", last_name=" + last_name + ", username="
				+ username + ", email=" + email + ", password=" + password + ", repeat_password=" + repeat_password
				+ ", birth_date=" + birth_date + ", profile_picture=" + profile_picture + ", sex=" + sex
				+ ", terms_of_use=" + terms_of_use + "]";
	}

}
