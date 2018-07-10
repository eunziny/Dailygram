<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	font-size: 25px;
	color: red;
}
</style>
<div class="container-fluid" id="idResult">
	<div class="row">
		<div class="col-lg-12">
			<div align="center" id=result>
				<p>
					회원님의 아이디는 <strong><span id="resultdata"> ${result}</span></strong>입니다.
				</p>
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