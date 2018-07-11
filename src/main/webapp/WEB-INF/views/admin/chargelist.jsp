<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
			alert("해당 게시물로 이동하시겠습니까?");
		});
		
		$("button#delete").click(function() {
			alert("정말 삭제하시겠습니까?");
			
			var checkArr = []; //배열 초기화
			
			$("input[name='chargedel']:checked").each(function(e) {
				checkArr.push($(this).val());
			});
			
			$.ajax ({
				url: "${pageContext.request.contextPath}/admin/postdel.do",
				type: 'post',
				dataType: 'text',
				data: {
					valueArrTest:checkArr
				},
				dataType: 'json',
				success: function(data) {
					if(data != "") {
						$('.list-group').remove();
						$(data).each(function (){
							var str = "";
								str += "<ul class='list-group'>"
									+ "<li class='list-group-item'>"
									+ "<div class='checkbox'>"
									+ "<input type='checkbox' class='checkb' name='chargedel' value='"+this.board_seq+"'/>"
									+ "<label for='checkbox1'>"+this.writer+"</label>"
									+ "</div>"
									+ "<div class='pull-right action-buttons'>"
									+ "<a href='${pageContext.request.contextPath}/board/post.do?bseq="+this.board_seq+"' class='eye'><span class='glyphicon glyphicon-eye-open'></span></a>"
									+ "<a href='${pageContext.request.contextPath}/admin/chargeperson.do?bseq="+this.board_seq+"' class='badge badge-danger'>"+this.sirencnt+"</a>"
									+ "</div>"		
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
										<input type="checkbox" class="checkb" name="chargedel"
											value="${cl.board_seq}" /> <label for="checkbox1">${cl.writer}</label>
									</div>
									<div class="pull-right action-buttons">
										<a href="${pageContext.request.contextPath}/board/post.do?bseq=${cl.board_seq}" class="eye"><span class="glyphicon glyphicon-eye-open"></span></a> 
										<a href="${pageContext.request.contextPath}/admin/chargeperson.do?bseq=${cl.board_seq}" class="badge badge-danger">${cl.sirencnt}</a>	
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
</body>
</html>