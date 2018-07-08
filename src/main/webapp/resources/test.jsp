<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/sockjs.js"></script>
<script type="text/javascript">
    var wsUri = "ws://localhost:8080/daily/count";
    function send_message() {
        websocket = new WebSocket(wsUri);
        websocket.onopen = function(evt) {
            onOpen(evt);
        };
        websocket.onmessage = function(evt) {
            onMessage(evt);
        };
        websocket.onerror = function(evt) {
            onError(evt);
        };
    }
    function onOpen(evt) 
    {
    	websocket.send("like|20|hoho|ryeonzzang"); //좋아요,글번호,sender,receiver
    	websocket.send("")
    }
    function onMessage(evt) {
    		$('#count').append(evt.data);
    		console.log("뭐왔나:"+evt.data);
    }
    function onError(evt) {
    }
    $(document).ready(function(){
    		send_message();
    });
</script>
<span id="count" class="badge bg-theme"></span>
