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

ul.list-group>li>a[type=button] {
	float: right;
	background-color: #9770f9;
	color: white;
}

ul.list-group>li>a[name=wait] {
	float: right;
	background-color: #808080;
	color: white;
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
			<c:if test="${p.status ne 'y' }">
				<li class="list-group-item">
					<c:choose>
						<c:when test="${p.profile_img ne null}"> 
							<img alt="" class="img-circle" src="/resources/dailygram/thumbnail_mem/${p.profile_img}" width="30"> 
						</c:when>
						<c:otherwise>
							<img alt="" class="img-circle" src="http://www.technifroid-pro.fr/wp-content/uploads/2014/02/Technifroid-F.jpg" width="30">
						</c:otherwise>
					</c:choose>
					<c:if test="${p.status eq 'no' }">
					<a href='${pageContext.request.contextPath }/board/friList.do?writer=${p.id }' style="color: black"><span>${p.id }</span></a>
						<a type="button"
							href='${pageContext.request.contextPath }/friend/addFollow.do?writer=${p.id }&type=5'
							class="btn btn-xs">팔로우</a>
					</c:if> 
					<c:if test="${p.status eq 'wait' }">
					<a href='${pageContext.request.contextPath }/board/friList.do?writer=${p.id }' style="color: black"><span>${p.id }</span></a>
						<a type="button" name="wait"
							href='${pageContext.request.contextPath }/friend/cancelFollow.do?writer=${p.id }&type=6'
							class="btn btn-xs">팔로우 요청 취소</a>
					</c:if>
				</li>
			</c:if>
			</c:forEach>
			</c:if>
			</ul>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>
	