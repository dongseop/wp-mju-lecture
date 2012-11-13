<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<channel>
		<title>RSS News Aggregator</title>
		<link>http://tahiti.mju.ac.kr</link>
		<description>뉴스 통합 예제</description>
		<languagr>ko</languagr>
		<generator>JSP/XML</generator>
		<c:forEach var="feedlist" items="${feedlist}">
			<item>			
				<title>${feedlist.getTitle()}</title>
				<pubDate>${feedlist.getPubDate()}</pubDate>
				<link>${feedlist.getLink()}</link>				
			</item>
		</c:forEach>
	</channel>
</rss>