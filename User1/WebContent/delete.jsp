<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    %>
<%
	// 현재 메뉴
	String errorMsg = null;
	int result = 0;
	
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/web2012";
	String dbUser = "web";
	String dbPassword = "asdf";
	
	request.setCharacterEncoding("utf-8");

	// Request로 ID가 있는지 확인
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));
	} catch (Exception e) {}
	
	try {
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		stmt = conn.prepareStatement("DELETE FROM users WHERE id=?");
		stmt.setInt(1,  id);
		
		result = stmt.executeUpdate();
		if (result != 1) {
			errorMsg = "삭제에 실패했습니다.";
		}
	} catch (SQLException e) {
		errorMsg = "SQL 에러: " + e.getMessage();
	} finally {
		// 무슨 일이 있어도 리소스를 제대로 종료
		if (rs != null) try{rs.close();} catch(SQLException e) {}
		if (stmt != null) try{stmt.close();} catch(SQLException e) {}
		if (conn != null) try{conn.close();} catch(SQLException e) {}
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
 		<% if (errorMsg != null) { %>
 			<div class="alert alert-error">
 				<h3>Errors:</h3>
 				<%= errorMsg %>
 			</div>
	 	<% } else { %>
	 		<div class="alert alert-success">
	 			사용자 정보를 삭제하였습니다.
	 		</div>
	 	<%}%>
	 	<div class="form-action">
	 		<a href="index.jsp" class="btn">목록으로</a>
	 	</div>
 	</div>
</body>
</html>