<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="Sign Up" />
	</jsp:include>

	<div class="container">
		<div class="row">
			<div class="col-md-12 page-info">
				<div class="pull-left">
					Total <b>${users.numItems }</b> users
				</div>
				<div class="pull-right">
					<b>${users.page }</b> page / total <b>${users.numPages }</b> pages
				</div>
			</div>
		</div>
		<table class="table table-bordered table-stripped">
			<thead>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Email</th>
					<th>Gender</th>
					<th>Country</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="user" items="${users.list }">
					<tr>
						<td><a href="user?id=${user.id}"><c:out
									value="${user.userid}" /></a></td>
						<td><c:out value="${user.name}" /></td>
						<td><c:out value="${user.email}" /></td>
						<td><c:out value="${user.genderStr}" /></td>
						<td><c:out value="${user.country}" /></td>
						<td><a href="user?op=update&id=${user.id}"
							class="btn btn-default btn-xs">modify</a> <a href="#"
							class="btn btn-default btn-xs btn-danger" data-action="delete"
							data-id="${user.id}">delete</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<jsp:include page="page.jsp">
			<jsp:param name="currentPage" value="${users.page}" />
			<jsp:param name="url" value="user" />
			<jsp:param name="startPage" value="${users.startPageNo}" />
			<jsp:param name="endPage" value="${users.endPageNo}" />
			<jsp:param name="numPages" value="${users.numPages}" />
		</jsp:include>

		<div class="form-group">
			<a href="user?op=signup" class="btn btn-default btn-primary">Sign
				Up</a>
		</div>
	</div>
	<jsp:include page="share/footer.jsp" />
</body>
<script>
	$(function() {
		$("a[data-action='delete']").click(function() {
			if (confirm("정말로 삭제하시겠습니까?")) {
				location = 'user?op=delete&&id=' + $(this).attr('data-id');
			}
			return false;
		});
	});
</script>
</html>