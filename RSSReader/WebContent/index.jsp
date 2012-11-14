Index.jsp 필요 없고

Project이름 --> FeedAgregator




<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Rss News Feed Example</title>
<script src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#addUrl").click(function(){
		$("#rssUrl").append('<input type="text" class="url" size="100" name="url"/><br>');
	});
});
</script>
</head>
<body>
	<div>
		<form action="RssServlet.do" method="post">
			<fieldset>
				<label>RSS URL :</label> 
				<div id="rssUrl">
					<input type="text" class="url" size="100" name="url" value="http://www.hani.co.kr/rss"/><br>
					<input type="text" class="url" size="100" name="url" value="http://rss.ohmynews.com/rss/top.xml"/><br>
					<input type="text" class="url" size="100" name="url" value="http://myhome.chosun.com/rss/www_section_rss.xml"/><br>
				</div>
				<input type="button" id="addUrl"value="추가" />
				<input type="submit" value="전송" />
			</fieldset>
		</form>
	</div>
</body>
</html>