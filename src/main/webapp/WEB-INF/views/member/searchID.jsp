<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>    
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.well {
	padding: 35px;
	padding-left: 30px;
	box-shadow: 0 0 10px #666666;
	margin: 4% auto 0;
	width: 450px;
}

#joinbottom {
	margin-bottom: 70px;
}

</style>
<script>
$(function(){
	$("#findId").click(function() {
		var email = $("#email").val();
		if ($("#email").val() == '') {
			alert("이메일을 입력하세요");
			return;
		} 
});
</script>
<form action="${pageContext.request.contextPath }/member/idResult.do" name="myID" method="post" onsubmit="return(validate());">
	<div class="container-fluid" id="joinbottom">
		<div class="row">
			<div class="well center-block">
				<div class="well-header" id="title">
					<h2 class="text-center">
						<b>아이디 찾기</b>
					</h2>
					<h5 class="text-center">아이디를 잊어버리셨나요?</h5>
					<hr>
				</div>				
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="glyphicon glyphicon-envelope"></i>
								</div>
								<input type="email" class="form-control" name="email" id="email"
									placeholder="E-Mail" required>
							</div>
						</div>
					</div> 
				</div>
				<br>
				<div class="row widget">
					<div class="col-lg-12">
						<div class="col-lg-6">
							<a href="${pageContext.request.contextPath }/member/loginForm.do" class="btn btn-primary btn-block" id="cancel">취소</a>
						</div>
						<div class="col-lg-6">
							<button class="btn btn-success btn-block" id="findId">확인</button>
							<div align="center" id=result>
							<strong><span id="resultdata"></span></strong>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>