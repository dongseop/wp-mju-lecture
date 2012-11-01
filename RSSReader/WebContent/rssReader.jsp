<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.*" %>
<%@ page import="org.jdom2.Document" %>
<%@ page import="org.jdom2.Element" %>
<%@ page import="org.jdom2.JDOMException" %>
<%@ page import="org.jdom2.input.SAXBuilder" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>News Feed</title>
</head>
<body>
<%
	String[] RSSFEED = {"http://localhost:8080/RSSReader/rssFeed.xml","http://news.google.com/news?ned=us&topic=h&output=rss"};
	String RSSLink;
	String RSSTitle;
	String RSSDesc;

	SAXBuilder saxBuilder = new SAXBuilder();
	Document jdomDocument;
	try{
		for(int i=0; i<RSSFEED.length; i++){
			jdomDocument = saxBuilder.build(RSSFEED[i]);
			Element root = jdomDocument.getRootElement();
			Element channel = root.getChild("channel");
			String title = channel.getChildText("title");
			String desc = channel.getChildText("description");
%>
	<div>
		<h3>[<%=title%>]</h3>
		<h3>[<%=desc%>]</h3>
		<hr>
	</div>
<%
			List<Element> children = channel.getChildren("item");
			Iterator<Element> iter = children.iterator();
			
			int j=0;
			while(iter.hasNext()){
				Object obj = iter.next();
				Element item = ((Element)obj);
				RSSLink = item.getChildTextTrim("link");
				RSSTitle = item.getChildTextTrim("title");
				RSSDesc = item.getChildTextTrim("description");
%>
	<a href="<%=RSSLink%>"><%=RSSTitle%></a><br>
	<%=RSSDesc%>
	<hr>
<%
				j++;
			}
		}
	}catch (JDOMException e){
		out.println(e);
	}catch (IOException e) {
		out.println(e);
	}
%>
</body>
</html>