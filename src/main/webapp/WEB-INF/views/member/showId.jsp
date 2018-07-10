<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
#result {
	padding-top: 10%;
}

#foot {
	padding-top: 50%;
}

#resultdata {
	font-size: 20px;
	color: red;
}

p {
	font-size: 20px;
}
</style>
<div class="container-fluid" id="idResult">
	<div class="row">
		<div class="col-lg-12">
			<div align="center" id=result>
			<c:set var = "result" value="${result}"/>
			<c:choose>
			<c:when test="${result != null}">
				<p>
					회원님의 아이디는 <strong><span id="resultdata"> ${result}</span></strong>입니다.
				</p>
			</c:when> 
			<c:otherwise>
				<p>
					<strong><span id="resultdata"> 입력하신 정보와 일치하는 아이디가 존재하지 않습니다.</span></strong>
				</p>
			</c:otherwise>
			</c:choose>
			</div>
		</div>
		<div class="col-lg-offset-4 col-lg-4 col-lg-offset-4" align="center">
			<a href="${pageContext.request.contextPath }/member/loginForm.do" class="btn btn-success btn-block" id="ok">확인</a>
		</div>
	</div>

</div>
<div id="foot">
	<%@ include file="/WEB-INF/views/container/footer.jsp"%>
</div>