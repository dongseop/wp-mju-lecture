<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<title>AJAX Sample1</title>
	<script src='js/jquery-1.8.2.min.js'></script>
	<style type="text/css">
	html{font: 12px/18px "맑은 고딕", "Malgun Gothic", "굴림", "Gulim", Verdana, Arial, Tahoma;}
	.suggest_box {
    position: absolute;
    left: 120px;
    margin: 0px 0px 0px 0px;
    width: 150px;
    background-color: #212427;
    color: #fff;
	}
	.suggest_box li {
			margin: 0px 0px 3px 0px;
			padding: 5px;
			cursor: pointer;
			list-style-type:none;
	}
	.suggest_box li:hover {
			background-color: #659CD8;
	}
	</style>
</head>
<body>
<div>
Type your country: <input type="text" id="country" size="20">
<img src="images/ajax-loader.gif" style="display:none;" id="loading">
<div class="suggest_box" id="suggest_box">
</div> 
<p style="color:silver">
The word country has developed from the Latin contra meaning "against", used in the sense of "that which lies against, or opposite to, the view", i.e. the landscape spread out to the view. From this came the Late Latin term contrata, which became the modern Italian contrada. The term appears in Middle English from the 13th century, already in several different senses.[15]
In English the word has increasingly become associated with political divisions, so that one sense, associated with the indefinite article - "a country" - is now a synonym for state, or a former sovereign state, in the sense of sovereign territory.[16] Areas much smaller than a political state may be called by names such as the West Country in England, the Black Country (a heavily industrialized part of England), "Constable Country" (a part of East Anglia painted by John Constable), the "big country" (used in various contexts of the American West), "coal country" (used of parts of the US and elsewhere) and many other terms.[17]
The equivalent terms in French and Romance languages (pays and variants) have not carried the process of being identified with political sovereign states as far as the English "country", and in many European countries the words are used for sub-divisions of the national territory, as in the German Länder, as well as a less formal term for a sovereign state. France has very many "pays" that are officially recognised at some level, and are either natural regions, like the Pays de Bray, or reflect old political or economic unities, like the Pays de la Loire. At the same time Wales, the United States, and Brazil are also "pays" in everyday French speech.
A version of "country" can be found in the modern French language as contrée, based on the word cuntrée in Old French[17], that is used similarly to the word "pays" to define regions and unities, but can also be used to describe a political state in some particular cases. The modern Italian contrada is a word with its meaning varying locally, but usually meaning a ward or similar small division of a town, or a village or hamlet in the countryside.
</p>
</div>
</body>

<script type="text/javascript">
function fill(name) {
	// 아이템이 선택되었을때 처리 
	$('#country').val(name);
	$('#suggest_box').fadeOut();
}

$(function() {
	$('#country').keyup(function() {
		// 입력창에 키가 눌러진 경우 이벤트 처리
		// Ajax로 값을 전송
		$.post('ContrySuggest', {query: $('#country').val()}, 
			function(data) {
				$('#suggest_box').html(data).show();
			}
		);
	});
	// Ajax 진행 중임을 표시
	$('#loading').ajaxStart(function() {$(this).show();});
	$('#loading').ajaxComplete(function() {$(this).hide();});
});
</script>
</html>