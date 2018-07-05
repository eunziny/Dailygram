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

#edit {
	background-color: #9770f9;
	font-weight: bold;
}

.follow a {
	color: black;
	font-weight: bold;
	font-size: 20px;
}
</style>
<!------ Include the above in your HEAD tag ---------->
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
						<div class="col-md-5">
							<h2 class="media-heading">${sessionScope.memInfo.id }</h2>
						</div>
						<div class="col-md-4">
							<a href="#" class="btn btn-default" id="edit">프로필 수정</a>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-md-3 follow">
							<h4>게시물</h4>
							<a href="#">10</a>
						</div>
						<div class="col-md-3 follow">
							<h4>팔로워</h4>
							<a name="follow"
								href="${pageContext.request.contextPath }/friend/followerlist.do?id=${sessionScope.memInfo.id }">${sessionScope.followerCount }</a>
						</div>
						<div class="col-md-3 follow">
							<h4>팔로잉</h4>
							<a name="following"
								href="${pageContext.request.contextPath }/friend/followinglist.do?id=${sessionScope.memInfo.id }">${sessionScope.followingCount }</a>
						</div>
						<div class="col-md-3 follow">
							<h4>구독</h4>
							<a name="subscribe"
								href="${pageContext.request.contextPath }/friend/subscribelist.do?id=${sessionScope.memInfo.id }">${sessionScope.subscribeCount }</a>
						</div>
					</div>
					<br>
					<h4>${sessionScope.memInfo.name }</h4>
					<h4>${sessionScope.memInfo.intro }</h4>
				</div>
			</div>
		</div>
	</div>
</div>
