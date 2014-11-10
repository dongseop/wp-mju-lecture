<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Facebook Login JavaScript Example</title>
	<link href="css/style.css" rel="stylesheet">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-1.11.0.js"></script>
</head>
<body>
	<jsp:include page="share/header.jsp"></jsp:include>
	<div class="container">
		<h1> Facebook Information </h1>
		
		<fb:login-button id="loginButton" scope="public_profile,user_friends" onlogin="checkLoginState();">
	</fb:login-button>

	<h3>Like Button</h3>
	<div class="well well-large">
		<div class="fb-like" data-href="index.jsp" data-send="false" 
		data-width="450" data-show-faces="true" data-font="tahoma"></div>
	</div>
	<hr></hr>

	<h3> My Facebook Information </h3>
	<div id="me" class="container">
	</div>

	<hr></hr>
	<h3> My Facebook Friend List </h3>
	<div id="friend" class="container">	
	</div>
	<jsp:include page="share/footer.jsp"></jsp:include>
	
<script type="text/template" id="template-table">
	<table class="table table-striped table-bordered">
		<tr>
			<td rowspan="8" class="row-align">
				<img class="picture img-thumbnail" src="" />
			</td>
			<td>Name :</td>
			<td class="name"></td>
		</tr>			
		<tr>
			<td>Facebook Link :</td >
				<td class="link"></td>
			</tr>
			<tr>
				<td>ID :</td><td class="id"></td>
			</tr>
			<tr>
				<td>First Name :</td>
				<td class="first_name"></td>
			</tr>
			<tr>
				<td>Last Name :</td>
				<td class="last_name"></td>
			</tr>
			<tr>
				<td>Gender : </td>
				<td class="gender"></td>
			</tr>
		</table>
	</script>
</body>
</html>
<script type="text/javascript">
// This is called with the results from from FB.getLoginStatus().  
window.fbAsyncInit = function() {
	FB.init({
		appId      : '800287103325790',
	cookie     : true,  // enable cookies to allow the server to access 
						// the session
	xfbml      : true,  // parse social plugins on this page
	version    : 'v2.2' // use version 2.2
});
	FB.getLoginStatus(function(response) {
		statusChangeCallback(response);
	});
};
// Load the SDK asynchronously
(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) return;
	js = d.createElement(s); js.id = id;
	js.src = "//connect.facebook.net/en_US/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

function statusChangeCallback(response) {
	if (response.status === 'connected') {
		getMyData();
		getFriends();
		$('#loginButton').hide();
	} else if (response.status === 'not_authorized') {
		init();
	} else {
		init();
	}
}

// This function is called when someone finishes with the Login
// Button.
function checkLoginState() {
	FB.getLoginStatus(function(response) {
		statusChangeCallback(response);
	});
}


function init(){
	$('loginButton').show();
	$('#me').empty();
	$('#friend').empty();
}
function getMyData(){
	FB.api('/me',function(response){
		addMe(response); 
	});
}
function getFriends(){
	FB.api('/me/friends', function(response) {
		var friends = response.data;
		for(var i in friends){
			getFriendData(friends[i].id);
		}
	});
}
function getFriendData(id){
	FB.api(id,function(response){
		addFriend(response);
	});
}
function addMe(data){
	var template = $('#template-table').html();
	var table = $(template).appendTo('#me');
	addData(data,table);
}
function addFriend(data){
	var template = $('#template-table').html();
	var table = $(template).appendTo('#friend');
	addData(data,table);
}
function addData(data,table){
	$(table).find('.picture').attr("src","https://graph.facebook.com/"+data.id+"/picture?type=large");
	$(table).find('.name').text(data.name);
	$(table).find('.link').text(data.link);
	$(table).find('.id').text(data.id);
	$(table).find('.first_name').text(data.first_name);
	$(table).find('.last_name').text(data.last_name);
	$(table).find('.gender').text(data.gender);
}

</script>

