<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<form action="RssServlet.do" method="post">
			<fieldset>
				<label>RSS URL :</label> 
				<input type="text" id="url" size="100" name="url" />
				<input type="submit" value="전송" /><br>
			</fieldset>
			네이버 뉴스 RSS URL : http://newscast.naver.com/presscenter/rssPress.nhn?pressId=029<br>
			한겨레 뉴스 RSS URL : http://www.hani.co.kr/rss<br>
		</form>
	</div>
</body>
</html>