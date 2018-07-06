<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/admin_header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

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

		$("a.badge").click(function() {
				window.open("http://localhost:8080/daily/admin/chargeMemList.do",
						" 해당 게시물 신고자 리스트",
						"width=450, height=550, top=70 left=400, scrollbars=yes");
		});
		
		$("button#delete").click(function() {
			alert("정말 삭제하시겠습니까?");
		});
	});
</script>
<body>
	<div class="container">
		<div class="col-md-12">
			<div class="row">
				<div class="panel-group">
					<div class="panelspace">
						<h1 class="panel-heading panel-danger" align="center"><b>신고 게시물 관리</b></h1>
						<hr>
						<h4 class="panel-heading panel-danger" align="left"><b>신고 게시물 작성자</b></h4>
						<div>
							<button id="delete" class="btn btn-danger pull-right">삭제</button>
						</div>
						<br> <br>
						<div class="panel-body">
							<ul class="list-group">
								<c:forEach var="cl" items="${chargeList}">
								<li class="list-group-item">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="checkbox[]"
											id="checkbox1" value="1" /> <label for="checkbox1">${cl.writer}</label>
									</div>
									<div class="pull-right action-buttons">
										<a href="${pageContext.request.contextPath}/board/post.do?bseq=${cl.board_seq}" class="eye"><span class="glyphicon glyphicon-eye-open"></span></a> 
										<!-- <a href="#" class="trash"><span class="glyphicon glyphicon-trash"></span></a> -->
										<a href="#" class="badge badge-danger">99</a>	
									</div>
								</li>
								</c:forEach>
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