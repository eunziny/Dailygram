<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<head>
<title>신고리스트</title>
</head>
<style>
* {
	border-radius: 0 !important;
}

body {
	font-family: 'Open Sans', sans-serif;
}

.panelspace {
	padding-bottom: 5px;
}

.eye {
	color: rgb(0, 0, 0);
}

.trash {
	color: rgb(209, 91, 71);
}

.panel-body {
	padding: 0px;
}

.panel-footer .pagination {
	margin: 0;
}

.panel .glyphicon, .list-group-item .glyphicon {
	margin-right: 5px;
}

.panel-body .radio, .checkbox {
	display: inline-block;
	margin: 0px;
}

.list-group-item:hover, a.list-group-item:focus {
	text-decoration: none;
	background-color: rgb(245, 245, 245);
}

.list-group {
	margin-bottom: 0px;
}

.panel-body input[type=checkbox]:checked+label {
	text-decoration: line-through;
	color: rgb(128, 144, 160);
}

.checkbox input[type=checkbox], .checkbox-inline input[type=checkbox],
	.radio input[type=radio], .radio-inline input[type=radio] {
	margin-left: 0px;
}
</style>
<script>
	$(function() {
		$("a.eye").click(function() {
			alert("게시물로 이동");
		});

		$("a.trash").click(function() {
			alert("해당 게시물 바로 삭제");
		});

		$("a.badge").click(function() {
				window.open("http://localhost:8080/ui/chargeMemList.jsp",
						" 해당 게시물 신고자 리스트",
						"width=450, height=550, top=70 left=400, scrollbars=yes");
		});
		
		$("button#delete").click(function() {
			alert("정말 삭제하시겠습니까?");
		});
	});
</script>
<body>
	<!-- 관리자 헤더 들어갈 자리 -->
	<div class="container">
		<div class="col-md-12">
			<div class="row">
				<div class="panel-group">
					<div class="panelspace">
						<h2 class="panel-heading panel-danger">Charge List</h2>
						<hr>
						<div>
							<button id="delete" class="btn btn-danger pull-right">삭제</button>
						</div>
						<br> <br>
						<div class="panel-body">
							<ul class="list-group">
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox1" value="1" /> <label for="checkbox1">신고1</label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span class="glyphicon glyphicon-eye-open"></span></a> 
										<a href="#" class="trash"><span class="glyphicon glyphicon-trash"></span></a>
										<a href="#" class="badge badge-danger">99</a>	
									</div>
																		
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox2" value="2" /> <label for="checkbox2">
											신고2 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a> <a href="#"
											class="trash"><span class="glyphicon glyphicon-trash"></span></a>
										<a href="#" class="badge badge-danger">42</a>

									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox3" value="3" /> <label for="checkbox3">
											신고3 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a> <a href="#"
											class="trash"><span class="glyphicon glyphicon-trash"></span></a>
										<a href="#" class="badge badge-danger">3</a>

									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox4" value="4" /> <label for="checkbox4">
											신고4 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a> <a href="#"
											class="trash"><span class="glyphicon glyphicon-trash"></span></a>
										<a href="#" class="badge badge-danger">1</a>

									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox5" value="50" /> <label for="checkbox5">
											신고5 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a> <a href="#"
											class="trash"><span class="glyphicon glyphicon-trash"></span></a>
										<a href="#" class="badge badge-danger">1</a>

									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox6" value="50" /> <label for="checkbox6">
											신고6 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a> <a href="#"
											class="trash"><span class="glyphicon glyphicon-trash"></span></a>
										<a href="#" class="badge badge-danger">1</a>

									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox7" value="50" /> <label for="checkbox7">
											신고7 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a> <a href="#"
											class="trash"><span class="glyphicon glyphicon-trash"></span></a>
										<a href="#" class="badge badge-danger">1</a>

									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox8" value="50" /> <label for="checkbox8">
											신고8 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a> <a href="#"
											class="trash"><span class="glyphicon glyphicon-trash"></span></a>
										<a href="#" class="badge badge-danger">1</a>

									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox9" value="50" /> <label for="checkbox9">
											신고9 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a> <a href="#"
											class="trash"><span class="glyphicon glyphicon-trash"></span></a>
										<a href="#" class="badge badge-danger">1</a>

									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox10" value="50" /> <label for="checkbox10">
											신고10 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a> <a href="#"
											class="trash"><span class="glyphicon glyphicon-trash"></span></a>
										<a href="#" class="badge badge-danger">1</a>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- /.row -->
		</div>
	</div>
</body>
</html>
