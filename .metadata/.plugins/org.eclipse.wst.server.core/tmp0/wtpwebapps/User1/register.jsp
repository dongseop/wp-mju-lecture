<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/web2012";
	String dbUser = "web";
	String dbPassword = "asdf";
	
	request.setCharacterEncoding("utf-8");
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
	int result = 0;
	
	if (userid == null || userid.trim().length() == 0) {
		errorMsgs.add("ID를 반드시 입력해주세요.");
	}
	
	if (pwd == null || pwd.length() < 6) {
		errorMsgs.add("비밀번호는 6자 이상 입력해주세요.");
	} 
	
	if (!pwd.equals(pwd_confirm)) {
		errorMsgs.add("비밀번호가 일치하지 않습니다.");
	}
	
	if (name == null || name.trim().length() == 0) {
		errorMsgs.add("이름을 반드시 입력해주세요.");
	}
	
	if (gender == null || !(gender.equals("M") || gender.equals("F") )) {
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
			
			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsgs.add("등록에 실패하였습니다.");
			}
		} catch (SQLException e) {
			errorMsgs.add("SQL 에러: " + e.getMessage());
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원목록</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="share/header.jsp">
  <jsp:param name="current" value="Sign Up"/>
</jsp:include>

 	<div class="container">
 		<% if (errorMsgs.size() > 0) { %>
 			<div class="alert alert-error">
 				<h3>Errors:</h3>
 				<ul>
 					<% for(String msg: errorMsgs) { %>
 						<li><%=msg %></li>
 					<% } %>
 				</ul>
 			</div>
		 	<div class="form-action">
		 		<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
		 	</div>
	 	<% } else if (result == 1) { %>
	 		<div class="alert alert-success">
	 			<b><%= name %></b>님 등록해주셔서 감사합니다.
	 		</div>
		 	<div class="form-action">
		 		<a href="index.jsp" class="btn">목록으로</a>
		 	</div>
	 		
	 	<%}%>
 	</div>
</body>
</html>