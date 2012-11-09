package kr.ac.mju.dislab.facebook;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.restfb.types.User;



@WebServlet("/FBAuthServlet") 
public class FBAuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String actionURL = "";
		String code = request.getParameter("code"); 

		request.setCharacterEncoding("UTF-8");

		// facebook에서 전달받은 인증 code가 없을 경우
		if( code == null){			
			String oauthURL = Facebook.getOAuthURL();
			response.sendRedirect (oauthURL);
		}
		else{			
			Facebook facebook = Facebook.getInstance(code); 
			// View page 설정
			actionURL = "myFacebook.jsp";

			// 현재 페이스북 유저와 친구의 정보를 가져온다.
			User me = facebook.getCurrentUser();
			List<User> friends = facebook.getFriends();

			// request의 attribute로 담는다.
			request.setAttribute("me", me);
			request.setAttribute("friends", friends);
			request.setAttribute("facebook", facebook);

			RequestDispatcher view = request.getRequestDispatcher(actionURL);
			view.forward(request, response);
		}
	}	
}
