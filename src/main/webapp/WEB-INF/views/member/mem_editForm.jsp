<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/container/header.jsp"%>
<style>
.well {
	padding: 35px;
	padding-left: 30px;
	box-shadow: 0 0 10px #666666;
	margin: 4% auto 0;
	width: 450px;
}

.profileimg {
	text-align: center;
}

#profileimg {
	text-align: center;
}

#memeditbottom {
	margin-bottom: 70px;
}
</style>
<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script> -->
<form action="#" name="myForm" method="post" onsubmit="return(validate());">
	<div class="container-fluid" id="memeditbottom">
		<div class="row">
			<div class="well center-block">
				<div class="well-header" id="title">
					<h2 class="text-center"><b>프로필 수정</b></h2>
					<h5 class="text-center">회원님의 정보를 수정하세요.</h5>
					<hr>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-6" id="profileimg">
							<img class="img-circle"
								src="http://www.technifroid-pro.fr/wp-content/uploads/2014/02/Technifroid-F.jpg"
								width="150" height="150" alt="Profile Image">
						</div>
						<div class="col-lg-6" >
							<h3>${sessionScope.memInfo.id }</h3>
							<br> <a href="#" class="btn btn-info" id="imgedit">프로필	사진 수정</a>
						</div>
					</div>
				</div>
                <br>
           		<div class="row">
					<div class="col-lg-12">
					   	<div class="form-group">
						    	<div class="input-group">
    								<div class="input-group-addon">
    									<i class="glyphicon glyphicon-user"></i>
    								</div>
    								<input type="text" name="id" class="form-control" value="${sessionScope.memInfo.id }" readonly>
    							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="glyphicon glyphicon-lock"></i>
								</div>
								<input type="password" minlength="8" maxlength="20" placeholder="Password" name="pwd" class="form-control" required>
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
								<input type="text" placeholder="User Name" name="name" class="form-control">
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
								<input type="date" name="birthday" placeholder="Date Of Birth" class="form-control" id="birthday" required>
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
								<input type="email" class="form-control" name="mail" placeholder="E-Mail" required>
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
								<lable><b>Gender</b></lable>&nbsp;
								<input name="gender" type="radio" value="Male" checked required>Male&nbsp;
                                <input name="gender" type="radio" value="Female">Female
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-group">
								<lable><b>Public</b></lable>&nbsp;&nbsp;
								<input name="public" type="radio" value="y" checked required>공개&nbsp;
								<input name="public" type="radio" value="n">비공개</div>
						</div>
					</div>
				</div>

				<div class="row widget">
					<div class="col-lg-12">
						<div class="col-lg-6">
							<a href="#" class="btn btn-primary btn-block" id="cancle">취소</a>
						</div>
						<div class="col-lg-6">
							<a href="#" class="btn btn-success btn-block" id="ok">저장</a>
						</div>
					</div>
				</div>
				<br>
				<a href="${pageContext.request.contextPath }/member/out.do?id=${sessionScope.memInfo.id }" id="del">회원탈퇴</a>
			</div>
		</div>
	</div>
</form>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>