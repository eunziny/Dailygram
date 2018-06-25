<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.well {
	padding: 35px;
	padding-left: 30px;
	box-shadow: 0 0 10px #666666;
	margin: 4% auto 0;
	width: 450px;
}

body {
	background-color: #dedede;
}

.input-group-addon {
	background-color: #9770f9;
	color: #d17d00;
}

.profileimg {
	text-align: center;
}
</style>
<!-- <link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script> -->
<form action="#" name="myForm" method="post" onsubmit="return(validate());">
	<div class="container-fluid">
		<div class="row">
			<div class="well center-block">
				<div class="well-header" id="title">
					<h2 class="text-center">
						<b>Sign Up</b>
					</h2>
					<h5 class="text-center">Dailygram에 가입하여 일상을 공유하세요.</h5>
					<hr>
				</div>

				<div class="row">
					<div class="col-lg-12">
						<!--<div class="form-group">-->
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
									<input type="text" placeholder="ID" name="id"
										class="form-control" required>
								</div>
							</div>
						</div>
						<div class="col-lg-4">
							<div class="form-group">
								<a href="#" class="btn btn-info" id="idCheck">idCheck</a>
							</div>
						</div>
						<div class="col-lg-12" id="dup"></div>
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
								<input type="email" class="form-control" name="mail"
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
								<lable>
								<b>Gender</b></lable>
								&nbsp; <input name="gender" type="radio" value="Male" checked
									required>Male&nbsp; <input name="gender" type="radio"
									value="Female">Female
							</div>
						</div>
					</div>
				</div>

				<div class="row widget">
					<div class="col-lg-12">
						<div class="col-lg-6">
							<a href="#" class="btn btn-primary btn-block" id="cancle">Cancle</a>
						</div>
						<div class="col-lg-6">
							<a href="#" class="btn btn-success btn-block" id="ok">Sing Up</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</form>
