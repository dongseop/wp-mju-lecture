package ac.mju.webprogramming;

public class FacebookLikeInfoBean implements java.io.Serializable{
	private static final long serialVersionUID = 1L;

	private String title;
	private String sitename;
	private String appid;
	private String url;
	private String type;
	private String description;
	private String image;
	
	public FacebookLikeInfoBean(){
		// 좋아요 버튼 클릭시 담길 정보
		this.title = "MJU Web Programming";
		this.sitename = "Facebook-JSP Test Site";
		this.appid = FacebookInfo.APPID;
		this.url = "http://117.17.158.82:8080/Facebook-JSP_Test/";
		this.type = "blog";
		this.description = "내 페이스북 정보";
		this.image = "http://117.17.158.82:8080/Facebook-JSP_Test/img/IU.jpg";
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSitename() {
		return sitename;
	}
	public void setSitename(String sitename) {
		this.sitename = sitename;
	}
	public String getAppid() {
		return appid;
	}
	public void setAppid(String appid) {
		this.appid = appid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
}
