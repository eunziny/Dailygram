<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../container/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="${pageContext.request.contextPath }/resources/css/post.css" rel="stylesheet">
<style>
input{
	border:none;
}
.ScrollButton {
  position: fixed;   /* 버튼의 위치 고정 */
  right: 10px;       /* x 위치 입력 */
  cursor: pointer;   /* 호버링 했을 때 커서 모양 변경 */
  z-index: 10;       /* 다른 태그에 가려지지 않게 우선순위 변경 */
  display: none;     /* 스크롤 위치에 상관없이 보이게 하려면 생략 */
}
/* 두 태그에 각각 y 위치 입력 */
#TopButton {
  bottom: 108px;        
}
#BottomButton {
  bottom: 75px;
}
</style>
<div class="container">
    <div class="row">
		<div class="col-lg-offset-1 col-lg-10 col-lg-offset-1">
            <section class="scrollingtop">
            	<c:if test="${!empty boardList }">
				<c:forEach items="${boardList}" var = "b">	
                  <div class= 'insta scrolling'>
                    <div class='top-insta '>
					  <c:if test="${!empty proList}">
					  	<c:forEach items="${proList}" var="po" varStatus="status">
					  		<c:if test="${po.id eq b.writer }">
					  			<c:choose>
					  				<c:when test="${po.profile_img ne 'X'}">
					  					<img id='user_img' src="/dailygram/thumbnail_mem/${po.profile_img}">
					  				</c:when>
					  				<c:otherwise>
					  					<img id='user_img' src="http://www.technifroid-pro.fr/wp-content/uploads/2014/02/Technifroid-F.jpg">
					  				</c:otherwise>
					  			</c:choose>
					  		</c:if>
					  	</c:forEach>
					  </c:if>
                      <c:choose>
                      	<c:when test="${b.writer eq sessionScope.memInfo.id }">
                      		<a href='${pageContext.request.contextPath }/board/myList.do?' class='user'>${b.writer}</a>
                      	</c:when>
                      	<c:otherwise>
                      		<a href='${pageContext.request.contextPath }/board/friList.do?writer=${b.writer}' class='user'>${b.writer}</a>
                      	</c:otherwise>
                      </c:choose>
					  <a href='#' id='menu' class="dropdown-toggle" data-toggle="dropdown">
						<i class="fas fa-ellipsis-v fa-2x"></i>
					  </a>
					  <ul class="dropdown-menu dropdown-menu-right">

					  	<c:choose>
					  		<c:when test="${b.writer eq sessionScope.memInfo.id }">
					  			<li><a href="${pageContext.request.contextPath }/board/updateBoard.do?bseq=${b.board_seq}">수정</a></li>
								<li><a href="${pageContext.request.contextPath }/board/del.do?bseq=${b.board_seq}">삭제</a></li>
					  		</c:when>  
					  		<c:otherwise>
					  			<c:if test="${b.type eq 'X' or b.type eq 'L'}">
							  		<li><a href="${pageContext.request.contextPath }/board/siren.do?bseq=${b.board_seq}">신고</a></li>
							  	</c:if>
							 	<c:if test="${b.type eq 'S'}">
							  		<li><a href="${pageContext.request.contextPath }/board/delType.do?bseq=${b.board_seq}">신고 취소하기</a></li>
		                      	</c:if>
		                      	<li><a href="${pageContext.request.contextPath }/board/repost.do?bseq=${b.board_seq}">공유</a></li>
					  		</c:otherwise>
					  	</c:choose>
					  </ul>
                    </div>
                    <div class='post'>
                      <img src="/dailygram/thumbnail/${b.img}">
                    </div>
                    
                    <div class='footer'>
                      <div class='react'>
                      	<c:if test="${b.type eq 'X' or b.type eq 'S'}">
                        	<a role='button' href="${pageContext.request.contextPath }/board/like.do?bseq=${b.board_seq}">
                        		<i class="far fa-heart fa-2x"></i></a>
                        </c:if>
                        <c:if test="${b.type eq 'L'}">
                          	<a role='button' href="${pageContext.request.contextPath }/board/delType.do?bseq=${b.board_seq}">
                          		<i class="fas fa-heart fa-2x"></i></a>
                        </c:if>
                        <a role='button'><i class="far fa-comments fa-2x"></i></a>
                        <a role='button' href="${pageContext.request.contextPath }/board/repost.do?bseq=${b.board_seq}">
                        		<i class="far fa-share-square fa-2x"></i></a>
                      </div>
                      <p style="margin-top:10px; font-weight:bold;">좋아요  ${b.likecnt }개</p>
                      <div class='caption'>
                        <a href='${pageContext.request.contextPath }/board/friList.do?writer=${b.writer}'>${b.writer}</a>
                        <span>${b.content}</span>
                      </div>
                      <!-- 게시일 -->
                      <input class="public_yn" type = "text" hidden="hidden" name="public_yn" value="${b.public_yn}">
                      <div class='comment-list'>
						<c:if test="${!empty coList}">
							<c:forEach var="co" items="${coList }">
								<c:if test="${co.board_seq eq b.board_seq }"> <!-- 현재 글번호와 댓글의 글번호가 같을때만  -->
									<div class='comment-body ${b.board_seq }' style="padding-left: ${co.lev*30}px">
		                       		 <a href='${pageContext.request.contextPath }/board/friList.do?writer=${co.writer }' class='user' id='a2'>${co.writer }</a>
		                       		 <input class= 'commcontent' readonly="readonly" value="${co.content }">
		                       		 <c:if test="${sessionScope.memInfo.id eq co.writer }">
		                       		 	<a><i class="fas fa-edit"></i></a>
		                       		 	<a ><i class="fas fa-check okbtn" style="color:#9770f9; display:none"></i></a>
		                       		 	<a ><i class="fas fa-times canclebtn" style="color:gray;display:none"></i></a>
		                       		 	<a><i class='fas fa-times delbtn'></i></a>
		                       		 </c:if>
		                       		 <input id="com_seq" type="hidden" value="${co.com_seq }">
		                       		 <input id="replycnt" type="hidden" value="${co.reply} ">
		                        	 </div>
								</c:if>
                        	</c:forEach>
						</c:if>
                      <div class='comment-write'>
                        <input type='text' id='cmnt' placeholder='Add a comment...'>
                        <input type="hidden" id="${b.board_seq }" value="${b.board_seq }">
                        <a><i class="fas fa-pen-nib fa-2x commwrite"></i></a>
                      </div>
                      </div>
                    </div> <!-- end Footer -->
                    <input type="hidden" class="scrolling" value="${b.row }">
                  </div> <!-- end Insta -->
                  </c:forEach>
                  </c:if>
                </section> <!-- end section -->
        </div>
	</div>
	<a id="TopButton" class="ScrollButton" ><img src="${pageContext.request.contextPath }/resources/img/topbtn.png"></a>
	<a id="BottomButton" class="ScrollButton"><img src="${pageContext.request.contextPath }/resources/img/downbtn.png"></a>
	<a id="footer"></a>
</div>
<script>
	//Top버튼 클릭시
	$("#TopButton").click(function() {   
	$('html, body').animate({
	  scrollTop : 0    // 0 까지 animation 이동합니다.
	 }, 400);          // 속도 400
	 return false;
	 });

	// Bottom버튼 클릭시
	$("#BottomButton").click(function() {   
	$('html, body').animate({
	scrollTop : ($('#footer').offset().top)}, 400);
	return false;
	});

	<%--이전 스크롤 좌표--%>
	var lastScrollTop = 0;
	var flag;
	<%-- 1. 스크롤 이벤트 최초 발생 --%>
	$(window).scroll(function(){
		if ($(this).scrollTop() > 250) {
            $('.ScrollButton').fadeIn();
        } else {
            $('.ScrollButton').fadeOut();
        }
		<%-- 현재 스크롤 좌표--%>
		var currentScrollTop = $(window).scrollTop();
		//다운 스크롤
		if(currentScrollTop - lastScrollTop > 0){
			// down-scroll : 현재 게시글 다음의 글을 불러온다.
            console.log("down-scroll");
			lastScrollTop = currentScrollTop;

			if(flag != false ){
			if (Math.ceil($(window).scrollTop()) >= ($(document).height() - $(window).height())){
				console.log('여기로 들어왔다');
				//맨 마지막 row 값을 갖고 온다..다음에 뿌려질 값을 위해서.
				var lastrow = $(".scrolling:last").val();
				console.log('현재 마지막 번호는:'+lastrow);
				 $.ajax({
					type : 'post',
					url : "infiLoad.do",
					dataType : 'json',
					data : {row : lastrow , id : '${sessionScope.memInfo.id}' } ,
					success : function(data){
						var str = "";
						console.log("게시판개수:"+data.boardList.length);
						console.log("댓글개수:"+data.coList.length);
						console.log("프로필이미지개수:"+data.proList.length);
						// 5. 받아온 데이터가 ""이거나 null이 아닌 경우에 DOM handling을 해준다.
						if(data.boardList != "" || data.boardList != null){
							$(data.boardList).each(function(index,bo){
								str += "<div class= 'insta scrolling'><div class='top-insta '>"
								+ "<a href='${pageContext.request.contextPath }/board/friList.do?writer="+bo.writer+"'>";
									$(data.proList).each(function(index,po){
										if(po.id = bo.writer){
											if(po.profile_img != 'X'){
												str += "<img id='user_img' src='/dailygram/thumbnail_mem/"+po.profile_img+"'></a>";
												return false;
											}else{
												str += "<img id='user_img' src='http://www.technifroid-pro.fr/wp-content/uploads/2014/02/Technifroid-F.jpg'></a>";
												return false;
											}
										}
									})
								
			                     str += "<a href='${pageContext.request.contextPath }/board/friList.do?writer="+bo.writer+"' class='user'>"+bo.writer+"</a>"
								     +"<a href='#' id='menu' class'dropdown-toggle' data-toggle='dropdown'><i class='fas fa-ellipsis-v fa-2x'></i></a>" 
									 +"<ul class='dropdown-menu dropdown-menu-right'>";
									 
									 
								 if(bo.writer == '${sessionScope.memInfo.id}'){
									 str += "<li><a href='${pageContext.request.contextPath }/board/updateBoard.do?bseq="+bo.board_seq+"'>수정</a></li>"
										+"<li><a href='${pageContext.request.contextPath }/board/del.do?bseq="+bo.board_seq+"'>삭제</a></li>";
								 }else{
									 if(bo.type == 'X' || bo.type == 'L'){
										str += "<li><a href='${pageContext.request.contextPath }/board/siren.do?bseq="+bo.board_seq+"'>신고</a></li>"; 
									 }else{
										str += "<li><a href='${pageContext.request.contextPath }/board/delType.do?bseq="+bo.board_seq+"'>신고 취소하기</a></li>"; 
									 }
									 str += "<li><a href='${pageContext.request.contextPath }/board/repost.do?bseq="+bo.board_seq+"'>공유</a></li>";
								 }	 
									str +="</ul></div>"
								  	+ "<div class='post'><img src='/dailygram/thumbnail/"+bo.img+"'></div>"
								  	+ "<div class='footer'><div class='react'>";
								  	
								  	if(bo.type == 'L'){
								  		str += "<a role='button' href='${pageContext.request.contextPath }/board/delType.do?bseq="+bo.board_seq+"'>"
		                          		    + "<i class='fas fa-heart fa-2x'></i></a>";
								  	}else{
								  		str += "<a role='button' href='${pageContext.request.contextPath }/board/like.do?bseq="+bo.board_seq+"'>"
								  			+ "<i class='far fa-heart fa-2x'></i></a>";
								  	}
								  	
									
								  	str += "<a role='button'><i class='far fa-comments fa-2x'></i></a>"
								  	    + "<a role='button' href='${pageContext.request.contextPath }/board/repost.do?bseq="+bo.board_seq+"'>"
								  	    + "<i class='far fa-share-square fa-2x'></i></a></div>"
								  		+ "<p style='margin-top:10px; font-weight:bold;'>좋아요  "+bo.likecnt+" 개</p>"
								  	    + "<div class='caption'>"
								  	    + "<a href='${pageContext.request.contextPath }/board/friList.do?writer="+bo.writer+"'>"+bo.writer+"</a>"
			                      		+ "<span>"+bo.content+"</span></div>"
			                      		+ "<input class='public_yn' type = 'text' hidden='hidden' name='public_yn' value='"+bo.public_yn+"'>"	
			                        	+ "<div class='comment-list'>";
			                     
			                        	
			                        	
			                      	if(data.coList != "" || data.coList != null){
			                      		$(data.coList).each(function(index,co){
											if(co.board_seq == bo.board_seq){
												str += "<div class='comment-body "+bo.board_seq+"' style='padding-left: "+co.lev * 30+"px'>"
											     + "<a href='${pageContext.request.contextPath }/board/friList.do?writer="+co.writer+"' class='user' id='a2'>"+co.writer+"</a>"
					                       		 + "<input class= 'commcontent' readonly='readonly' value='"+co.content+"'>";
					                       		 if('${sessionScope.memInfo.id}' == co.writer){
					                       			str += "<a><i class='fas fa-edit'></i></a>"
					                       				+ "<a><i class='fas fa-check okbtn' style='color:#9770f9; display:none'></i></a>"	
					                       		 	    + "<a><i class='fas fa-times canclebtn' style='color:gray;display:none'></i></a>"
					                       		 		+ "<a><i class='fas fa-times delbtn'></i></a>";
					                       		 }
												str += "<input id='com_seq' type='hidden' value='"+co.com_seq+"'>"
													+ "<input id='replycnt' type='hidden' value='"+co.reply+"'></div>";
											}
										})
			                      	}	     
			                      	
								
			                      	str += "<div class='comment-write'><input type='text' id='cmnt' placeholder='Add a comment...'>"
										+ "<input type='hidden' id='"+bo.board_seq+"' value='"+bo.board_seq+"'>"
										+ "<a><i class='fas fa-pen-nib fa-2x commwrite'></i></a></div></div></div>"
										+ "<input type='hidden' class='scrolling' value='"+bo.row+"'></div>";
										
			                        
							});// each
							if(data.length <10){
								flag = false;
							}else{
								flag = true;
							}
							$(".scrollingtop").append(str);
						}
					}//success
				}); 
	        }//if : 현재 스크롤의 top 좌표가  <= 0 되는 순간
		}
			// lastScrollTop을 현재 currentScrollTop으로 갱신해준다.
			lastScrollTop = currentScrollTop;
		}//다운스크롤인 상태

	}); //스크롤 이벤트 종료
	
	
	

	var boseq = "";
	$(function() {
		$(".top-insta #silen").click(function() {
			alert("정말 해당 게시물을 신고하시겠습니까?");
		});
	});

	var tempVal ="";
	<%--수정버튼 클릭 시 v 띄우고 x 클릭--%>
	$(document).on('click','.fa-edit',function(){
		$(this).css("display","none");
		$(this).parent().siblings('a').children('.delbtn').css("display","none");
		$(this).parent().siblings('a').children('.okbtn').css("display","inline");
		$(this).parent().siblings('a').children('i.canclebtn').css("display","inline");
		$(this).parents().children('input.commcontent').removeAttr('readonly');
		tempVal = $(this).parents().children('input.commcontent').val();
	});
	
	<%--수정취소버튼 눌렀을 때--%>
	$(document).on('click','.canclebtn',function(){
		$(this).css("display","none");
		$(this).parent().siblings('a').children('i.delbtn').css("display","inline");
		$(this).parent().siblings('a').children('i.okbtn').css("display","none");
		$(this).parent().siblings('a').children('i.fa-edit').css("display","inline");
		$(this).parents().children('input.commcontent').attr('readonly','readonly');
		$(this).parents().children('input.commcontent').val(tempVal);
	});
	
	<%--수정확인 버튼 눌렀을 때--%>
	$(document).on('click','.okbtn',function(){
		$(this).css("display","none");
		$(this).parent().siblings('a').children('i.delbtn').css("display","inline");
		$(this).parent().siblings('a').children('i.canclebtn').css("display","none");
		$(this).parent().siblings('a').children('i.fa-edit').css("display","inline");
		$(this).parents().children('input.commcontent').attr('readonly','readonly');
		
		var boseq = $(this).parent().parent().parent().children(":last").children('input[type=hidden]').val();
		var commwrite = $(this).parent().parent().parent().children(':last');
		var commlist = $(this).parent().parent().parent();
		var comseq = $(this).parent().parent().children('input[id=com_seq]').val();
		var content = $(this).parent().parent().find('input[class=commcontent]').val();
		
		var editdata = {"content":content,
					"com_seq":comseq,
					"board_seq": boseq };
		$.ajax({
			method : 'PUT',
			url : '/daily/comments',
			data: JSON.stringify(editdata),
			contentType : "application/json; charset=UTF-8",
			dataType : 'json',
			success : function(data){
				alert('댓글수정 성공!');
				if(data != ""){
					$("div."+boseq).remove(); //기존에 있던 댓글 전부 날리기.
					$(commwrite).remove();
					$(data).each(function(){
						var str = "";
						str += "<div class='comment-body "+boseq+"' style='padding-left: "+(this.lev *30)+"px'>"
	                          +"<a href='${pageContext.request.contextPath }/board/friList.do?writer="+this.writer+"' class='user' id='a2'>"+this.writer+"</a>"
	                       	  +"<input class='commcontent' readonly='readonly' value='"+this.content+"'>"
	                       	  +"<input id='com_seq' type='hidden' value='"+this.com_seq+"'>"
	                       	  +"<input id='replycnt' type='hidden' value='"+this.reply+"'>";
						if('${sessionScope.memInfo.id}' == this.writer){
							str += "<a><i class='fas fa-edit '></i></a>"+
							"<a><i class='fas fa-check okbtn' style='color:#9770f9; display:none'></i></a>"+
							"<a><i class='fas fa-times canclebtn' style='color:gray;display:none'></i></a>"+
							"<a><i class='fas fa-times delbtn'></i></a>";
	                    }     	  
						str += "</div>";			                       	  
	                    $(commlist).append(str);
				});// each				
				var str2 = "<div class='comment-write'>"+
				"<input type='text' id='cmnt' placeholder='Add a comment...'>"+
				"<input type='hidden' id='"+boseq+"' value='"+boseq+"'>"+
				"<a><i class='fas fa-pen-nib fa-2x commwrite'></i></a></div>"; 
				$(commlist).append(str2);
				}
			},//success
			error:function(request,status,error){
				alert('왜 에러냐');
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
		
		
	});
	
	<%-- 삭제 버튼 눌렀을 때--%>
	$(document).on('click','.delbtn',function(){
		var boseq = $(this).parent().parent().parent().children(":last").children('input[type=hidden]').val();
		var commwrite = $(this).parent().parent().parent().children(':last');
		var commlist = $(this).parent().parent().parent();
		var comseq = $(this).parent().parent().children('input[id=com_seq]').val();
		if($(this).parents().children('input[id=replycnt]').val() != 0){
			alert('답댓글이 존재하여 삭제하지 못합니다!');
			return;
		}
		var deletedata = {
						"com_seq":$(this).parent().parent().children('input[id=com_seq]').val(),
						"board_seq": $(this).parent().parent().parent().children(":last").children('input[type=hidden]').val()
						};
		$.ajax({
			method : 'DELETE',
			url : '/daily/comments',
			data: JSON.stringify(deletedata),
			contentType : "application/json; charset=UTF-8",
			dataType : 'json',
			success : function(data){
				$("div."+boseq).remove(); //기존에 있던 댓글 전부 날리기.
				alert('댓글삭제 성공!');
				if(data != ""){
					$(commwrite).remove();
					$(data).each(function(){
						 var str = "";
							str += "<div class='comment-body "+boseq+"' style='padding-left: "+(this.lev *30)+"px'>"
		                          +"<a href='${pageContext.request.contextPath }/board/friList.do?writer="+this.writer+"' class='user' id='a2'>"+this.writer+"</a>"
		                       	  +"<input class='commcontent' readonly='readonly' value='"+this.content+"'>"
		                       	  +"<input id='com_seq' type='hidden' value='"+this.com_seq+"'>"
		                       	  +"<input id='replycnt' type='hidden' value='"+this.reply+"'>";
							if('${sessionScope.memInfo.id}' == this.writer){
								str += "<a><i class='fas fa-edit '></i></a>"+
								"<a><i class='fas fa-check okbtn' style='color:#9770f9; display:none'></i></a>"+
								"<a><i class='fas fa-times canclebtn' style='color:gray;display:none'></i></a>"+
								"<a><i class='fas fa-times delbtn'></i></a>";
		                    }     	  
							str += "</div>";			                       	  
		                    $(commlist).append(str);
					});// each				
					var str2 = "<div class='comment-write'>"+
					"<input type='text' id='cmnt' placeholder='Add a comment...'>"+
					"<input type='hidden' id='"+boseq+"' value='"+boseq+"'>"+
					"<a><i class='fas fa-pen-nib fa-2x commwrite'></i></a></div>"; 
					$(commlist).append(str2);	
				}
			},//success
			error:function(request,status,error){
				alert('왜 에러냐');
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	});

	<%--기존 댓글 클릭 시 아래 답글창 띄우기--%>
	$(document).on('click','.commcontent',function(){
		if($(this).parent().is('.replyon')==true){
			$('.repcommwrite').remove();
			$(this).parent().removeClass('replyon');
			return;
		}
		var reply = "<div class='repcommwrite'><input type='text' id='cmnt' placeholder='Add a comment...'>"
		     + "<a><i class='fas fa-pen-nib fa-2x replycommwrite'></i></a></div>";
		$(this).parent().append(reply);
		$(this).parent().addClass('replyon');
	});
	
	<%-- 대댓글 작성--%>
	$(document).on('click','.replycommwrite',function(){
		var boseq = $(this).parent().parent().parent().parent().children(':last').children('input[type=hidden]').val();
		var commwrite = $(this).parent().parent().parent().parent().children(':last');
		var commlist = $(this).parent().parent().parent().parent();
		var comseq = $(this).parent().parent().parent().children("input[id=com_seq]").val();
			$.ajax({
				method : 'POST',
				url : '/daily/comments',
				data: {
					board_seq : boseq ,
					content : $(this).parent().parent().children("input[type=text]").val(),
					writer : '${sessionScope.memInfo.id}',
					com_seq : comseq
				},
				dataType : 'json',
				success : function(data){
					alert('댓글달기 성공!');
					if(data != ""){
						$("div."+boseq).remove(); //기존에 있던 댓글 전부 날리기.
						$(commwrite).remove();
						 $(data).each(function(){
							 var str = "";
								str += "<div class='comment-body "+boseq+"' style='padding-left: "+(this.lev *30)+"px'>"
			                          +"<a href='${pageContext.request.contextPath }/board/friList.do?writer="+this.writer+"' class='user' id='a2'>"+this.writer+"</a>"
			                       	  +"<input class='commcontent' readonly='readonly' value='"+this.content+"'>"
			                       	  +"<input id='com_seq' type='hidden' value='"+this.com_seq+"'>"
			                       	  +"<input id='replycnt' type='hidden' value='"+this.reply+"'>";
								if('${sessionScope.memInfo.id}' == this.writer){
									str += "<a><i class='fas fa-edit '></i></a>"+
									"<a><i class='fas fa-check okbtn' style='color:#9770f9; display:none'></i></a>"+
									"<a><i class='fas fa-times canclebtn' style='color:gray;display:none'></i></a>"+
									"<a><i class='fas fa-times delbtn'></i></a>";
			                    }     	  
								str += "</div>";			                       	  
			                    $(commlist).append(str);
			                    
						});
						 var str2 = "<div class='comment-write'>"+
							"<input type='text' id='cmnt' placeholder='Add a comment...'>"+
							"<input type='hidden' id='"+boseq+"' value='"+boseq+"'>"+
							"<a><i class='fas fa-pen-nib fa-2x commwrite'></i></a></div>"; 
						$(commlist).append(str2);	 
						 
					}
				},//success
				error:function(request,status,error){
					alert('왜 에러냐');
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
			
			//대댓창 사라지게 만들기
			$('.repcommwrite').remove();
		});
	
	<%--새로운 댓글 작성--%>
	$(document).on('click','.commwrite',function(){
		var boseq = $(this).parent().parent().children('input[type=hidden]').val();
		var commwrite = $(this).parent().parent();
		var commlist = $(this).parent().parent().parent();
		$.ajax({
			method : 'POST',
			url : '/daily/comments',
			data: {
				board_seq : $(this).parent().parent().children('input[type=hidden]').val(),
				content : $(this).parent().parent().children('input[id=cmnt]').val(),
				writer : '${sessionScope.memInfo.id}'
			},
			dataType : 'json',
			success : function(data){
				alert('댓글달기 성공!');
				if(data != ""){
					$("div."+boseq).remove(); //기존에 있던 댓글 전부 날리기.
					$(commwrite).remove();
					 $(data).each(function(){
						var str = "";
							str += "<div class='comment-body "+boseq+"' style='padding-left: "+(this.lev *30)+"px'>"
		                          +"<a href='${pageContext.request.contextPath }/board/friList.do?writer="+this.writer+"' class='user' id='a2'>"+this.writer+"</a>"
		                       	  +"<input class='commcontent' readonly='readonly' value='"+this.content+"'>"
		                       	  +"<input id='com_seq' type='hidden' value='"+this.com_seq+"'>"
		                       	  +"<input id='replycnt' type='hidden' value='"+this.reply+"'>";
							if('${sessionScope.memInfo.id}' == this.writer){
								str += "<a><i class='fas fa-edit '></i></a>"+
								"<a><i class='fas fa-check okbtn' style='color:#9770f9; display:none'></i></a>"+
								"<a><i class='fas fa-times canclebtn' style='color:gray;display:none'></i></a>"+
								"<a><i class='fas fa-times delbtn'></i></a>";
		                    }     	  
							str += "</div>";			                       	  
		                    $(commlist).append(str);
					});
					var str2 = "<div class='comment-write'>"+
						"<input type='text' id='cmnt' placeholder='Add a comment...'>"+
						"<input type='hidden' id='"+boseq+"' value='"+boseq+"'>"+
						"<a><i class='fas fa-pen-nib fa-2x commwrite'></i></a></div>"; 
					$(commlist).append(str2);	
				}
			},//success
			error:function(request,status,error){
				alert('왜 에러냐');
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	});
</script>
<%@ include file="../container/footer.jsp"%>