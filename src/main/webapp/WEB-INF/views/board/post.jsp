<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../container/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="${pageContext.request.contextPath }/resources/css/post.css" rel="stylesheet">
<script>
	$(function() {
		$(".top-insta #silen").click(function() {
			alert("정말 해당 게시물을 신고하시겠습니까?");
		});
	});
</script>
<div class="container">
    <div class="row">
		<div class="col-lg-offset-1 col-lg-10 col-lg-offset-1">
            <section>
                  <div class= 'insta'>
                    <div class='top-insta'>
                      <a href='${pageContext.request.contextPath }/board/list.do'><img id='user_img' src='https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w'></a>
                      <a href='${pageContext.request.contextPath }/board/list.do' class='user'>${b.writer}</a>
					  <a href='#' id='menu' class="dropdown-toggle" data-toggle="dropdown">
						<i class="fas fa-ellipsis-v fa-2x"></i>
					  </a>
					  <ul class="dropdown-menu dropdown-menu-right">
						<li><a href="${pageContext.request.contextPath }/board/updateBoard.do?board_seq=${b.board_seq}&writer=${b.writer}">수정</a></li>
						<li><a href="${pageContext.request.contextPath }/board/del.do">삭제</a></li>
						<li class="divider"></li>
						<li><a id="silen">신고</a></li>
					  </ul>
                    </div>
                    </div>
                    <div class='post'>
                        <div class="overlay">
                        <span></span>
                        </div>
                      <img src="/thumbnail/${b.img}">
                    </div>
                    
                    <div class='footer'>
                      <div class='react'>
                        <a role='button'><i class="far fa-heart fa-2x"></i></a>
                        <a role='button'><i class="fas fa-heart fa-2x"></i></a>
                        <a role='button'><i class="far fa-comments fa-2x"></i></a>
                        <a role='button'><i class="far fa-share-square fa-2x"></i></a>
                      </div>
                      <div class='caption'>
                        <a href='${pageContext.request.contextPath }/board/list.do'>${b.writer}</a>
                        <span>${b.content}</span>
                      </div>
                      <!-- 게시일 -->
                      <input class="public_yn" type = "text" hidden="hidden" name="public_yn" value="${b.public_yn}">
                      <div class='comment-list'>
                      	<c:forEach var="co" items="${coList }">
                      	<div class='comment-body' style="padding-left: ${co.lev*35}px">
                        	 <a href='${pageContext.request.contextPath }/board/list.do' id='a1'><img id='user_img' src='https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w'></a>
                       		 <a href='${pageContext.request.contextPath }/board/list.do' class='user' id='a2'>${co.writer }</a>
                       		 <span class='commcontent'>${co.content }</span>
                       		 <c:if test="${sessionScope.memInfo.id eq co.writer }">
                       		 	<a href="${pageContext.request.contextPath }/board/cmtDel.do" id='a3'>
                        	 	<i class="fas fa-times fa-2x"></i></a>
                       		 </c:if>
                       		 <input id="com_seq" type="hidden" value="${co.com_seq }">
                         </div>
                        </c:forEach>
                      <div class='comment-write'>
                        <input type='text' id='cmnt' placeholder='Add a comment...'>
                        <a><i class="fas fa-pen-nib fa-2x commwrite"></i></a>
                      </div>
                    </div> <!-- end Footer -->
                    
                  </div> <!-- end Insta -->
                </section> <!-- end section -->
        </div>
	</div>
</div>
<script>
	<%--기존 댓글 클릭 시 아래 답글창 띄우기--%>
	$('.commcontent').click(function(){
		
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
		$(document).on('click','.replycommwrite',function(event){
			$.ajax({
				type : 'POST',
				url : '/daily/comments',
				header : {
					"Content-Type" : "application/json"
				},
				data: {
					board_seq : ${b.board_seq},
					content : $('#cmnt').val(),
					writer : '${sessionScope.memInfo.id}',
					com_seq : $('input#com_seq').val()
				},
				dataType : 'text',
				success : function(data){
					alert('댓글달기 성공!');
					
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
	$('.commwrite').click(function(){
		
		$.ajax({
			type : 'POST',
			url : '/daily/comments',
			header : {
				"Content-Type" : "application/json"
			},
			data: {
				board_seq : ${b.board_seq},
				content : $('#cmnt').val(),
				writer : '${sessionScope.memInfo.id}'
			},
			dataType : 'text',
			success : function(data){
				alert('댓글달기 성공!');
				
			},//success
			error:function(request,status,error){
				alert('왜 에러냐');
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	});
	
	function showComments(){
		$.ajax({
			type : 'POST',
			url : '/daily/comments',
			header : {
				"Content-Type" : "application/json"
			},
			data: {
				board_seq : ${b.board_seq},
				content : $('#cmnt').val(),
				writer : '${sessionScope.memInfo.id}'
			},
			dataType : 'text',
			success : function(data){
				alert('댓글달기 성공!');
				
			},//success
			error:function(request,status,error){
				alert('왜 에러냐');
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
</script>
<%@ include file="../container/footer.jsp"%>