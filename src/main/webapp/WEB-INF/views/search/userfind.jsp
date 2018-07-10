<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
div.panel-group {
	width: 65%;
	margin: auto;
	margin-top: 30px;
	margin-bottom: 50px;
	min-height: 100%;
}

ul.list-group>li>button {
	float: right;
	background-color: #9770f9;
	color: white;
}
</style>
<div class="panel-group">
	<div class="panelspace">
		<h4 class="panel-heading panel-known">원하는  친구를 찾으셨나요?</h4>
		<hr>
		<div class="panel-body">
			<ul class="list-group">
				<c:forEach var="s" items="${list}">
					<li class="list-group-item">
						<c:choose>
							<c:when test="${s.profile_img ne null}">
								<img class="img-circle"
									src="/resources/dailygram/thumbnail_mem/${s.profile_img}" width="30">
							</c:when>
							<c:otherwise>
								<img alt="" class="img-circle"
									src="http://www.technifroid-pro.fr/wp-content/uploads/2014/02/Technifroid-F.jpg"
									width="30">
							</c:otherwise>
						</c:choose>
						<a href="${pageContext.request.contextPath}/board/friList.do?writer=${s.id}" style="color: black"><span>${s.id}</span></a>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>
