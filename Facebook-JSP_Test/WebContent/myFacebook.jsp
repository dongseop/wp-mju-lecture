<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"  %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta property="og:title" content="MJU Web Programming" />
	<meta property="og:site_name" content="Facebook-JSP Test Site" />
	<meta property="og:app_id" content="${facebook.APPID}" />
	<meta property="og:url" content="${facebook.SITEURL}" />
	<meta property="og:type" content="blog" />
	<meta property="og:description" content="좋아요 버튼에 담길 Site 설명" />
	<meta property="og:image" content="http://117.17.158.82:8080/Facebook-JSP_Test/img/IU.jpg" />	
	<link href="css/style.css" rel="stylesheet">
	<link href="css/bootstrap.min.css" rel="stylesheet">			
	<script src="js/bootstrap.min.js"></script>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	
	<title>My Facebook Infomation </title>
</head>
<body>
	<div id="fb-root"></div>
	<script>(function(d, s, id) {
	  var js, fjs = d.getElementsByTagName(s)[0];
	  if (d.getElementById(id)) return;
	  js = d.createElement(s); js.id = id;
	  js.src = "//connect.facebook.net/ko_KR/all.js#xfbml=1&appId=${facebook.APPID}";
	  fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));</script>
	<jsp:include page="share/header.jsp"></jsp:include>
	<div class="container">
		<h1> Facebook Information </h1>
		
		<h3>Like Button</h3>
		
		<div class="well well-large">
			<div class="fb-like" data-href="${facebook.SITEURL}/myFacebook.jsp" data-send="false" 
			data-width="450" data-show-faces="true" data-font="tahoma"></div>
		</div>
		<hr></hr>
		
		<h3> My Facebook Information </h3>
		
		<table class="table table-striped table-bordered">
			<tr>
				<td rowspan="8" class="row-align">
					<img src="https://graph.facebook.com/${me.id}/picture?type=large" 
					 class="img-polaroid" />
				</td>
				<td>Name :</td><td>${me.name}</td>
			</tr>			
			<tr>
				<td>User name :</td><td>${me.username}</td>
			</tr>
			<tr>
				<td>Facebook Link :</td><td>${me.link}</td>
			</tr>
			<tr>
				<td>ID :</td><td>${me.id}</td>
			</tr>
			<tr>
				<td>First Name :</td><td>${me.firstName}</td>
			</tr>
			<tr>
				<td>Last Name :</td><td>${me.lastName}</td>
			</tr>
			<tr>
				<td>Gender : </td><td>${me.gender}</td>
			</tr>
			<tr>
				<td>Birth Day :</td><td>${me.birthday}</td>
			</tr>
		</table>
		
	</div>
		
		
	<div class="container">	
			
		<hr></hr>
		<h3> My Facebook Friend List </h3>
		
		<c:forEach var="friend" items="${friends}" >
				<table class="table table-striped table-bordered">
					<tr>
						<td rowspan="8" class="row-align">
							<img src="https://graph.facebook.com/${friend.id}/picture?type=large"  
							class="img-polaroid" />
						</td>
						<td>Name :</td><td>${friend.name}</td>
					</tr>			
					<tr>
						<td>User name :</td><td>${friend.username}</td>
					</tr>
					<tr>
						<td>Facebook Link :</td><td>${friend.link}</td>
					</tr>
					<tr>
						<td>ID :</td><td>${friend.id}</td>
					</tr>
					<tr>
						<td>First Name :</td><td>${friend.firstName}</td>
					</tr>
					<tr>
						<td>Last Name :</td><td>${friend.lastName}</td>
					</tr>
					<tr>
						<td>Gender : </td><td>${friend.gender}</td>
					</tr>
					<tr>
						<td>Birth Day :</td><td>${friend.birthday}</td>
					</tr>
				</table>
		</c:forEach>
		
	</div>
	<jsp:include page="share/footer.jsp"></jsp:include>
</body>
</html>

