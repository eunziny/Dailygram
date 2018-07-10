<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>    
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- fontawesome icon-->
<script src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
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

#joinbottom {
	margin-bottom: 70px;
}

.intro {
	text-align: center;
	color: purple;
}
.captcha {
	overflow:hidden;
}
.captcha_child {
	float:left;
}
.captcha_child_two {
	float:right;
}
.refreshBtn:hover {
	background-color: #a8a8a8;
	color: white;
	border: 1px solid #a6a6a6;
}
.refreshBtn {
	color: black;
	border: 1px solid #888;
	width: 110px;
	border-radius: 5px;
	height: 25px;
	display: block;
	padding: 2px 15px;
	margin: 5px 0px;
}
</style>
<script>
   $(document).ready(function(){
	   $('#idCheck').click(function(){
		   if($("#id").val()=="") {
			   alert("먼저 id를 입력해주세요.");
			   return false;
		   }
		   $.post("/daily/member/idCheck.do",{id:$("#id").val()})
		   .done(function(data){
			   $("#idResult").text(data);
		   });
	   });
	   
      $("#join").click(function(){
         if($("#idResult").text().trim()=="사용가능한 아이디입니다."){
            $("form").submit();
         }else{
            alert("id중복체크 먼저해주요.");
         }
      });
   });
   
   //우편번호 검색
   $(function(){
    $("#searchBtn").click(function(e){
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
                $("#zip_codeList").append(html);
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
  	    $("#address1").val(address);
  	    $("#zip_code").val(zip_code);
  	} //우편번호 검색 end
   
   function audio() {
		var rand = Math.random();
		var url = '/daily/member/captchaAudio.do';
		$.ajax({
			url: url,
			type: 'POST',
			dataType: 'text',
			data: 'rand=' + rand,
			async: false,
			success: function(resp) {
				var uAgent = navigator.userAgent;
				var soundUrl = '/daily/member/captchaAudio.do?rand='+rand;
				
				//브라우저별 오디오 처리
				if(uAgent.indexOf('Trident') > -1 || uAgent.indexOf('MSIE') > -1){
					winPlayer(soundUrl);
				} else if (!!document.createElement('audio').canPlayType){
					try {
						new Audio(soundUrl).play();
					} catch(e) {
						winPlayer(soundUrl);
					}
				} else {
					window.open(soundUrl, '', 'width=1,height=1');
				}
			}
		});
   }
   
   function refreshBtn(type) {
	   var rand = Math.random();
	   var url = "/daily/member/captchaImg.do?rand="+rand;
	   $('#captchaImg').attr("src", url);
   }
   
   function winPlayer(objUrl) {
	   $('#captchaAudio').html('<bgsound src="' + objUrl + '">');
   }
   
</script>
<form action="${pageContext.request.contextPath }/member/join.do" name="myForm" method="post" onsubmit="return(validate());">
	<div class="container-fluid" id="joinbottom">
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
									<input type="text" placeholder="ID" name="id" id="id"
										class="form-control" required>
								</div>
							</div>
						</div>
						<div class="col-lg-4">
							<div class="form-group">
								<a class="btn btn-info" id="idCheck">idCheck</a>
							</div>
						</div>
						<div class="col-lg-12" id="idResult"></div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-addon">
									<i class="glyphicon glyphicon-lock"></i>
								</div>
								<input type="password" minlength="4" maxlength="20"
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
									<i class="glyphicon glyphicon-user"></i>
								</div>
								<input type="text" placeholder="Self-Introduction" name="intro"
									class="form-control">
							</div>
							<div class="intro"><b>자기소개 #해시태그를 작성하면 친구를 추천해드립니다.</b></div>
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
								<input type="email" class="form-control" name="email"
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
									<input type="text" class="form-control" name="zip_code" id="zip_code"
										placeholder="Postal Code" required readonly>

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
													<a class="btn btn-warning" id="searchBtn">검색</a>
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
													<tbody id="zip_codeList"></tbody>
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
							<input type="text" class="form-control" name="address" id="address1"
								placeholder="Address" required>

						</div>
					</div>
				</div>
				<br>
				
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-group">
								<b>Gender</b>&nbsp;
								<label><input name="gender" type="radio" value="m" checked required>Male</label>&nbsp;
								<label><input name="gender" type="radio" value="f">Female</label>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
						<label for="captcha" style="diplay:block;">자동 가입 방지</label>
							<div class="captcha">
								<div class="captcha_child">
									<img id="captchaImg" title="캡차 이미지" alt="캡차 이미지" src="captchaImg.do">
									<div id="captchaAudio" style="display: nene;"></div>
								</div>
								<div class="captcha_child_two">
									<a onclick="javascript:refreshBtn()" class="refreshBtn">
										<i class="fas fa-sync-alt" aria-hidden="true"></i>&nbsp;새로고침</a>
									<a onclick="javascript:audio()" class="refreshBtn">
										<i class="fas fa-volume-up" aria-hidden="true"></i>&nbsp;음성듣기</a>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<input type="text" id="captcha" name="captcha" autocomplete="off" required />
						</div>
					</div>
				</div>
				
				<div class="row widget">
					<div class="col-lg-12">
						<div class="col-lg-6">
							<a href="${pageContext.request.contextPath }/member/loginForm.do" class="btn btn-primary btn-block" id="cancle">취소</a>
						</div>
						<div class="col-lg-6">
							<button class="btn btn-success btn-block" id="join">회원가입</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>