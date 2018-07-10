<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath }/resources/css/friList.css" rel="stylesheet">

<%@ include file="/WEB-INF/views/container/header.jsp"%>

<br>
<%@ include file="/WEB-INF/views/board/friprofile.jsp"%>
<c:if test="${empty list }">
<div class="row" id="lookbottom">
	<div class="container">
		<div class="col-lg-12">
			<div class="gallery_product col-lg-offset-5 col-lg-4">
			<h4> 게시물이 없습니다. </h4>
		   </div>
		</div>
	</div>
</div>
</c:if>	
<c:if test="${not empty list }">
	<div class="row" id="lookbottom">
	<div class="container">
		<div class="col-lg-12">
		<c:forEach var="i" items="${list}">
			<div class="gallery_product col-lg-4">
				<a href="${pageContext.request.contextPath}/board/post.do?bseq=${i.board_seq}">
				<img src="/resources/dailygram/thumbnail/${i.img}"></a>
			</div>
		</c:forEach>
		</div>
	</div>
</div>		
</c:if>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>