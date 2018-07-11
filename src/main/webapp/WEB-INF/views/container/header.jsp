<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- jQuery CDN -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>    
<!-- bootstrap CDN -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- fontawesome icon-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="${pageContext.request.contextPath }/resources/css/header.css" rel="stylesheet">

<!-- 자동완성 -->
<!-- <script src="http://code.jquery.com/jquery-1.7.js" type="text/javascript"></script> -->
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui-css" rel="stylesheet" type="text/s-css" />
<style>
ul.dropdown-menu-list>li>a[type=button] {
	float: right;
	background-color: #9770f9;
	color: white;
}
</style>
<script>
$(document).ready(function(e){
      var $target = "";

      $( document ).on( 'click', '.bs-dropdown-to-select-group .dropdown-menu li', function( event ) {
           $target = $( event.currentTarget );
           $target.closest('.bs-dropdown-to-select-group')
              /* .find('[data-bind="bs-drp-sel-value"]').val($target.attr('value'))
              .end() */
              .children('.dropdown-toggle').dropdown('toggle');
           $target.closest('.bs-dropdown-to-select-group')
              .find('[data-bind="bs-drp-sel-label"]').text($target.attr('value'));/*$target.text()*/
              console.log($target.text());
              
              var v = $target.text(); //아이디 or 해시태그 라는 글자(searchType) 얻어오기
              var v2 = $('<input type="hidden" id="searchType" name="searchType" value="' + v + '" />');
              v2.appendTo($("#searchform")); //searchType의 값을 form태그에 넣어서 같이 전달
                   
           $('input[name=searchValue]').keypress(function(e){
             if(e.which == 13){ //enter   
                $("#searchform").submit();
             }
            });
         return false;
         });

       /* 검색 자동완성 */
       $("#searchValue").autocomplete({
          source : function(request, response) {
             $.ajax({
                url : "${pageContext.request.contextPath }/container/autocomplete.do",
                type : 'post',
                data : {
                   term : request.term
                },
                dataType : 'json',
                success : function(data) {
                   if(data != "") {
                      $(".listgroup").remove();
                      $(data).each(function () {
                         console.log("뿌려질 태그>>>>>>" + this.tagname);
							 var str = "";
								 str += "<div class='listgroup'>"
								     + "<div><a href=\"javascript:selectKeyword('" + this.tagname + "');\">" + this.tagname + "</a></div>"
								 	 + "</div>";
						 $(".auto-body").append(str);    
                         $(".auto-body").show();
                      });
                   }else {
                      $(".auto-body").hide();
                   }
                },
                error : function(xhr, status, error) {
                       alert("에러발생");
                }
             });
         }
       });

         $("#searchBtn").click(function(e) { 
            if ($target == "") { //검색타입을 아무것도 선택하지 않았을 때
             alert("검색타입을 선택하세요.");
           } else {
             $("#searchform").submit();
         }
           return false;
         });  
});

function selectKeyword(keyword) {
	$("#searchValue").val(keyword);
	$(".auto-body").hide();
}

$(function(){
	 function ajaxCall(){
  		$.ajax({
  			url: '${pageContext.request.contextPath}/container/searchalerm.do?id='+'${sessionScope.memInfo.id}',	
  			type:'post',
  			dataType:'json',
  			success:function(data){
  				console.log(data);
  				var id = $('ul.dropdown-menu-list'); 
  				html="";
  				if(data==""){
						html+='<li><span class="label label-sm label-icon label-danger"></span>&nbsp;<strong>새로운 알림이 없습니다.</strong></li>';
				}
  				$(data).each(function (){
  					console.log("내 알림>>>>>>" + this.sender + ", " + this.type + ", " + this.date + ".");	
  					if(this.type=='N'){//팔로우 요청 받았을 경우
		            	console.log('n조건문 들어옴');
		            	html+='<li> &nbsp;&nbsp;<span class="details"><span class="label label-sm label-icon label-success"><i class="fa fa-plus"></i></span>&nbsp;'
		            			+ '<a href="${pageContext.request.contextPath }/board/friList.do?writer=' + this.sender + '">'
		            			+ this.sender
		            			+ '</a><span>님이 팔로우 요청하셨습니다</span><a id="successfollow" class="pull-right" type="button" href="${pageContext.request.contextPath }/friend/successFriend.do?receiver='
		            			+ this.receiver+'&sender='+this.sender
		            			+ '">수락</a></span></li>'; 
		            			console.log('html : '+html);
		            }else if(this.type=='L'){//타인이 내글에 좋아요 누른 경우
		            	console.log('l조건문 들어옴');
		            	html+='<li> &nbsp;&nbsp;<span class="details"><span class="label label-sm label-icon label-warning"><i class="far fa-heart"></i></span>&nbsp;'
		            			+ '<a href="${pageContext.request.contextPath }/board/friList.do?writer=' + this.sender  +'">'
		            			+ this.sender 
		            			+ '님</a>이<a href="${pageContext.request.contextPath }/board/post.do?bseq=' + this.board_seq + '">회원님의 글</a>'
		            			+ '에 좋아요 하셨습니다.</span></a></li>';
		            }	
		            console.log('조건문 밖');
  				});
  				id.html(html).show();
  		}
  	});
	 }
  	setInterval(ajaxCall(), 3000);	
  	$( document ).on( 'click', 'a#successfollow', function(  ) {
  		alert('수락하시겠습니까?'); 
  		location.href='${pageContext.request.contextPath }/board/myList.do';
  	});
});

/* function makeMemoList(memos) {
    var memocnt = memos.memolist.length;
    $('#memolist').children('div').remove();
    var memostr = '';
    for(var i=0;i<memocnt;i++) {
       var memo = memos.memolist[i];
       memostr += '<div class="col-sm-12" data-seq="' + memo.mseq + '" data-userid="' + memo.userid + '" style="border-bottom: 2px solid #ecf0f1; margin-top: 15px; margin-bottom: 15px;">';
       memostr += '   <div class="pull-right">';
    }
    
} */

</script>
<!------ Include the above in your HEAD tag ---------->

<div id='nav-cntainer' style="box-shadow: 0 0 10px #666666;">
	<div id='navbar'>
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div id='left'>
						<a href='${pageContext.request.contextPath}/board/newsfeed.do?id=${sessionScope.memInfo.id}'><img
							src='${pageContext.request.contextPath }/resources/img/logo.png' id='logo-name'></a>
					</div>
					<div class="col-md-offset-1 col-md-4">
						<form id="searchform"
							action="${pageContext.request.contextPath }/container/search.do" method="post" style="position:relative;">
							<div class="input-group">
								<div class="input-group-btn bs-dropdown-to-select-group">
									<button type="button"
										class="btn btn-search btn-default dropdown-toggle"
										data-toggle="dropdown" style="width: 110px;">
										<span class="glyphicon glyphicon-search"></span> <span
											data-bind="bs-drp-sel-label">검색</span> <span class="caret"></span>
									</button>
									<ul class="dropdown-menu" role="menu"
										style="max-height: 300px;">
										<!-- Loop -->
										<li id="user" value="아이디"><a href="#">아이디</a></li>
										<li id="tag" value="해시태그"><a href="#">해시태그</a></li>
										<!-- END Loop -->
									</ul>
								</div>
								<input type="text" id="searchValue" class="form-control"
									name="searchValue" placeholder='Search'
									style="text-align: center;">
								<span class="input-group-btn">
									<button id="searchBtn" class="btn btn-default">검색</button>
								</span>
							</div>
							<!-- 자동완성 결과 보여주는 부분 -->
							<div class="auto-body"
								style="display: none; position: absolute; left: 122px; top: 182px; height: 155px; width: 186px; margin-left: -12px; clear: both; overflow: hidden; overflow-y:scroll; margin-top: -149px; background-color: #fff; border: 1px solid #ccc;">
								<div class='listgroup'>
									<div></div>    
								</div>
							</div>
							<!-- 자동완성 결과 end -->
						</form>
					</div>
					<div id='right'>
						<div class="col-md-4">
							<ul class="nav navbar-right pull-right top-nav">
								<li class="dropdown dropdown-notification"><a
									href="${pageContext.request.contextPath }/chat/chatting.do"><i
										class="fas fa-comments"></i></a></li>
								<li class="dropdown dropdown-notification"><a
									href="${pageContext.request.contextPath }/search/look.do"><span
										class="glyphicon glyphicon-globe"></span></a></li>
								<li class="dropdown dropdown-notification"><a
									href="${pageContext.request.contextPath }/friend/knownfriend.do?id=${sessionScope.memInfo.id }"><i
										class="fas fa-users"></i></a></li>
								<li class="dropdown dropdown-notification"><a
									class="dropdown-toggle" href="javascript:;"
									data-toggle="dropdown" data-hover="dropdown"
									data-close-others="true" aria-expanded="true"> <i
										class="fas fa-bell"></i> <%-- <span class="badge badge-default">
		<%int alermsize = Integer.parseInt((String) session.getAttribute("alermSize")); 
		if(alermsize>0){ %> <strong>NEW</strong> <%} %></span> --%></a>
									<ul class="dropdown-menu dropdown-menu-alerm">
										<ul class="dropdown-menu-list" id="alerm">
											<!-- <li> <a href="javascript:;"> 
							<span class="time">just now</span> 
								<span class="details"> 
									<span class="label label-sm label-icon label-success"> 
									<i class="fa fa-plus"></i> 
								</span> abb님이 좋아요를 눌렀습니다
							</span> 
						</a> 
					</li> -->
										</ul>
									</ul>
								</li>
								<li class="dropdown"><a href="#"
									class="dropdown-toggle users" data-toggle="dropdown"
									aria-expanded="true"> <c:set var="profile"
											value="${sessionScope.memInfo.profile_img}" /> <c:choose>
											<c:when test="${profile ne null}">
												<img class="img-circle" width="30"
													src="/dailygram/thumbnail_mem/${sessionScope.memInfo.profile_img}">
											</c:when>
											<c:otherwise>
												<img class="img-circle" width="30"
													src="http://www.technifroid-pro.fr/wp-content/uploads/2014/02/Technifroid-F.jpg">
											</c:otherwise>
										</c:choose> <span class="hidden-xs">${sessionScope.memInfo.id }</span>
								</a>
									<ul class="dropdown-menu">
										<li><a
											href="${pageContext.request.contextPath }/board/myList.do"><i
												class="fa fa-fw fa-user"></i> My Page</a></li>
										<li><a
											href="${pageContext.request.contextPath }/member/mem_editForm.do"><i
												class="fa fa-fw fa-cog"></i> Edit Profile</a></li>
										<li class="divider"></li>
										<li><a
											href="${pageContext.request.contextPath }/member/logout.do"><i
												class="fa fa-fw fa-power-off"></i> Logout</a></li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- <div class="col-md-offset-1 col-md-4"> -->
	</div>
</div>