<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" buffer="8kb" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ex2</title>
<style>
  .error {background:#936; color:#fff; padding:10px; margin:10px 0;}
</style>
</head>
<body>
  <%
  if (request.getMethod() == "POST") {
	  String id = request.getParameter("id");
	  String pwd = request.getParameter("pwd");
	  
	  if (id == null || pwd == null || id.length() == 0 || pwd.length() == 0) {
		  %>
		   <div class="error">아이디와 비밀번호를 입력하세요.</div>
		  <%
	  } else if (id.equals("iu") && pwd.equals("12345")) {
		  // 로그인 성공
	      session.setAttribute("userId", "iu");
	      session.setAttribute("userName", "이지은");	
	      response.sendRedirect("ex2.jsp");	      
		 } else {
		  %>
		   <div class="error">아이디나 비밀번호가 잘못되었습니다.</div>
		  <%
	  }
	  
  }
  %>
  <form method="post">
	  ID: <input type="text" name="id">
	  Password: <input type="password" name="pwd">
	  <input type="submit" value="login">
  </form>
</body>
</html>

