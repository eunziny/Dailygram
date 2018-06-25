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
<title>신고자 리스트</title>
</head>
<script>
	$(function(){
		$('a#delete').click(function(){
			close();
		});
	});
</script>
<body>
	<div class="container">
		<div class="col-md-12">
			<div class="row">
				<div class="panel-group">
					<div class="panelspace">
						<h2 class="panel-heading panel-danger">해당 게시물 신고자 리스트</h2>
						<hr>
						<div class="panel-body">
							<ul class="list-group">
								<li class="list-group-item">
								<img alt="" class="img-circle" src="https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w" width="30"> 
				<a href=# style="color:black"><span>User1</span></a>									
								</li>
								<li class="list-group-item">
								<img alt="" class="img-circle" src="https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w" width="30"> 
				<a href=# style="color:black"><span>User2</span></a> 
								</li>
								<li class="list-group-item">
									<img alt="" class="img-circle" src="https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w" width="30"> 
				<a href=# style="color:black"><span>User3</span></a>
								</li>
								<li class="list-group-item">
									<img alt="" class="img-circle" src="https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w" width="30"> 
				<a href=# style="color:black"><span>User4</span></a> 
								</li>
								<li class="list-group-item">
									<img alt="" class="img-circle" src="https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w" width="30"> 
				<a href=# style="color:black"><span>User5</span></a>
								</li>
								<li class="list-group-item">
									<img alt="" class="img-circle" src="https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w" width="30"> 
				<a href=# style="color:black"><span>User6</span></a>
								</li>
							</ul>
							<div align="center">
							<a id="delete" class="btn btn-success">닫기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /.row -->
		</div>
	</div>
</body>
</html>
