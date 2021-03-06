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
form{
	height:100%;
}

</style>
<script>
   $(document).ready(function(){
	   function search() {
		   if((myPW.id.value != null) && (myPW.email.value!=null)) {
			   $("#ok").click(function(){
				   alert("메일을 전송했습니다. 메일함을 확인하세요.");
				 
			   });
			   myPW.submit();
		   }else if(myPW.id.value == null) {
			   alert("아이디를 입력하세요.")
		   }else if(myPW.email.value == null) {
			   alert("이메일주소를 입력하세요.")
		   }
	   } 
   });
</script>
<form action="${pageContext.request.contextPath }/member/sendPW.do" name="myPW" method="post" onsubmit="return(validate());">
	<div class="container-fluid" id="joinbottom">
		<div class="row">
			<div class="well center-block">
				<div class="well-header" id="title">
					<h2 class="text-center">
						<b>비밀번호 찾기</b>
					</h2>
					<h5 class="text-center">비밀번호를 잊어버리셨나요?</h5>
					<hr>
				</div>
				<div class="col-lg-8" style="padding-left: 0px;">
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="glyphicon glyphicon-user"></i>
									</div>
									<input type="text" placeholder="ID" name="id" id="id"
										class="form-control" required>
								</div>
							</div>
						</div>
		
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="glyphicon glyphicon-envelope"></i>
								</div>
								<input type="email" class="form-control" name="email"
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
							<button class="btn btn-success btn-block" id="ok" onclick="search()">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>