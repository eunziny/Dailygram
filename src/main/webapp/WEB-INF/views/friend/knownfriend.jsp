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
		<h4 class="panel-heading panel-known"><strong>추천 인물</strong></h4>
		<span class="panel-heading panel-known">최근 인기 게시물과 회원님의 소개글을 바탕으로 추천됩니다. 다른 회원님들과 폭넓은 소통을 나눠보시는건 어떠신가요?</span>
		<hr>
		<div class="panel-body">
			<ul class="list-group">
			<c:if test="${empty list }">다시한번 조회해주시기 바랍니다. </c:if>
			<c:if test="${not empty list }">
			<c:forEach var="p" items="${list }">
				<li class="list-group-item"><img alt="" class="img-circle"
					src="https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w"
					width="30"> 
					<a href=# style="color: black"><span>${p.id }</span></a>
					<button type="button" class="btn btn-xs">팔로우</button>
				</li>
			</c:forEach>
			</c:if>
			</ul>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>
	