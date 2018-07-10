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
      <a href='${pageContext.request.contextPath}/board/newsfeed.do'><img src='${pageContext.request.contextPath }/resources/img/logo.png' id='logo-name'></a>
    </div>
      <div class="col-md-offset-1 col-md-4">
         <form id="searchform" action="${pageContext.request.contextPath }/container/search.do" method="post">
         <div class="input-group">
            <div class="input-group-btn bs-dropdown-to-select-group">
               <button type="button"
                  class="btn btn-search btn-default dropdown-toggle"
                  data-toggle="dropdown" style="width: 110px;">
                  <span class="glyphicon glyphicon-search"></span>
                  <span data-bind="bs-drp-sel-label">검색</span> 
                  <span class="caret"></span>
               </button>
               <ul class="dropdown-menu" role="menu" style="max-height: 300px;">
                  <!-- Loop -->
                  <li id="user" value="아이디"><a href="#">아이디</a></li>
                  <li id="tag" value="해시태그"><a href="#">해시태그</a></li>
                  <!-- END Loop -->
               </ul>
            </div>
            <input type="text" id="searchValue" class="form-control" name="searchValue" placeholder='Search' style="text-align: center;">
            <!-- 자동완성 결과 보여주는 부분 -->
			<div class="auto-body" style="display: none; position:relative; left:13px; top:0px; height:148px; width:184px; margin-left:-12px; clear:both; overflow:hidden; margin-top:-149px; 
			background-color: #fff; border: 1px solid #ccc;">
				<div class='listgroup'>
					<div></div>
				</div>
			</div>
			<!-- 자동완성 결과 end -->
            <span class="input-group-btn">
               <button id="searchBtn" class="btn btn-default">검색</button>
            </span>
         </div>
		</form>   
      </div>
      <!-- <div class="col-md-offset-1 col-md-4"> -->
<!--       <div class="please">
      <div id="search" style="border: #a4a6a5 solid 1px; width: 100px">
         <div id="searchlist"></div>
      </div>
      </div> -->
      <!-- </div> -->
      <div id='right'>
   <div class="col-md-4">
      <ul class="nav navbar-right pull-right top-nav">
         <li class="dropdown dropdown-notification">
         <a href="${pageContext.request.contextPath }/search/look.do"><span class="glyphicon glyphicon-globe"></span></a>   
         </li>
         <li class="dropdown dropdown-notification">
         <a href="${pageContext.request.contextPath }/friend/knownfriend.do?id=${sessionScope.memInfo.id }"><i class="fas fa-users"></i></a>   
         </li>
      <li class="dropdown dropdown-notification"> <a class="dropdown-toggle" href="javascript:;" data-toggle="dropdown" data-hover="dropdown" data-close-others="true" aria-expanded="true"> <i class="fas fa-bell"></i> <span class="badge badge-default"> 5 </span> </a>
         <ul class="dropdown-menu dropdown-menu-alerm">
            <li class="external">
               <h3> <span class="bold">12 pending</span> notifications</h3>
               <a href="page_user_profile_1.html">view all</a> 
            </li>
            <li>
               <ul class="dropdown-menu-list">
                  <li> <a href="javascript:;"> <span class="time">just now</span> <span class="details"> <span class="label label-sm label-icon label-success"> <i class="fa fa-plus"></i> </span> abb님이 좋아요를 눌렀습니다</span> </a> </li>
                  <li> <a href="javascript:;"> <span class="time">3 mins</span> <span class="details"> <span class="label label-sm label-icon label-danger"> <i class="fa fa-bolt"></i> </span> good님이 댓글을 달았습니다:배고파!</span> </a> </li>
                  <li> <a href="javascript:;"> <span class="time">10 mins</span> <span class="details"> <span class="label label-sm label-icon label-warning"> <i class="fa fa-bell-o"></i> </span> wow님이 좋아요를 눌렀습니다</span> </a> </li>
                  <li> <a href="javascript:;"> <span class="time">14 hrs</span> <span class="details"> <span class="label label-sm label-icon label-info"> <i class="fa fa-bullhorn"></i> </span> happy님이 댓글을 남겼습니다:안녕?</span> </a> </li>
                  <li> <a href="javascript:;"> <span class="time">14 hrs</span> <span class="details"> <span class="label label-sm label-icon label-info"> <i class="fa fa-bullhorn"></i> </span> hi님이 댓글을 남겼습니다:야호!</span> </a> </li>
               </ul>
            </li>
         </ul>
      </li>
      <li class="dropdown"> 
         <a href="#" class="dropdown-toggle users" data-toggle="dropdown" aria-expanded="true">
            <c:set var="profile" value="${sessionScope.memInfo.profile_img}" /> 
              <c:choose>
               <c:when test="${profile ne null}"> 
                  <img class="img-circle" width="30" src="/dailygram/thumbnail_mem/${sessionScope.memInfo.profile_img}">
               </c:when>
               <c:otherwise>
                  <img class="img-circle" width="30" src="http://www.technifroid-pro.fr/wp-content/uploads/2014/02/Technifroid-F.jpg">
               </c:otherwise>
              </c:choose>
            <span class="hidden-xs">${sessionScope.memInfo.id }</span> 
         </a>
         <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath }/board/myList.do"><i class="fa fa-fw fa-user"></i> My Page</a></li>
            <li><a href="${pageContext.request.contextPath }/member/mem_editForm.do"><i class="fa fa-fw fa-cog"></i> Edit Profile</a></li>
            <li class="divider"></li>
            <li><a href="${pageContext.request.contextPath }/member/logout.do"><i class="fa fa-fw fa-power-off"></i> Logout</a></li>
         </ul>
      </li>
   </ul>
   </div>
   </div>
  </div>
</div>
</div>
</div>
</div>