<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/container/header.jsp"%>
<style>
/* .container {
	width: 1000px;
} */
.col-lg-12 {
	padding:0;
}
.col-lg-4 {
	padding-right:0;
	padding-left:5px;
}
.lookimg {
	width:100%;height:350px;margin-bottom:5px
}

#looktop {
	margin-top: 30px;
	margin-bottom: 50px;
}

#lookbottom {
	margin-top: 30px;
	margin-bottom: 70px;
}

</style>
<!-- <link
   href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
   rel="stylesheet" id="bootstrap-css">
<script
   src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script> -->
<div class="row">
	<div class="container">
		<div class="col-lg-12" id="looktop">
			<div class="col-lg-offset-1 col-lg-3" id="looktag_img">
				<img class="img-circle"
					src="http://item.ssgcdn.com/83/19/94/item/0000005941983_i1_500.jpg"
					width="200" height="200" alt="No Image">
			</div>
			<div class="col-lg-8">
				<br> <br>
				<h2>
					<a href="#" class="looktag">${s.tagname}</a>
				</h2>
				<h4>게시물 86,529</h4>
			</div>
		</div>
	</div>
</div>
<div class="row" id="lookbottom">
	<div class="container">
		<div class="col-lg-12">
			<c:forEach var="s" items="${list }">
			<div class="gallery_product col-lg-4">
				<a href="${pageContext.request.contextPath}/board/post.do?bseq=${s.board_seq}"><img src="/board/${s.img }" class="lookimg"></a>
			</div>
			</c:forEach>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>