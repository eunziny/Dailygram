<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>    
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet">
<title>login</title>
<div class="container" id="logintop">
	<div class="row">
		<div class="col-lg-12">
			<img class="profile-img"
				src="${pageContext.request.contextPath }/resources/img/logo.png"
				alt="Dailygram">
			<form class="form-signin" method="post"
				action="${pageContext.request.contextPath }/member/login.do">
				<input type="text" name="id" class="form-control" placeholder="ID"> 
				<input type="password" name="pwd" class="form-control" placeholder="PASSWORD">
				<button class="button btn-block btn-lg loginBtn" type="submit" style="width:297px;">
					Login</button>
			</form>
			<div class="form-find">
				<button class="button btn-lg " style="width:138px;" onclick="location.href='${pageContext.request.contextPath }/member/searchID.do'">아이디 찾기</button>
				<button class="button btn-lg" onclick="location.href='${pageContext.request.contextPath }/member/searchPW.do'">비밀번호 찾기</button>
				<a href="${pageContext.request.contextPath }/member/joinForm.do"
					class="text-center new-account">회원가입</a>
			</div>
		</div>
	</div>
</div>
