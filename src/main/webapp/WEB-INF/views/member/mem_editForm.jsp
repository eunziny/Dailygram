<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/container/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<script>
$(function(){
	$("button[type=submit]").click(function(){
		if( $("input[type=file]").val() == "" ){
	         alert('업로드할 이미지를 선택해주세요.');
	         return false;
	      }
	});
	$("input[type=file]").change(function(){
    	if( $("input[type=file]").val() != "" ){
        	var ext = $('#file').val().split('.').pop().toLowerCase();
        	if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
            	alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
            	$("input[type=file]").val("");
            	return;
            }
        }
   });
});
</script>

<div class="container-fluid" id="memeditbottom">
	<div class="row">
		<div class="well center-block">
		<form action="${pageContext.request.contextPath}/member/memEdit.do" 
			method="post" enctype="multipart/form-data" onsubmit="return(validate());">
			<div class="well-header" id="title">
				<h2 class="text-center"><b>프로필 수정</b></h2>
				<h5 class="text-center">회원님의 정보를 수정하세요.</h5>
				<hr>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="col-lg-6" id="profileimg">
						<c:set var="profile" value="${sessionScope.memInfo.profile_img}" /> 
						  <c:choose>
							<c:when test="${profile ne null}"> 
								<img class="img-circle"
									src="/dailygram/thumbnail_mem/${sessionScope.memInfo.profile_img}"
									width="150" height="150" alt="Profile Image">
							</c:when>
							<c:otherwise>
								<img class="img-circle"
			                        src="http://www.technifroid-pro.fr/wp-content/uploads/2014/02/Technifroid-F.jpg"
			                        width="150" height="150" alt="Profile Image">
							</c:otherwise>
						  </c:choose>
					</div>
					<div class="col-lg-6" >
						<h2>${sessionScope.memInfo.id }</h2>
						<br>
						<h5 style="font-weight: bold">프로필 사진 수정</h5>
						<input type="file" name="file" accept=".png, .jpg, .jpeg, .gif" />
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
							<input type="password" minlength="4" maxlength="20" placeholder="Password" name="pwd" class="form-control" required>
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
							<input type="text" placeholder="User Name" name="name" value="${sessionScope.memInfo.name }" class="form-control">
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
							<input type="text" placeholder="Self-Introduction" name="intro" value="${sessionScope.memInfo.intro }"
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
							<input type="date" name="birthday" placeholder="Date Of Birth" class="form-control" id="birthday" value="${sessionScope.memInfo.birthday }" required>
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
							<input type="email" class="form-control" name="email" placeholder="E-Mail" value="${sessionScope.memInfo.email}" required>
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
									placeholder="Postal Code" value="${sessionScope.memInfo.address}" required readonly>

							</div>

						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<a href="#" type="button" class="btn btn-info" id="search">우편번호 검색</a>
						</div>
					</div>
				</div>
				<div class="col-lg-12">
					<div class="input-group">
						<div class="input-group-addon">
							<i class="glyphicon glyphicon-list-alt"></i>
						</div>
						<input type="text" class="form-control" name="address"
							placeholder="Address" value="${sessionScope.memInfo.address}" required readonly>

					</div>
				</div>
			</div>
			<br>
			
			<div class="row">
				<div class="col-lg-12">
					<div class="form-group">
						<div class="input-group">
							<b>Gender</b>&nbsp;&nbsp;&nbsp;&nbsp;
							<c:set var="gender" value="${sessionScope.memInfo.gender }" /> 
						    <c:choose>
								<c:when test="${gender eq 'm'}"> 
								<label><input name="gender" type="radio" value="m" checked required>Male</label>&nbsp;&nbsp;
                               	<label><input name="gender" type="radio" value="f">Female</label>
                               	</c:when>
                             	<c:when test="${gender eq 'f'}"> 
								<label><input name="gender" type="radio" value="m">Male</label>&nbsp;&nbsp;
                               	<label><input name="gender" type="radio" value="f" checked required>Female</label>
                               	</c:when>
                            </c:choose>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-lg-12">
					<div class="form-group">
						<div class="input-group">
							<b>Public</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<c:set var="publicyn" value="${sessionScope.memInfo.publicyn }" /> 
						    <c:choose>
						    	<c:when test="${publicyn eq 'y'}"> 
								<label><input name="publicyn" type="radio" value="y" checked required>공개</label>&nbsp;&nbsp;&nbsp;
								<label><input name="publicyn" type="radio" value="n">비공개</label>
								</c:when>
								<c:when test="${publicyn eq 'n'}"> 
								<label><input name="publicyn" type="radio" value="y">공개</label>&nbsp;&nbsp;&nbsp;
								<label><input name="publicyn" type="radio" value="n" checked required>비공개</label>
								</c:when>
							</c:choose>
						</div>
					</div>
				</div>
			</div>

			<div class="row widget">
				<div class="col-lg-12">
					<div class="col-lg-6">
						<a href="${pageContext.request.contextPath }/board/myList.do" 
							type="button" class="btn btn-primary btn-block" id="cancle">취소</a>
					</div>
					<div class="col-lg-6">
						<Button type="submit" class="btn btn-success btn-block" id="ok">저장</Button>
					</div>
				</div>
			</div>
			</form>
			<br>
			<a href="${pageContext.request.contextPath }/member/out.do?id=${sessionScope.memInfo.id }" id="del">회원탈퇴</a>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>