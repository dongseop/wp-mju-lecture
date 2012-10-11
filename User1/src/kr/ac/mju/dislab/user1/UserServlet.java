package kr.ac.mju.dislab.user1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		
		// DB 접속을 위한 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dbUrl = "jdbc:mysql://localhost:3306/web2012";
		String dbUser = "web";
		String dbPassword = "asdf";
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		String pwd_confirm = request.getParameter("pwd_confirm");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String country = request.getParameter("country");
		String gender = request.getParameter("gender");
		String[] favorites = request.getParameterValues("favorites");
		String favoriteStr = StringUtils.join(favorites, ",");

		List<String> errorMsgs = new ArrayList<String>();
		
		if (pwd == null || pwd.length() < 6) {
			errorMsgs.add("비밀번호는 6자 이상 입력해주세요.");
		} 
		
		if (!pwd.equals(pwd_confirm)) {
			errorMsgs.add("비밀번호가 일치하지 않습니다.");
		}
		
		if (name == null || name.trim().length() == 0) {
			errorMsgs.add("이름을 반드시 입력해주세요.");
		}
		
		if (!(gender == "M" || gender == "F" )) {
			errorMsgs.add("성별에 적합하지 않은 값이 입력되었습니다.");
		}
		
		if (errorMsgs.size() == 0) {
			try {
				conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
				stmt = conn.prepareStatement(
						"INSERT INTO users(userid, name, pwd, email, country, gender, favorites) " +
						"VALUES(?, ?, ?, ?, ?, ?, ?)"
						);
				stmt.setString(1,  userid);
				stmt.setString(2,  name);
				stmt.setString(3,  pwd);
				stmt.setString(4,  email);
				stmt.setString(5,  country);
				stmt.setString(6,  gender);
				stmt.setString(7,  favoriteStr);
				
				int result = stmt.executeUpdate();
			
				out.println("<html>");
				if (result == 0) {
					out.println("등록 실패");
				} else {
					out.println("등록 성공");
				}
				out.println("</html>");
			} catch (SQLException e) {
				out.println("SQL 에러: " + e.getMessage());
			} finally {
				// 무슨 일이 있어도 리소스를 제대로 종료
				if (rs != null) try{rs.close();} catch(SQLException e) {}
				if (stmt != null) try{stmt.close();} catch(SQLException e) {}
				if (conn != null) try{conn.close();} catch(SQLException e) {}
			}
		} else {
			out.println("<html>");
			
		}
		
		
	}

}
