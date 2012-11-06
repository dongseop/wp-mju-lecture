package ac.mju.webprogramming;

public class FacebookUserBean implements java.io.Serializable{	
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String name;
	private String username;
	private String link;
	private String firstname;
	private String lastname;
	private String gender;	
	private String birthday;
	private String about;
	
	public FacebookUserBean(){
		
	}
	public FacebookUserBean(String id, String name, String username, String link,
		String firstname, String lastname, String gender, String birthday,
		String about){
		this.id = id;
		this.name = name;
		this.username = username;
		this.link = link;
		this.firstname = firstname;
		this.lastname = lastname;
		this.gender = gender;
		this.birthday = birthday;
		this.about = about;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getAbout() {
		return about;
	}
	public void setAbout(String about) {
		this.about = about;
	}	
	
}
