<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Web Programming - Facebook-JSP 연동 (Servlet)</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">	
	<link href="css/style.css" rel="stylesheet">
	<script src="js/bootstrap.min.js"></script>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<!-- Facebook 접속에 쓰일 js -->
	<script src="//connect.facebook.net/en_US/all.js"></script>
</head>

<body>
	<jsp:include page="share/header.jsp"></jsp:include>
	<div class="container">
		<h1>Facebook-JSP Example</h1>
				
		<div style="margin-bottom:20px;" class="center">
			
		<!-- Facebook 접속 버튼 -->
		  <a class="fb_button fb_button_large" id="btnLogin" href="facebookLogin.do" data-size="xlarge">
		    <span class="fb_button_text"> Log In</span>
		  </a>
		</div>
	</div>
	
	<jsp:include page="share/footer.jsp"></jsp:include>
</body>
</html>