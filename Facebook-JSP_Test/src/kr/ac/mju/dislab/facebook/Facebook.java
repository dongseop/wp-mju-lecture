package kr.ac.mju.dislab.facebook;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import com.restfb.Connection;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.Parameter;
import com.restfb.types.User;

public class Facebook{	
	// 자신의 facebook appID
	public static final String APPID = "800287103325790";
	// 자신의 facebook app Secret;
	public static final String APPSECRET = "3915dbc948f37cf42ea3d8ab0cde1766";
	// facebook에 등록시킬 사이트주소
	public static final String SITEURL="http://117.17.158.93:3001/Facebook-JSP_Test";
	// facebook에 요청할  권한 리스트
	// 아래 사이트에서 필요한 권한 확인 가능
	// https://developers.facebook.com/docs/reference/login/#permissions
	private static final String PERMISSIONS ="public_profile,user_friends";	
	private FacebookClient facebookClient;

	private Facebook(String accessToken) {
		this.facebookClient = new DefaultFacebookClient(accessToken);
	}

	public static Facebook getInstance(String code) throws IOException{
		return new Facebook(getAccessToken(code));		
	}
	
	// facebook에서 얻은 code로 access token 얻음
	public static String getOAuthURL() throws IOException{		
		// facebook 인증 후 돌아올 redirect_url
		String redirectURL = Facebook.SITEURL +"/FBAuthServlet.do";		
		String oauthURL = "https://www.facebook.com/v2.0/dialog/oauth?" +
			"client_id="+ Facebook.APPID +
			"&redirect_uri=" + URLEncoder.encode(redirectURL, "UTF-8")+
			"&scope="+ Facebook.PERMISSIONS;
		return oauthURL;
	}
	
	// facebook 사용자 정보를 가져오기 위해 access token을 넘겨준다.
	private static String getAccessToken(String code) throws IOException{
		String redirectURL = Facebook.SITEURL + "/FBAuthServlet.do";
		String accessToken = "";
		String accessTokenURL = "https://graph.facebook.com/oauth/access_token?" +
			"client_id="+ Facebook.APPID + 
			"&redirect_uri=" + URLEncoder.encode(redirectURL, "UTF-8") + 
			"&client_secret=" + Facebook.APPSECRET + 
			"&code=" + code;

		URL siteURL = new URL(accessTokenURL);
		URLConnection urlConn = siteURL.openConnection();        
		BufferedReader in = new BufferedReader(
			new InputStreamReader(urlConn.getInputStream()));
		String inputLine = null;        
		while ((inputLine = in.readLine()) != null){ 
			accessToken = inputLine.split("&")[0].split("=")[1];	        		
		}
		in.close();
		return accessToken;
	}	

	public User getCurrentUser() {
		// resfFB의 facebookClient를 통해 현재 사용자 정보를 가져옴
		return facebookClient.fetchObject("me", User.class);
	}

	public List<User> getFriends() {		
		List<User> friends= new ArrayList<User>();
		// 가져오고 싶은 친구의 정보들
		String fields = "id,name,link,first_name,last_name,gender";
		// resfFB의 facebookClient를 통해 현재 사용자 정보를 가져옴
		Connection<User> myFriends = facebookClient.fetchConnection("me/friends",
			User.class,Parameter.with("fields",fields));

		// 페이스북에서 가져온 친구들의 정보를 FacebookUser에 담는다
		for (List<User> myFriendConnection : myFriends){				
			for (User friend : myFriendConnection){
				friends.add(friend);
			}
		}
		return friends;
	}

	public String getAPPID() {
		return Facebook.APPID;
	}

	public String getSITEURL() {
		return Facebook.SITEURL;
	}
	
}
