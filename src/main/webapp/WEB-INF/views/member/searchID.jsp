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
   $(document).ready(function(){
   });
</script>
<form action="${pageContext.request.contextPath }/member/searchID.do" name="myID" method="post" onsubmit="return(validate());">
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
						<div class="profileimg">
							<img class="img-circle" src="http://www.technifroid-pro.fr/wp-content/uploads/2014/02/Technifroid-F.jpg"
								width="150" height="150" alt="Profile Image">
						</div>
					</div>
				</div>
				<br>

				<div class="row">
					<div class="col-lg-12">
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
						<div class="col-lg-12" id="idResult"></div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="glyphicon glyphicon-lock"></i>
								</div>
								<input type="password" minlength="8" maxlength="20"
									placeholder="Password" name="pwd" class="form-control" required>
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="glyphicon glyphicon-user"></i>
								</div>
								<input type="text" placeholder="User Name" name="name"
									class="form-control">
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="glyphicon glyphicon-user"></i>
								</div>
								<input type="text" placeholder="Self-Introduction" name="intro"
									class="form-control">
							</div>
						</div>
					</div>
				</div>

 				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="glyphicon glyphicon-calendar"></i>
								</div>
								<input type="date" name="birthday" placeholder="Date Of Birth"
									class="form-control" id="birthday" required>
							</div>
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

				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-8" style="padding-left: 0px;">
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<i class="glyphicon glyphicon-list-alt"></i>
									</div>
									<input type="text" class="form-control" name="address"
										placeholder="Postal Code" required readonly>

								</div>

							</div>
						</div>
						<div class="col-lg-4">
							<div class="form-group">
								<a href="#" class="btn btn-info" id="search">우편번호 검색</a>
							</div>
						</div>
					</div>
					<div class="col-lg-12">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="glyphicon glyphicon-list-alt"></i>
							</div>
							<input type="text" class="form-control" name="address"
								placeholder="Address" required readonly>

						</div>
					</div>
				</div>
				<br>
				
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-group">
								<b>Gender</b>&nbsp;
								<label><input name="gender" type="radio" value="m" checked required>Male</label>&nbsp;
								<label><input name="gender" type="radio" value="f">Female</label>
							</div>
						</div>
					</div>
				</div>

				<div class="row widget">
					<div class="col-lg-12">
						<div class="col-lg-6">
							<a href="${pageContext.request.contextPath }/member/loginForm.do" class="btn btn-primary btn-block" id="cancle">취소</a>
						</div>
						<div class="col-lg-6">
							<button class="btn btn-success btn-block" id="join">회원가입</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>