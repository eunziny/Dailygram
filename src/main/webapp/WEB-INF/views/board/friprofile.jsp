<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.useravatar img {
	width: 100%;
	height: 100%;
	max-width: 160px;
	max-height: 160px;
	-webkit-border-radius: 50%;
	-moz-border-radius: 50%;
	border-radius: 50%;
	border: 5px solid rgba(255, 255, 255, 0.5);
}

.follow {
	text-align: center;
}

#read,#cancelread, button{
	background-color: #9770f9;
	font-weight: bold;
	color:white;
}

.follow a {
	color: black;
	font-weight: bold;
	font-size: 20px;
}
</style> 
<script>
$(function(){
	$('a#read').click(function(){
		alert("구독 성공하셨습니다.");
		$('a#read').css('display', 'none');
		$('a#cancelread').css('display', 'block');
		
	});
	
	$('a#cancelread').click(function(){
		alert("구독 취소하였습니다.");
		$('a#cancelread').css('display', 'none');
		$('a#read').css('display', 'block');
	});
});
</script>
<br>
<div class="container">
	<div class="row">
		<div class="col-lg-offset-1 col-lg-10 col-lg-offset-1">
			<div class="well row">
				<div class="col-md-4 useravatar">
					<a href="#"> <img src="http://placehold.it/160">
					</a>
				</div>
				<div class="col-md-8">
					<div class="row">
						<div class="col-md-3">
							<h2 class="media-heading">${sessionScope.friendId }</h2>
						</div>
						<div class="col-md-6">
							<button type="button" class="btn btn-md btn-block">팔로우</button>
						</div>
						<div class="col-md-3">
							<a id="read" href="${pageContext.request.contextPath }/friend/subscribe.do?id=${sessionScope.friendId }" type="button" class="btn btn-md btn-block">구독</a>
							<a id="cancelread" href="${pageContext.request.contextPath }/friend/canclesubscribe.do?id=${sessionScope.friendId }" type="button" class="btn btn-md btn-block" style="display:none;">구독 취소</a>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-md-3 follow">
							<h4>게시물</h4>
							<a>10</a>
						</div>
						<div class="col-md-3 follow">
							<h4>팔로워</h4>
							<a name="follow"
								href="${pageContext.request.contextPath }/friend/friendfollowerlist.do?id=${sessionScope.friendId }">${sessionScope.friendfollowerCount }</a>
						</div>
						<div class="col-md-3 follow">
							<h4>팔로잉</h4>
							<a name="following"
								href="${pageContext.request.contextPath }/friend/friendfollowinglist.do?id=${sessionScope.friendId }">${sessionScope.friendfollowingCount }</a>
						</div>
						<div class="col-md-3 follow">
							<h4>구독</h4>
							<a name="subscribe" href="#">${sessionScope.friendsubscribeCount }</a>
								<!-- <a name="subscribe" href="${pageContext.request.contextPath }/friend/subscribelist.do?id=${sessionScope.memInfo.id }">${sessionScope.friendsubscribeCount }</a>  -->
						</div>
						<br>
						<h4>${fri.name}</h4>
						<h4>${fri.intro }</h4>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
