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
//우편번호 검색
$(document).ready(function(){
 $("#searchBtn2").click(function(e){
     e.preventDefault();
     var query = $("input[name='query']").val();
     console.log("query :" + query);
     $.ajax({
         url : "${pageContext.request.contextPath}/member/zip_search.do",
         data : {query : query},
         type : "POST",
         dataType : "json",
         //dataType : "xml",
         success : function(result){
             $("#zip_codeList").empty();
             var html = "";
             if(result.errorCode != null && result.errorCode != ""){
                 html += "<tr>";
                 html += "    <td colspan='2'>";
                 html +=            result.errorMessage;
                 html += "    </td>";
                 html += "</tr>";
             }
             else{
                 var list = result.list;
                 
                 for(var i = 0; i < list.length; i++){
                     html += "<tr>";
                     html += "    <td>";
                     
                     var zipcode = list[i].zip_code; //우편번호
                     var address = list[i].address; //주소

                     html += list[i].zip_code;
                     html += "</td>";
                     html += "<td>";
                     html += '<a href="#" onclick="put(\'' + list[i].address + '\',\'' + list[i].zip_code + '\')">' + address + '</a>';
                     html += "</td>";
                     html += "</tr>";
                 }
             }
             // 완성된 html(우편번호 list)를 zip_codeList밑에 append
             $("#zip_codeList2").append(html);
			}
     });
   });
});

//원하는 우편번호 선택시 함수 실행
function put(address,zip_code){
	    var address = address;
	    var zip_code = zip_code;
	    // 모달창 닫기
	    $("#zip_codeModal").modal("hide");
	    $("#address2").val(address);
	    $("#zip_code1").val(zip_code);
	} //우편번호 검색 end

$(function(){
	$("button[type='submit']").click(function(){
		if( $("input[type='file']").val() == "" ){
	         alert('업로드할 이미지를 선택해주세요.');
	         return false;
	      }
	});
 	$("input[type='file']").change(function(){
    	if( $("input[type='file']").val() != "" ){
        	var ext = $('#file').val().split('.').pop().toLowerCase();
        	if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
            	alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
            	$("input[type='file']").val("");
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
									src="/resources/dailygram/thumbnail_mem/${sessionScope.memInfo.profile_img}"
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
						<input type="file" name="file" id="file" accept=".png, .jpg, .jpeg, .gif" />
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
								<input type="text" class="form-control" name="zip_code" id="zip_code1"
									placeholder="Postal Code" value="${sessionScope.memInfo.zip_code}" required readonly>

							</div>

						</div>
					</div>
					<div class="col-lg-4">
						<div class="form-group">
							<a class="btn btn-info" id="search" data-toggle="modal" data-target="#zip_codeModal">우편번호 검색</a>
						</div>
					</div>
					<!-- 모달창 -->
						<div class="modal fade" id="zip_codeModal">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header text-center">
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">×</span>
										</button>
										<h3 class="modal-title" id="myModalLabel"><b>우편번호 검색</b></h3>
									</div>
									<div class="modal-body text-center">
											<div class="input-group">
												<span class="input-group-addon">동 입력</span> 
													<input type="text" class="form-control" name="query" id="query">
												<span class="input-group-btn">
													<a class="btn btn-warning" id="searchBtn2">검색</a>
												</span>
											</div>
										<div>
											<div style="width: 100%; height: 400px; overflow: auto">
												<table class="table text-center">
													<thead>
														<tr>
															<th style="width: 150px;">우편번호</th>
															<th style="width: 600px;">주소</th>
														</tr>
													</thead>
													<tbody id="zip_codeList2"></tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 모달창 end -->
				</div>
				<div class="col-lg-12">
					<div class="input-group">
						<div class="input-group-addon">
							<i class="glyphicon glyphicon-list-alt"></i>
						</div>
						<input type="text" class="form-control" name="address" id="address2"
							placeholder="Address" value="${sessionScope.memInfo.address}" required>

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