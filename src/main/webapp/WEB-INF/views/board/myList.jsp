<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/container/header.jsp"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	margin-bottom: 70px;
}

.post_register {
	padding-bottom:5%;
}

 #add {
  background-color: #9770f9; 
  border: none;
  color: white;
  text-align: center;
}
</style>
<br>
<%@ include file="/WEB-INF/views/board/profile.jsp"%>
<div class="container">
 <div class="post_register">
 <div class="col-lg-offset-10 col-lg-2">
  <button type="submit" class="btn btn-primary" id = "add" 
  	onclick="location.href='${pageContext.request.contextPath}/board/form.do'">게시물 등록
 </button>
</div>
</div>
</div>

<c:if test="${empty list }">
<div class="row" id="lookbottom">
	<div class="container">
		<div class="col-lg-12">
			<div class="gallery_product col-lg-offset-4 col-lg-4 col-lg-offset-4">
			<h4> 게시물이 없습니다. 게시물을 등록하세요! </h4>
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
				<a href="${pageContext.request.contextPath}/board/post.do?board_seq=${i.board_seq}">
				<img src="/thumbnail/${i.img}"></a>
			</div>
		</c:forEach>
		</div>
	</div>
</div>		
</c:if>

<%@ include file="/WEB-INF/views/container/footer.jsp"%>