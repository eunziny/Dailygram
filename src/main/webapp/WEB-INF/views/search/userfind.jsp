<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/container/header.jsp"%>
<style>
div.panel-group {
	width:65%;
	margin: auto;
	margin-top: 30px;
	margin-bottom: 50px;
	min-height: 100%;
}

ul.list-group>li>button{
	float:right;
	background-color: #9770f9;
	color:white;
}
</style>
<div class="panel-group">
	<div class="panelspace">
		<h4 class="panel-heading panel-known">원하는  친구를 찾으셨나요?</h4>
		<hr>
		<div class="panel-body">
			<ul class="list-group">
				<c:forEach var="s" items="${list}">
				<li class="list-group-item"><img alt="No-Profile" class="img-circle"
					src="/board/${s.profile_img }"
					width="30"> <a href=# style="color: black"><span>${s.id}</span></a>
					<button type="button" class="btn btn-xs">팔로우</button>
				</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>
	