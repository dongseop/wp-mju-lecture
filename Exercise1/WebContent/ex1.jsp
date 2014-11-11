<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Ex1</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
  <jsp:include page="share/header.jsp"></jsp:include>
  <div class="container">
	<%	if (request.getMethod() == "POST") { %>
		 <div class="well">
		  <ul>
		    <li>이름 : <%=request.getParameter("name")%></li>
		    <li>비밀번호 : <%=request.getParameter("pwd")%></li>
		    <li>E-mail : <%=request.getParameter("email")%></li>
		    <li>Country : <%=request.getParameter("country")%></li>
		    <li>성별 : <%=request.getParameter("gender")%></li>
		    <li>좋아하는 그룹 :
		      <ul>
		      <% 
		      if (request.getParameter("favorites") != null) {
		        for(String name: request.getParameterValues("favorites")) {
		          out.println("<li>" + name + "</li>");
		        }
		      }
		      %>
		      </ul> 
		    </li>
		    <li>메모 : <%=request.getParameter("memo")%></li>
	    </ul>
		 </div>
  <%} else { %>
    <div>
		  <h1>Form Handling Example</h1>

		  <form class="form-horizontal" method="post">
			<fieldset>
				<div id="legend">
					<legend>Sign up</legend>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="name">Name</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" placeholder="홍길동" name="name">
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label" for="pwd">Password</label>
					<div class="col-sm-3">
						<input type="password" class="form-control" name="pwd">
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label" for="email">E-mail</label>
					<div class="col-sm-3">
						<input type="email" class="form-control" placeholder="hong@abc.com" name="email">
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label">Country</label>
					<div class="col-sm-3">
						<select name="country" class="form-control">
							<option value="KR">Korea</option>
							<option value="US">USA</option>
							<option value="JA">Japan</option>
							<option value="CN">China</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label">Gender</label>
					<div class="col-sm-offset-2 radio">
						<label> 
						  <input type="radio" value="m" name="gender" checked="checked"> male
						</label> 
					</div>
					<div class="col-sm-offset-2 radio">
						<label> 
						  <input type="radio" value="f"	name="gender"> female
						</label>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label">Favorites</label>
					<div class="col-sm-offset-2 checkbox">
						<label class="checkbox"> 
						  <input type="checkbox" name="favorites" value="IU"> IU
						</label> 
						<label class="checkbox"> 
						  <input type="checkbox" name="favorites" value="2NE1"> 2NE1
						</label> 
						<label class="checkbox"> 
						  <input type="checkbox" name="favorites" value="Sistar"> Sistar
						</label> 
						<label class="checkbox"> 
						  <input type="checkbox" name="favorites" value="Kara"> Kara
						</label> 
						<label class="checkbox"> 
						  <input type="checkbox" name="favorites" value="Girl's generation"> Girl's	generation
						</label>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label">Memo</label>
					<div class="col-sm-3">
						<div class="textarea">
							<textarea name="memo"></textarea>
						</div>
					</div>
				</div>

				<div class="form-group">
					<input type="submit" class="col-sm-offset-2 btn btn-default btn-primary">
				</div>
			</fieldset>
		  </form>
    </div>
	<% } %>
  </div>
  <jsp:include page="share/footer.jsp"></jsp:include>
</body>
</html>

