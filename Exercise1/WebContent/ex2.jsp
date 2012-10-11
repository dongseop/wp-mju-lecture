<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Exercise 2</title>
</head>
<body>
<% if (session.getAttribute("userId") == null) { %>
  로그인을 하셔야 내용을 보실 수 있습니다.
  <p>
    <a href="login.jsp">로그인</a>
   </p>
<% } else { %>
  안녕하세요. <b><%=session.getAttribute("userName") %></b>님<br>
  이것은 중요한 정보입니다.<br>
  <a href="logout.jsp">로그아웃</a>  
<% } %>
</body>
</html>

