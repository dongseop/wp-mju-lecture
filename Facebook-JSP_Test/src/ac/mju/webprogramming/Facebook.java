package ac.mju.webprogramming;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.restfb.Connection;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.Parameter;
import com.restfb.types.User;

public class Facebook{	
	// 자신의 facebook appID
	public static final String APPID = "311302862317367";
	// 자신의 facebook app Secret;
	public static final String APPSECRET = "cfd462e9a430b506c9523ec8973394ba";
	// facebook에 등록시킬 사이트주소
	public static final String SITEURL="http://117.17.158.82:8080/Facebook-JSP_Test";	
	// '좋아요' 에 담길 정보 자신의 App 정보 (변하지 않는 정보) 
	public static final String TITLE ="MJU Web Programming";
	public static final String SITENAME = "Facebook-JSP Test Site";
	public static final String TYPE = "blog";
	public static final String DESCRIPTION = "Site에 대한 설명 정보";
	public static final String IMAGE = "http://117.17.158.82:8080/Facebook-JSP_Test/img/IU.jpg";
	// facebook에 요청할  권한 리스트
	// 아래 사이트에서 필요한 권한 확인 가능
	// https://developers.facebook.com/docs/reference/login/#permissions
	public static String permissions ="user_about_me,publish_stream,read_friendlists," +
		"offline_access,user_photos,friends_about_me,user_birthday,friends_birthday";	
	public static String code;
	public static String accessToken;
	
	
	private HashMap<String,String> likeInfo;
	private FacebookClient facebookClient;
	
	public Facebook(String accessToken){
		// resfFB를 사용하기위해  facebookClient 설정
		this.facebookClient = new DefaultFacebookClient(accessToken);
		// hashmap에 자신의 App 정보 저장
		this.likeInfo = new HashMap<String,String>();		
		likeInfo.put("title",TITLE);
		likeInfo.put("sitename", SITENAME);
		likeInfo.put("appid",APPID);
		likeInfo.put("url",SITEURL);
		likeInfo.put("type",TYPE);
		likeInfo.put("description",DESCRIPTION);
		likeInfo.put("image",IMAGE);		
	}
	
	public static String getOAuthURL() throws IOException{		
		// facebook 인증 후 돌아올 redirect_url
		String redirectURL = Facebook.SITEURL +"/FBAuthServlet.do";		
		String oauthURL = "https://www.facebook.com/dialog/oauth?" +
			"client_id="+ Facebook.APPID +
			"&redirect_uri=" + URLEncoder.encode(redirectURL, "UTF-8")+
		    "&scope="+Facebook.permissions;
		return oauthURL;
	}
	
	public static String getAccessToken(String code) throws IOException{
		Facebook.code = code;
		String redirectURL = Facebook.SITEURL + "/FBAuthServlet.do";
		String accessToken = "";
	    String accessTokenURL = "https://graph.facebook.com/oauth/access_token?" +
	    	"client_id="+ Facebook.APPID + 
	    	"&redirect_uri=" + URLEncoder.encode(redirectURL, "UTF-8") + 
	    	"&client_secret=" + Facebook.APPSECRET + 
	    	"&code=" + Facebook.code;
	     
	    URL siteURL = new URL(accessTokenURL);
        URLConnection urlConn = siteURL.openConnection();
        
        BufferedReader in = new BufferedReader(
        	new InputStreamReader(urlConn.getInputStream()));
        String inputLine = null;        
        while ((inputLine = in.readLine()) != null){ 
        	accessToken = inputLine.split("&")[0].split("=")[1];	        		
        }        
        in.close();
        Facebook.accessToken = accessToken;
		return accessToken;
	}	
	
	public FacebookUser getCurrentUser() {
		// resfFB의 facebookClient를 통해 현재 사용자 정보를 가져옴
    	User user = facebookClient.fetchObject("me", User.class);
    	FacebookUser me = getFacebookUser(user);
		return me;
	}
	
	public List<FacebookUser> getFriends() {		
		List<FacebookUser> friends= new ArrayList<FacebookUser>();
		// 가져오고 싶은 친구의 정보들
		String fields = "id,name,username,link,first_name,last_name,gender,birthday,about";
		// resfFB의 facebookClient를 통해 현재 사용자 정보를 가져옴
		Connection<User> myFriends = facebookClient.fetchConnection("me/friends",
    		User.class,Parameter.with("fields",fields));
		// 페이스북에서 가져온 친구들의 정보를 FacebookUser에 담는다
		for (List<User> myFriendConnection : myFriends){				
	  		for (User friend : myFriendConnection){
	  			friends.add(getFacebookUser(friend));
	  		}
		}
		return friends;
	}
	
	public FacebookUser getFacebookUser(User user){
		// 페이스북에서 가져온 현재 사용자 정보를 FacebookUser에 담는다.
		return new FacebookUser(
			user.getId(),
    		user.getName(),
    		user.getUsername(),
    		user.getLink(),
    		user.getFirstName(),
    		user.getLastName(),
    		user.getGender(),
    		user.getBirthday(),
    		user.getAbout()
    		);
	}

	public HashMap<String, String> getLikeInfo() {
		return likeInfo;
	}

	public void setLikeInfo(HashMap<String, String> likeInfo) {
		this.likeInfo = likeInfo;
	}
	
}
