<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/admin_header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>해시태그 관리</title>
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
		$("button#add").click(function() {
			alert("정말 해당 해시태그를 검색 금지어로 설정하시겠습니까?");
		});
		
		$("a.eye").click(function() {
			alert("해당 해시태그를 다시 활성화 시키시겠습니까?");
		});

		$("button#delete").click(function() {
			alert("선택한  해시태그들을 다시 활성화 시키시겠습니까?");
		});
	});
</script>
<body>
	<div class="container">
		<div class="col-md-12">
			<div class="row">
				<div class="panel-group">
					<div class="panelspace">
						<h2 class="panel-heading panel-danger">Delete HashTag List</h2>
						<hr>
						<div align="center">
							<form action="${pageContext.request.contextPath}/admin/tagblock.do" method="post">
							<input type="text" name="tagname" placeholder="금지할 해시태그를 입력하세요." style="width:300px; height:35px; vertical-align:middle;">
							<button id="add" type="submit" class="btn btn-danger" style="height:35px; vertical-align:middle;"><i class="glyphicon glyphicon-eye-close"></i>추가</button>
							</form>
						</div>
						<hr>
						<div>
							<button id="delete" class="btn btn-success pull-right"><i class="glyphicon glyphicon-eye-open"></i>활성화</button>
						</div>
						<br> <br>
						<div class="panel-body">
							<ul class="list-group">
								<c:forEach var="bl" items="${blocklist}">
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox1" value="1" /> <label for="checkbox1">${bl.tagname}</label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span class="glyphicon glyphicon-eye-open"></span></a>
									</div>
								</li>
								</c:forEach>
								<!-- <li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox2" value="2" /> <label for="checkbox2">
											유영철 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a>
									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox3" value="3" /> <label for="checkbox3">
											강호순 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a>
									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox4" value="4" /> <label for="checkbox4">
											다단계 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a>
									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox5" value="50" /> <label for="checkbox5">
											신천지 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a>
									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox6" value="50" /> <label for="checkbox6">
											대마초 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a>
									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox7" value="50" /> <label for="checkbox7">
											마약 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a>
									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox8" value="50" /> <label for="checkbox8">
											곤지암 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a>
									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox9" value="50" /> <label for="checkbox9">
											살인 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a>
									</div>
								</li>
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox10" value="50" /> <label for="checkbox10">
											혐오 </label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye"><span
											class="glyphicon glyphicon-eye-open"></span></a>
								</li> -->
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- /.row -->
		</div>
	</div>
	<br><br><br>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>
</body>
</html>

