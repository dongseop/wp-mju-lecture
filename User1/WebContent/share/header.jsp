<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String[][] menu = {
		{"./index.jsp", "Home" },
		{"./index.jsp", "Sign Up" },
		{"#", "Menu1" },
		{"#", "Menu2" },
		{"#", "Menu3" },
		{"#", "Menu4" },
		{"#", "Menu5" }
	};
  String currentMenu = request.getParameter("current");
%>    
	<!-- Navbar
  ================================================== -->
  <div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
        <a class="brand" href="./index.jsp">DISLAB</a>
        <div class="nav-collapse collapse">
          <ul class="nav">
          <%
          	for(String[] menuItem : menu) {
          		if (currentMenu != null && currentMenu.equals(menuItem[1])) {
          			out.println("<li class='active'>");
          		} else {
          			out.println("<li class=''>");
          		}
          		
          		out.println("<a href='"+menuItem[0]+"'>"+menuItem[1]+"</a>");
          		out.println("</li>");
          	}
          %>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <div class="container" style="padding-top:50px">
		<h1>Exercise: JSP &amp; Database</h1>
 	</div>
 	
 	