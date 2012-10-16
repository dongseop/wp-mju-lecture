<%@ page import="java.util.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer class="footer">
  <div class="container" style="border-top:1px solid #DDD; padding:10px 0;">
    &copy; Web Programming 2012, Dongseop Kwon
    <ul style="color:#aaa">
			<%
			 Enumeration<String> headers = request.getHeaderNames();
			 while (headers.hasMoreElements()) {
			  String name = (String)headers.nextElement();
			  String value = request.getHeader(name);
			
			  out.println("<li>" + name + " : " + value + "</li>");
			 }
			%>

    </ul>
  </div>
</footer>

