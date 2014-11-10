<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String[][] menu = {
		{"./user", "Home" },
		{"./user", "Sign Up" },
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
  <div class="container navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="./index.jsp">DISLAB</a>
      </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
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
  <div class="container container-fluid" style="padding-top:50px">
		<h1>Exercise: JSP &amp; Database</h1>
 	</div>