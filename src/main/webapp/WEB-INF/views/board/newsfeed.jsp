<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../container/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="${pageContext.request.contextPath }/resources/css/post.css" rel="stylesheet">
<div class="container">
    <div class="row">
		<div class="col-lg-offset-1 col-lg-10 col-lg-offset-1">
            <section>
                  <div class= 'insta'>
                    <div class='top-insta'>
                      <a href='${pageContext.request.contextPath }/board/list.do'><img id='user_img' src='https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w'></a>
                      <a href='${pageContext.request.contextPath }/board/list.do' class='user'>${feed.writer}</a>
					  <a href='#' id='menu' class="dropdown-toggle" data-toggle="dropdown">
						<i class="fas fa-ellipsis-v fa-2x"></i>
					  </a>
					  <ul class="dropdown-menu dropdown-menu-right">
						<li><a href="${pageContext.request.contextPath }/board/updateBoard.do?board_seq=${feed.board_seq}&writer=${feed.writer}">수정</a></li>
						<li><a href="${pageContext.request.contextPath }/board/del.do">삭제</a></li>
						<li class="divider"></li>
						<li><a id="silen">신고</a></li>
					  </ul>
                    </div>
                    
                    <div class='post'>
                        <div class="overlay">
                        <span></span>
                        </div>
                      <img src="/thumbnail/${feed.img}">
                    </div>
                    
                    <div class='footer'>
                      <div class='react'>
                        <a role='button'><i class="far fa-heart fa-2x"></i></a>
                        <a role='button'><i class="fas fa-heart fa-2x"></i></a>
                        <a role='button'><i class="far fa-comments fa-2x"></i></a>
                        <a role='button'><i class="far fa-share-square fa-2x"></i></a>
                      </div>
                      <div class='caption'>
                        <a href='${pageContext.request.contextPath }/board/list.do'>${feed.writer}</a>
                        <span>${feed.content}</span>
                      </div>
                      <!-- 게시일 -->
                      <input class="public_yn" type = "text" hidden="hidden" name="public_yn" value="${feed.public_yn}">
                      <div class='comment-list'>
                        <a href='${pageContext.request.contextPath }/board/list.do' id='a1'><img id='user_img' src='https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w'></a>
                        <a href='${pageContext.request.contextPath }/board/list.do' class='user' id='a2'>uncle_oreo</a>
                        <span id='p1'>안녕!!!!</span>
                        <a href="${pageContext.request.contextPath }/board/cmtDel.do" id='a3'>
                        	<i class="fas fa-times fa-2x"></i></a>
                      </div>
                      
                      
                      <div class='comment-write'>
                        <input type='text' id='cmnt' placeholder='Add a comment...'>
                        <a><i class="fas fa-pen-nib fa-2x"></i></a>
                      </div>
                    </div> <!-- end Footer -->
                  </div> <!-- end Insta -->
                  <input type="hidden" class="scrolling" value="${feed.row }">
                </section> <!-- end section -->
        </div>
	</div>
</div>
<%@ include file="../container/footer.jsp"%>

<script>
	$(function() {
		$(".top-insta #silen").click(function() {
			alert("정말 해당 게시물을 신고하시겠습니까?");
		});
	
	var lastScrollTop = 0;
	// 스크롤 이벤트 최초 발생 
	$(window).scroll(function(){
		var currentScrollTop = $(window).scrollTop();
		//다운 스크롤 일 때
		if(currentScrollTop - lastScrollTop > 0 ) {
			//현재 게시글 다음의 글을 불러옴
			// // 2. 현재 스크롤의 top 좌표가  > (게시글을 불러온 화면 height - 윈도우창의 height) 되는 순간
            if ($(window).scrollTop() >= ($(document).height() - $(window).height()) ){ //② 현재스크롤의 위치가 화면의 보이는 위치보다 크다면
            	//현재 뿌려진 게시글의 마지막 글번호값을 읽어온다.
                var lastrow = $(".scrolling:last").val();
				
            	$.ajax({
            		type: 'post', 
            		url: 'infnScrollDown.do',
            		headers : {
            			"Content-Type" : "application/json",
            			"X-HTTP-Method-Override" : "POST"
            		}, 
            		dataType: 'json', 
            		data : JSON.stringify({
            			row : lastrow
            		}),
            		success : function(data) {
            		 	var str = "";
            		 	if(data != "") {
            		 		$(data).each(
            		 			function() {
            		 				console.log(this);
            		 				str +=  "<div class='top-insta'>"+
            	                      			 "<a href='${pageContext.request.contextPath }/board/list.do'>"+
            	                      			  "<img id='user_img' src='https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w'></a>"+
            	                      			 "<a href='${pageContext.request.contextPath }/board/list.do' class='user'>"+this.writer+"</a>"+
            						  			 "<a href='#' id='menu' class="dropdown-toggle" data-toggle="dropdown">"+
            										"<i class="fas fa-ellipsis-v fa-2x"></i>"+
            						  			 "</a>"+
            						  			"<ul class="dropdown-menu dropdown-menu-right">"+
            										"<li><a href='${pageContext.request.contextPath }/board/updateBoard.do?board_seq='"+ this.board_seq+"&writer="+this.writer+">"+"수정</a></li>"+
            										"<li><a href='${pageContext.request.contextPath }/board/del.do'>삭제</a></li>"+
            										"<li class="divider"></li>"+
            										"<li><a id="silen">신고</a></li>"+
            						  			"</ul>"+
            	                    		"</div>"+
            	                    		"<div class='post'>"+
            	                        		"<div class="overlay">"+
            	                        			"<span></span>"+
            	                        	"</div>"+
            	                      		"<img src='/thumbnail/'"+this.img+ ">"+
            	                   		   "</div>"+
            	                    
            	                    	 "<div class='footer'>"+
            	                      		"<div class='react'>"+
		            	                        "<a role='button'><i class="far fa-heart fa-2x"></i></a>"+
		            	                        "<a role='button'><i class="fas fa-heart fa-2x"></i></a>"+
		            	                        "<a role='button'><i class="far fa-comments fa-2x"></i></a>"+
		            	                        "<a role='button'><i class="far fa-share-square fa-2x"></i></a>"+
            	                      	 "</div>"+
            	                      		"<div class='caption'>"+
            	                         	 "<a href='${pageContext.request.contextPath }/board/list.do'>"+ this.writer+ "</a>"+
            	                        		"<span>this.content</span>"+
            	                      		 "</div>"+
		            	                      "<input class="public_yn" type = "text" hidden="hidden" name="public_yn" value="+this.public_yn+ ">"+
		            	                     "<div class='comment-list'>"+
		            	                      	"<a href='${pageContext.request.contextPath }/board/list.do' id='a1'><img id='user_img' src='https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w'></a>"+
		            	                        "<a href='${pageContext.request.contextPath }/board/list.do' class='user' id='a2'>uncle_oreo</a>"+
		            	                        "<span id='p1'>안녕!!!!</span>"+
		            	                         "<a href="${pageContext.request.contextPath }/board/cmtDel.do" id='a3'>"+
		            	                        	"<i class="fas fa-times fa-2x"></i></a>"+
		            	                      "</div>"+
            	                      		"<div class='comment-write'>"+
            	                        		"<input type='text' id='cmnt' placeholder='Add a comment...'>"+
            	                        		"<a><i class="fas fa-pen-nib fa-2x"></i></a>" +
            	                      	 	"</div>"+
            	                    	"</div>"
            		 				}); //each                     
            		 			$(".scrollingtop").append(str);
            		 		} 
            			}
            		});
            	}
         		// lastScrollTop을 현재 currentScrollTop으로 갱신해준다.
				lastScrollTop = currentScrollTop;
			}
		});
	});
</script>