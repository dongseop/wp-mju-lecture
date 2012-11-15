<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
	<channel>
		<title>RSS News Aggregator</title>
		<link>http://tahiti.mju.ac.kr</link>
		<description>뉴스 통합 예제</description>
		<languagr>ko</languagr>
		<generator>JSP/XML</generator>
		<c:forEach var="newsItem" items="${news}">
			<item>			
				<title><![CDATA[${newsItem.title}]]></title>
				<link><![CDATA[${newsItem.link}]]></link>
				<pubDate><![CDATA[${newsItem.pubDate}]]></pubDate>
				<guid><![CDATA[http://tahiti.mju.ac.kr?url=${newsItem.link}]]></guid>
			</item>
		</c:forEach>
	</channel>
</rss>