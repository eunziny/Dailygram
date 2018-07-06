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
	$(document).ready(function() {
		//$("button#add").click(function(e) {
		  $(document).on('click', 'button#add', function() {	
			if($("input[name='tagname']").val() == "") {
				alert("금지할 해시태그를 입력해주세요.");
			} else {
				alert("정말 해당 해시태그를 검색 금지어로 설정하시겠습니까?");
			}

		});
		
		//$("button#delete, a#eye").on('click', function(e) {
		$(document).on('click', 'button#delete, a#eye', function() {
			alert("해당  해시태그를 다시 활성화 시키시겠습니까?");
			var checkArr = []; //배열 초기화
			
			$("input[name='tagcancle']:checked").each(function(e) {
				checkArr.push($(this).val());
			});
			
 			$.ajax ({
				url: "${pageContext.request.contextPath}/admin/allclick.do",
				type: 'post',
				dataType: 'text',
				data: {
					valueArrTest:checkArr
				},
				dataType: 'json',
				success: function(data) {
 					if(data != "") {
						$('.list-group').remove();
						$(data).each(function () {
							console.log("뿌려질 태그>>>>>>" + this.tagname);
							 var str = "";
								str += "<ul class='list-group'>"
									+ "<li class='list-group-item'>"
									+ "<form id='eyeclick' class='eyeclick'>"
									+ "<div class='checkbox'>"
									+ "<input type='checkbox' class='checkb' name='tagcancle' id='checkbox1'/>"
									+ "<label for='checkbox1'>"+this.tagname+"</label>"
									+ "</div>"
									+ "<div class='pull-right action-buttons'>"
									+ "<a href='#' class='eye' id='eye'><span class='glyphicon glyphicon-eye-open'></span></a>"
									+ "</div>"
									+ "</form>"
									+ "</li>"
									+ "</ul>";
							$(".panel-body").append(str);
 						});	
					}
				},
				error : function(xhr, status, error) {
	                 alert("에러발생");
				}
			});
		});
	});
</script>
<body>
	<div class="container">
		<div class="col-md-12">
			<div class="row">
				<div class="panel-group">
					<div class="panelspace">
						<h1 class="panel-heading panel-danger" align="center"><b>해시태그 관리</b></h1>
						<hr>
						<div align="center">
							<form action="${pageContext.request.contextPath}/admin/tagblock.do" method="post">
							<input type="text" id="tagname" name="tagname" placeholder="금지할 해시태그를 입력하세요." style="width:300px; height:35px; vertical-align:middle;">
							<button id="add" type="submit" class="btn btn-danger" style="height:35px; vertical-align:middle;"><i class="glyphicon glyphicon-eye-close"></i>추가</button>
							</form>
						</div>
						
						<h4 class="panel-heading panel-danger" align="left"><b>검색 금지된 해시태그</b></h4>
						<div>
							<button id="delete" class="btn btn-success pull-right"><i class="glyphicon glyphicon-eye-open"></i>활성화</button>
						</div>
						<br> <br>
						<div class="panel-body">
							<ul class="list-group">
								<c:forEach var="bl" items="${blocklist}">
								<li class="list-group-item">
									<form id="eyeclick" class="eyeclick">
									<div class="checkbox">
										<input type="checkbox" class="checkb" name="tagcancle"
											id="checkbox1" value="${bl.tagname}" /><label for="checkbox1">${bl.tagname}</label>
									</div>
									<div class="pull-right action-buttons">
										<a href="#" class="eye" id="eye"><span class="glyphicon glyphicon-eye-open"></span></a>
									</div>
									</form>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div><!-- /.row -->
		</div>
	</div>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>
</body>
</html>