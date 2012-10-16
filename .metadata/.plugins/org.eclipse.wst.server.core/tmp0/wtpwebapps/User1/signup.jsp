<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils"%>
<%
	String[] countries = {"한국", "미국", "영국", "일본", "중국"};
	String[] idols = {"아이유", "카라", "소녀시대", "2NE1", "씨스타"};
	String[][] genders = {{"M", "남성"}, {"F", "여성"}};
	
	String errorMsg = null;

	String actionUrl;
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/web2012";
	String dbUser = "web";
	String dbPassword = "asdf";
	
	// 사용자 정보를 위한 변수 초기화
	String userid = "";
	String name = "";
	String pwd = "";
	String email = "";
	String country = "";
	String gender = "";
	String favorites = "";
	List<String> favoriteList = null;
	
	// Request로 ID가 있는지 확인
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));
	} catch (Exception e) {}

	if (id > 0) {
		// Request에 id가 있으면 update모드라 가정
		actionUrl = "update.jsp";
		try {
		    Class.forName("com.mysql.jdbc.Driver");

		    // DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

	 		// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
			stmt.setInt(1, id);
			
			// 수행
	 		rs = stmt.executeQuery();
			
			if (rs.next()) {
				userid = rs.getString("userid");
				name = rs.getString("name");
				pwd = rs.getString("pwd");
				email = rs.getString("email");
				country = rs.getString("country");
				gender = rs.getString("gender");
				favorites = rs.getString("favorites");
				if (favorites != null && favorites.length() > 0) {
					favoriteList = Arrays.asList(StringUtils.split(favorites, ","));
				}
			}
		}catch (SQLException e) {
			errorMsg = "SQL 에러: " + e.getMessage();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	} else {
		actionUrl = "register.jsp";
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
 <%
 if (errorMsg != null && errorMsg.length() > 0 ) {
		// SQL 에러의 경우 에러 메시지 출력
		out.print("<div class='alert'>" + errorMsg + "</div>");
 }
 %>
	  <div>
		  <form class="form-horizontal" action="<%=actionUrl%>" method="post">
			<fieldset>
        <legend class="legend">Sign Up</legend>
			  	<%
			  	if (id > 0) {
			  		out.println("<input type='hidden' name='id' value='"+id+"'>");
			  	}
			  	%>
				<div class="control-group">
					<label class="control-label" for="userid">ID</label>
					<div class="controls">
						<input type="text" name="userid" value="<%=userid%>">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label" for="name">Name</label>
					<div class="controls">
						<input type="text" placeholder="홍길동" name="name" value="<%=name%>">
					</div>
				</div>

				<% if (id <= 0) { %>
					<%-- 신규 가입일 때만 비밀번호 입력창을 나타냄 --%>
					<div class="control-group">
						<label class="control-label" for="pwd">Password</label>
						<div class="controls">
							<input type="password" name="pwd">
						</div>
					</div>
	
					<div class="control-group">
						<label class="control-label" for="pwd_confirm">Password Confirmation</label>
						<div class="controls">
							<input type="password" name="pwd_confirm">
						</div>
					</div>
				<% } %>
				<div class="control-group">
					<label class="control-label" for="email">E-mail</label>
					<div class="controls">
						<input type="email" placeholder="hong@abc.com" name="email" value="<%=email%>">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Country</label>
					<div class="controls">
						<select name="country">
							<% 
							for(String countryName: countries) {
								out.print("<option");
								if (countryName.equals(country)) {
									out.print(" selected");
								}
								out.println(">"+countryName+"</option>");	
							}
							%>
						</select>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Gender</label>
					<div class="controls">
						<% for(String[] genderOption : genders) { %> 
							<label class="radio"> 
							  <input type="radio" value="<%=genderOption[0] %>" name="gender"
							  <% if (genderOption[0].equals(gender)) { out.print("checked");} %>
							  > 
							  <%=genderOption[1] %>
							</label>
						<% } %> 
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Favorites</label>
					<div class="controls">
						<% 
						for (String idolName: idols) {
							%>
							<label class="checkbox"> 
							  <input type="checkbox" name="favorites" value="<%=idolName%>"
							  <% 
							  	if (favoriteList != null && favoriteList.contains(idolName)) { 
								  	out.print("checked");
								 	} 
								 %>
							  >
							  <%=idolName %>
							</label> 
							<%				
						}						
						%>
					</div>
				</div>

				<div class="form-actions">
					<a href="index.jsp" class="btn">목록으로</a>
					<% if (id <= 0) { %>
						<input type="submit" class="btn btn-primary" value="가입">
					<% } else { %>
						<input type="submit" class="btn btn-primary" value="수정">
					<% } %>
				</div>
			</fieldset>
		  </form>
    </div>
  </div>
  
</body>
</html>