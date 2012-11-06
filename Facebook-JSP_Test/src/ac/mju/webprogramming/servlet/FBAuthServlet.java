package ac.mju.webprogramming.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ac.mju.webprogramming.FacebookInfo;
import ac.mju.webprogramming.FacebookLikeInfoBean;
import ac.mju.webprogramming.FacebookUser;
import ac.mju.webprogramming.FacebookUserBean;


@WebServlet("/FBAuthServlet") 
public class FBAuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String actionURL = "";
		String code = request.getParameter("code"); 
		
		
		// facebook에서 전달받은 인증 code가 없을 경우
		if( code == null){			
			String oauthURL = FacebookInfo.getOAuthURL();
			response.sendRedirect (oauthURL);
		}
		else{
			// facebook에서 얻은 code로 access token 얻음
			String accessToken = FacebookInfo.getAccessToken(code);
			// facebook 사용자 정보를 가져오기 위해 access token을 넘겨준다.
			FacebookUser facebookUser = new FacebookUser(accessToken);
			// '좋아요' 버튼 클릭시 담길 메타 태그정보들 설정하기 위한 Bean
			FacebookLikeInfoBean LikeInfo = new FacebookLikeInfoBean();
			actionURL = "myfacebookInfo.jsp";
			
			// 현재 페이스북 유저와 친구의 정보를 가져온다.
			FacebookUserBean me = facebookUser.getCurrentUser();
			List<FacebookUserBean> friends = facebookUser.getFriends();
			// 좋아요 버튼 메타 태그의 url 태그를 수정한다.
			LikeInfo.setUrl(LikeInfo.getUrl() + actionURL);
			
			// request의 attribute로 담는다.
			request.setAttribute("me", me);
			request.setAttribute("friends", friends);
			request.setAttribute("LikeInfo", LikeInfo);
			
			RequestDispatcher view = request.getRequestDispatcher(actionURL);
	        view.forward(request, response);
		}
	}	
}
