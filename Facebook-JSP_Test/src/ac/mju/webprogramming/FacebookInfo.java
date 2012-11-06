package ac.mju.webprogramming;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

public class FacebookInfo {	
	// 자신의 facebook appID
	public static final String APPID = "311302862317367";
	// 자신의 facebook app Secret;
	public static final String APPSECRET = "cfd462e9a430b506c9523ec8973394ba";
	// facebook에 등록시킬 사이트주소
	public static final String SITEURL="http://117.17.158.82:8080/Facebook-JSP_Test";	
	// facebook에 요청할  권한 리스트
	// 아래 사이트에서 필요한 권한 확인 가능
	// https://developers.facebook.com/docs/reference/login/#permissions
	public static String permissions ="user_about_me,publish_stream,read_friendlists," +
		"offline_access,user_photos,friends_about_me,user_birthday,friends_birthday";	
	public static String code;
	public static String accessToken;

	public static String getOAuthURL() throws IOException{		
		// facebook 인증 후 돌아올 redirect_url
		String redirectURL = FacebookInfo.SITEURL +"/facebookLogin.do";		
		String oauthURL = "https://www.facebook.com/dialog/oauth?" +
			"client_id="+ FacebookInfo.APPID +
			"&redirect_uri=" + URLEncoder.encode(redirectURL, "UTF-8")+
		    "&scope="+FacebookInfo.permissions;
		return oauthURL;
	}
	
	public static String getAccessToken(String code) throws IOException{
		FacebookInfo.code = code;
		String redirectURL = FacebookInfo.SITEURL + "/facebookLogin.do";
		String accessToken = "";
	    String accessTokenURL = "https://graph.facebook.com/oauth/access_token?" +
	    	"client_id="+ FacebookInfo.APPID + 
	    	"&redirect_uri=" + URLEncoder.encode(redirectURL, "UTF-8") + 
	    	"&client_secret=" + FacebookInfo.APPSECRET + 
	    	"&code=" + FacebookInfo.code;
	     
	    URL siteURL = new URL(accessTokenURL);
        URLConnection urlConn = siteURL.openConnection();
        
        BufferedReader in = new BufferedReader(
        	new InputStreamReader(urlConn.getInputStream()));
        String inputLine = null;        
        while ((inputLine = in.readLine()) != null){ 
        	accessToken = inputLine.split("&")[0].split("=")[1];	        		
        }        
        in.close();
        FacebookInfo.accessToken = accessToken;
		return accessToken;
	}	
}
