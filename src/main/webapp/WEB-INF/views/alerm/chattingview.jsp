<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../container/header.jsp"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>    
<!-- SocketJS CDN -->    
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<style>
div.panel-group {
	width:65%;
	margin: auto;
	margin-top: 30px;
	margin-bottom: 50px;
	min-height: 100%;
}
div.input-group{
	margin-bottom: 15px;
}
div.joinList{
	margin-top : 15px;
	margin-bottom: 15px;
}
</style>
<div class="panel-group">
<h2><i class="far fa-comments"></i> Chat</h2>
<button id="joinList" class="btn btn-light">채팅 참여자 리스트</button>
<div id="joindata">
	<ul class="list-group"></ul>
</div>
<div class="input-group">
     <input id="message" type="text" class="form-control input-sm" placeholder="Type your message here..." />
     <span class="input-group-btn">
         <button class="btn btn-primary btn-sm" id="sendBtn">
             Send</button>
     </span>
</div>
<div id="chatdata" style="overflow:auto"></div>
<div id="data"></div>
</div>
<script type="text/javascript">
$('#scrollDiv').scrollTop($('#scrollDiv').prop('scrollHeight'));

var sock = new SockJS("<c:url value='/chat'/>");
sock.onmessage = onMessage;
sock.onclose = onClose;
$(function(){
	$("#sendBtn").click(function(){
		sendMessage();
		$("#message").val("");
	});
	
	$("#joinList").click(function(){
		if($(".list-group").hasClass("active") == true){
			$('.list-group-item').remove();
			$(".list-group").removeClass("active");
		}else{
			$(".list-group").addClass("active");
			sock.send("joinList");
		}

		
	});
})


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
			printHTML += "<strong>@"+sessionid+" : "+message+"</strong>";
			printHTML += "</div>";
			printHTML += "</div>";
			$("#chatdata").append(printHTML);
		}else{
			var printHTML = "<div class='well'>";
			printHTML += "<div class='alert alert-warning'>";
			printHTML += "<strong>@"+sessionid+" : "+message+"</strong>";
			printHTML += "</div>";
			printHTML += "</div>";
			$("#chatdata").append(printHTML);
		}
		
		console.log('chatting data:' +data);
	}else if(evt.data.indexOf("@") != -1){
		var data = evt.data;
		var connectId = null;
		//현재 세션 id
		var currentuser_session = '${sessionScope.memInfo.id}';
		
		//문자열 splite//
		var strArray = data.split('@');
		connectId = strArray[0]; //접속한 사용자
		message = strArray[1];   // 메세지
		
		if(connectId == currentuser_session){
			var printHTML = "<div class='well'>";
			printHTML += "<div class='alert alert-info'>";
			printHTML += "<strong>@"+connectId+" : "+message+"</strong>";
			printHTML += "</div>";
			printHTML += "</div>";
			$("#chatdata").append(printHTML);
		}else{
			var printHTML = "<div class='well'>";
			printHTML += "<div class='alert alert-warning'>";
			printHTML += "<strong>@"+connectId+" : "+message+"</strong>";
			printHTML += "</div>";
			printHTML += "</div>";
			$("#chatdata").append(printHTML);
		}
		
				
	}else{
		var data = JSON.parse(evt.data);
		$.each(data, function(key, val){ 
			var joinList = "<li class='list-group-item'>"+val+"</li>";
			$("ul.list-group").append(joinList);
			console.log("참여자:"+val);
		});
	}
	
}
function onClose(evt){
	$("#data").append("연결이 종료됐습니다.");
}


</script>
<%@ include file="../container/footer.jsp"%>