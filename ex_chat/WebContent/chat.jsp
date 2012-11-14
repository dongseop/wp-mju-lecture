<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Ajax Sample</title>
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/json2.js"></script>
	<style type="text/css">
	html {
		font: 12px/18px "맑은 고딕", "Malgun Gothic", "굴림", "Gulim", Verdana, Arial,
			Tahoma;
	}
	
	h1 {
		font: bold 28px/46px Georgia, serif;
	}
	
	.name {
		background: #b0a57b;
		color: white;
		margin-right: 10px;
		font-weight: bold;
		padding: 3px;
		width: 100px;
		text-align: right;
		display: inline-block;
	}
	
	#messages {
		width: 95%;
	}
	
	.message {
		background: #ece8da;
		margin-bottom: 1px;
	}
	
	.mine {
		background: #fffcd9;
	}
	
	.time {
		font: 9px Tahoma;
		color: #b0af9f;
		margin: 5px 0;
	}
	
	.mine .name {
		background: #c0c460;
	}
	
	input#name {
		width: 100px;
	}
	
	input#msg {
		width: 70%;
	}
	
	input#send {
		width: 50px;
	}
	
	#error {
		width: 95%;
		background: #fcd2ec;
		color: #a30808;
		padding: 10px;
	}
	</style>
	</head>

	<body>
		<h1>Ajax Chat</h1>
		<div>
			<div id="messages"></div>
			<div id="error" style="display: none"></div>
			<form id="chat_form">
				<input id="name" type="text" size="10" value="${current_name}"> 
				<input id="msg" type="text" size="50"> 
				<input id="send" type="button" value="send"> 
				<img src="images/ajax-loader.gif" style="display: none;" id="loading">
			</form>
		</div>
	</body>
	<script type="text/javascript">
		var last_id = -1; // unknown
		var timer = null;
	
		function receive() {
			// Ajax로 마지막 받은 번호 이후의 메시지를 json으로 받음.
	
			$.get('ChatServlet', {
				last : last_id
			}, function(data) {
				// 전달받은 JSON을 파싱/처리
	
				if (data.msgs.length > 0 && last_id < data.last) {
					last_id = data.last;
					$(data.msgs).each(
							function(i, item) {
	
								// 각 메시지를 해당위치에 추가
								$("<div class='message " + item.mine + "'></div>")
										.append(
												"<span class='name'>" + item.name
														+ "</span>").append(
												item.content).append(
												"<span class='time'>" + item.time
														+ "</span>").appendTo(
												"#messages");
							});
	
					// 새로운 메시지가 있을 경우, 입력 폼이 보이도록 스크롤
					$('html,body').animate({
						scrollTop : $("#chat_form").offset().top
					}, 1000);
				}
			});
		}
		$(function() {
			$("#send").click(function() {
				// 이름이나 내용이 없으면 포커스를 옮기고 종료
				if ($("#name").val().length == 0) {
					alert("이름을 입력하여 주세요.");
					$("#name").focus();
					return;
				}
				if ($("#msg").val().length == 0) {
					alert("내용을 입력하여 주세요.");
					$("#msg").focus();
					return;
				}
	
				// Ajax로 글 내용 전달
				$.post('ChatServlet', {
					name : $("#name").val(),
					content : $("#msg").val()
				}, function(data) {
					if (data.indexOf("ERROR") != -1) {
						// 에러가 있으면 내용 출력
						$("#error").text(data).fadeIn();
	
					} else {
						$("#error").fadeOut();
					}
				});
	
				// 글을 쓴 후에는 메시지창의 내용을 없앰.
				$("#msg").val("");
			});
	
			// 메시지 창에서 Enter를 누르면 SEND버튼을 누르도록.
			$('#msg').keydown(function(event) {
				if (event.keyCode == 13)
					$("#send").click();
			});
	
			// Ajax 진행 중임을 표시
			$('#loading').ajaxStart(function() {
				$(this).show();
			});
			$('#loading').ajaxComplete(function() {
				$(this).hide();
			});
	
			receive();
	
			// 1초마다 새로운 메시지를 받도록 지정
			setInterval(receive, 1000);
	
		});
	</script>
</html>
