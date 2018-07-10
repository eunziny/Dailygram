<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/container/header.jsp"%>
<%@ include file="/WEB-INF/views/board/friprofile.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>팔로잉 리스트</title>
</head>
<style>
div.panel-group {
	width:65%;
	margin: auto;
	margin-top: 30px;
}
ul.list-group>li>a[type=button]{
	float:right;
	background-color: #9770f9;
	color:white;
}

ul.list-group>li>a[name=wait]{
	float:right;
	background-color: #808080;
	color:white;
}
</style>
<body>
<div class="panel-group">
	<div class="panelspace">
		<h4 class="panel-heading panel-known" ><strong>팔로잉</strong></h4>
		<hr>
		<div class="panel-body">
			<ul class="list-group">
				<c:if test="${empty list }">다시한번 조회해주시기 바랍니다. </c:if>
				<c:if test="${not empty list }">
				<c:forEach var="p" items="${list }">
					<li class="list-group-item">
					<c:choose>
						<c:when test="${p.profile_img ne null}"> 
							<img alt="" class="img-circle" src="/resources/dailygram/thumbnail_mem/${p.profile_img}" width="30"> 
						</c:when>
						<c:otherwise>
							<img alt="" class="img-circle" src="http://www.technifroid-pro.fr/wp-content/uploads/2014/02/Technifroid-F.jpg" width="30">
						</c:otherwise>
					</c:choose>
						<c:if test="${p.status eq 'y' }">
					<a href='${pageContext.request.contextPath }/board/friList.do?writer=${p.id }' style="color: black"><span>${p.id }</span></a>
						<a type="button" href='${pageContext.request.contextPath }/friend/cancelFollow.do?writer=${p.id }&type=4' class="btn btn-xs">팔로잉 취소</a>
					</c:if>
					<c:if test="${p.status eq 'no' }">
					<a href='${pageContext.request.contextPath }/board/friList.do?writer=${p.id }' style="color: black"><span>${p.id }</span></a>
						<a type="button" href='${pageContext.request.contextPath }/friend/addFollow.do?writer=${p.id }&type=3' class="btn btn-xs">팔로우</a>
					</c:if>
					<c:if test="${p.status eq 'me' }">
					<a href='${pageContext.request.contextPath }/board/myList.do' style="color: black"><span>${p.id }</span></a>
					</c:if>
					<c:if test="${p.status eq 'wait' }">
					<a href='${pageContext.request.contextPath }/board/friList.do?writer=${p.id }' style="color: black"><span>${p.id }</span></a>
						<a type="button" name="wait" href='${pageContext.request.contextPath }/friend/cancelFollow.do?writer=${p.id }&type=4' class="btn btn-xs">팔로우 요청 취소</a>
					</c:if>
					</li>
				</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>
</div>
<br><br><br>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>
</body>
</html>