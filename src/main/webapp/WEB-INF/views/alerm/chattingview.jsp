<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>    
<!-- SocketJS CDN -->    
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<h2>Chatting</h2>
<h3>id:${sessionScope.memInfo.id}</h3>
<button id="joinList">참여자 리스트</button>
<div id="joindata">
	<ul class="list-group">
	  <li class="list-group-item">hoho</li>
	  <li class="list-group-item">ryeonzzang</li>
	  <li class="list-group-item">roqkfwkman</li>
	  <li class="list-group-item">bobo94</li>
	  <li class="list-group-item">leeke</li>
	</ul>
</div>
<input  type="text" id="message">
<button id="sendBtn">입력</button>
<div id="chatdata"></div>
<div id="data"></div>
<script type="text/javascript">
var sock = new SockJS("<c:url value='/chat'/>");
 sock.onopen = function(evt){
	onOpen(evt);
} 
sock.onmessage = onMessage;
sock.onclose = onClose;
$(function(){
	$("#sendBtn").click(function(){
		console.log('send message');
		sendMessage();
	});
	
	$("#joinList").click(function(){
		sock.send("joinList");
	});
})

function onOpen(evt) 
    {
	sock.send('ryeonzzang'); //1:1 대화 하려고 하는 사람.
    }
function sendMessage(){
	//websocket으로 메세지보내기
	sock.send($("#message").val());
}

//evt 파라미터는 websocket이 보내준 데이터 
function onMessage(evt){
	if(evt.data.indexOf("|") != -1){
		var data = evt.data;
		var sessionid = null;
		var message = null;
		
		//문자열 splite//
		var strArray = data.split('|');
		for(var i = 0; i<strArray.length; i++){
			console.log('str['+i+']:'+strArray[i]);
		}
		
		//현재 세션 id
		var currentuser_session = '${sessionScope.memInfo.id}';
		console.log("현재 세션아이디:"+currentuser_session);
		
		sessionid = strArray[0];//현재 메세지를 보낸 사람의 세션 등록//
		message = strArray[1];//현재 메세지를 저장
		
		//나와 상대방이 보낸 메세지를 구분하여 영역을 나누다.
		if(sessionid == currentuser_session){
			var printHTML = "<div class='well'>";
			printHTML += "<div class='alert alert-info'>";
			printHTML += "<strong>["+sessionid+"] -> "+message+"</strong>";
			printHTML += "</div>";
			printHTML += "</div>";	
			
			$("#chatdata").append(printHTML);
		}else{
			var printHTML = "<div class='well'>";
			printHTML += "<div class='alert alert-warning'>";
			printHTML += "<strong>["+sessionid+"] ->"+message+"</strong>";
			printHTML += "</div>";
			printHTML += "</div>";
			$("#chatdata").append(printHTML);
		}
		
		console.log('chatting data:' +data);
	}else{
		var data = JSON.parse(evt.data);
		$.each(data, function(key, val){ 
			$(".list-group-item").each(function(index,item){
				if(val == $(this).text()){
					var one = "<button class='onetoone'>1:1</button>";
					$(this).css("background","blue");
					$(this).append(one);
					console.log("this.val"+$(this).text());
				}
			})
			console.log("참여자:"+val);
		});
	}
	
}
function onClose(evt){
	$("#data").append("연결이 종료됐습니다.");
}

/* 1:1 버튼 눌렀을 때 */
$(document).on('click','.onetoone',function(){
	alert('1:1 대화!');
});

</script>