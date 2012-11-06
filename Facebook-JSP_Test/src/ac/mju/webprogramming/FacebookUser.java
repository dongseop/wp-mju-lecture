package ac.mju.webprogramming;

import java.util.ArrayList;
import java.util.List;

import com.restfb.Connection;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.Parameter;
import com.restfb.types.User;

public class FacebookUser {
	private FacebookClient facebookClient;
	
	public FacebookUser(){
		
	}
	public FacebookUser(String accessToken) {
		// resfFB를 사용하기위해  facebookClient 설정
		this.facebookClient = new DefaultFacebookClient(accessToken);  
	}
	
	public FacebookUserBean getCurrentUser() {
		// resfFB의 facebookClient를 통해 현재 사용자 정보를 가져옴
    	User user = facebookClient.fetchObject("me", User.class);
    	FacebookUserBean me = getFacebookUserBean(user);
		return me;
	}
	
	public List<FacebookUserBean> getFriends() {		
		List<FacebookUserBean> friends= new ArrayList<FacebookUserBean>();
		// 가져오고 싶은 친구의 정보들
		String fields = "id,name,username,link,first_name,last_name,gender,birthday,about";
		// resfFB의 facebookClient를 통해 현재 사용자 정보를 가져옴
		Connection<User> myFriends = facebookClient.fetchConnection("me/friends",
    		User.class,Parameter.with("fields",fields));
		// 페이스북에서 가져온 친구들의 정보를 FacebookUserBean에 담는다
		for (List<User> myFriendConnection : myFriends){				
	  		for (User friend : myFriendConnection){
	  			friends.add(getFacebookUserBean(friend));
	  		}
		}
		return friends;
	}
	
	public FacebookUserBean getFacebookUserBean(User user){
		// 페이스북에서 가져온 현재 사용자 정보를 FacebookUserBean에 담는다.
		return new FacebookUserBean(
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
}
