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
		console.log("바뀐값이니:"+$(this).parents().children('input.commcontent').val());
		var editdata = {"content":$(this).parents().children('input.commcontent').val(),
					"com_seq":$(this).parents().children('input[id=com_seq]').val(),
					"board_seq": ${b.board_seq}};
		$.ajax({
			method : 'PUT',
			url : '/daily/comments',
			data: JSON.stringify(editdata),
			contentType : "application/json; charset=UTF-8",
			dataType : 'json',
			success : function(data){
				alert('댓글수정 성공!');
				if(data != ""){
					$('.comment-body').remove(); //기존에 있던 댓글 전부 날리기.
					$('.comment-write').remove();
					$(data).each(function(){
						var str = "";
							str += "<div class='comment-body' style='padding-left: "+(this.lev *35)+"px'>"
		                          +"<a href='${pageContext.request.contextPath }/board/friList.do' id='a1'><img id='fri_img' src='https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w'></a>"
		                          +"<a href='${pageContext.request.contextPath }/board/friList.do' class='user' id='a2'>"+this.writer+"</a>"
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
		                    $('.comment-list').append(str);
					});// each
                    $('.comment-list').append(str2);
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
		console.log($(this).parents().children('input[id=replycnt]').val());
		if($(this).parents().children('input[id=replycnt]').val() != 0){
			alert('답댓글이 존재하여 삭제하지 못합니다!');
			return;
		}
		var deletedata = {
						"com_seq":$(this).parents().children('input[id=com_seq]').val(),
						"board_seq": ${b.board_seq}
						};
		$.ajax({
			method : 'DELETE',
			url : '/daily/comments',
			data: JSON.stringify(deletedata),
			contentType : "application/json; charset=UTF-8",
			dataType : 'json',
			success : function(data){
				alert('댓글삭제 성공!');
				if(data != ""){
					$('.comment-body').remove(); //기존에 있던 댓글 전부 날리기.
					$('.comment-write').remove();
					$(data).each(function(){
						var str = "";
							str += "<div class='comment-body' style='padding-left: "+(this.lev *35)+"px'>"
		                          +"<a href='${pageContext.request.contextPath }/board/friList.do' id='a1'><img id='fri_img' src='https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w'></a>"
		                          +"<a href='${pageContext.request.contextPath }/board/friList.do' class='user' id='a2'>"+this.writer+"</a>"
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
		                    $('.comment-list').append(str);
					});// each				
                    $('.comment-list').append(str2);
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
			$.ajax({
				method : 'POST',
				url : '/daily/comments',
				data: {
					board_seq : ${b.board_seq},
					content : $('#cmnt').val(),
					writer : '${sessionScope.memInfo.id}',
					com_seq : $(this).parents().children("input[id=com_seq]").val()
				},
				dataType : 'json',
				success : function(data){
					alert('댓글달기 성공!');
					if(data != ""){
						$('.comment-body').remove(); //기존에 있던 댓글 전부 날리기.
						$('.comment-write').remove();
						$(data).each(function(){
							var str = "";
								str += "<div class='comment-body' style='padding-left: "+(this.lev *35)+"px'>"
			                          +"<a href='${pageContext.request.contextPath }/board/friList.do' id='a1'><img id='fri_img' src='https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w'></a>"
			                          +"<a href='${pageContext.request.contextPath }/board/friList.do' class='user' id='a2'>"+this.writer+"</a>"
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
			                    $('.comment-list').append(str);
			                    
						});// each				
                        $('.comment-list').append(str2);
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
		$.ajax({
			method : 'POST',
			url : '/daily/comments',
			data: {
				board_seq : ${b.board_seq},
				content : $('#cmnt').val(),
				writer : '${sessionScope.memInfo.id}'
			},
			dataType : 'json',
			success : function(data){
				alert('댓글달기 성공!');
				if(data != ""){
					$('.comment-body').remove(); //기존에 있던 댓글 전부 날리기.
					$('.comment-write').remove();
					$(data).each(function(){
						var str = "";
							str += "<div class='comment-body' style='padding-left: "+(this.lev *35)+"px'>"
		                          +"<a href='${pageContext.request.contextPath }/board/friList.do' id='a1'><img id='fri_img' src='https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w'></a>"
		                          +"<a href='${pageContext.request.contextPath }/board/friList.do' class='user' id='a2'>"+this.writer+"</a>"
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
		                    $('.comment-list').append(str);
		                    
					});// each				
                    $('.comment-list').append(str2);
				}
			},//success
			error:function(request,status,error){
				alert('왜 에러냐');
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
	});
	
	var str2 = "<div class='comment-write'>"+
	"<input type='text' id='cmnt' placeholder='Add a comment...'>"+
	"<a><i class='fas fa-pen-nib fa-2x commwrite'></i></a></div>";
</script>
<c:forEach items="${feed}" var = "f">
<div class="container">
    <div class="row">
		<div class="col-lg-offset-1 col-lg-10 col-lg-offset-1">
            <section>
                  <div class= 'insta'>
                    <div class='top-insta'>
                      <a href='${pageContext.request.contextPath }/board/list.do'><img id='user_img' src='https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w'></a>
                      <a href='${pageContext.request.contextPath }/board/list.do' class='user'>${f.writer}</a>
					  <a href='#' id='menu' class="dropdown-toggle" data-toggle="dropdown">
						<i class="fas fa-ellipsis-v fa-2x"></i>
					  </a>
					  <ul class="dropdown-menu dropdown-menu-right">
						<li><a href="${pageContext.request.contextPath }/board/updateBoard.do?bseq=${f.board_seq}&writer=${f.writer}">수정</a></li>
						<li><a href="${pageContext.request.contextPath }/board/del.do">삭제</a></li>
						<li class="divider"></li>
						<li><a id="silen">신고</a></li>
					  </ul>
                    </div>
                    
                    <div class='post'>
                        <div class="overlay">
                        <span></span>
                        </div>
                      <img src="/thumbnail/${f.img}">
                    </div>
                    
                    <div class='footer'>
                      <c:if test="${l.type eq null or l.type eq 'S'}">
                        <a role='button' href="${pageContext.request.contextPath }/board/like.do?bseq=${f.board_seq}">
                        	<i class="far fa-heart fa-2x"></i></a>
                       </c:if>
                        <c:if test="${l.type eq 'L'}">
                          	<a role='button' href="${pageContext.request.contextPath }/board/delType.do?bseq=${f.board_seq}">
                          		<i class="fas fa-heart fa-2x"></i></a>
                        </c:if>
                        <a role='button'><i class="far fa-comments fa-2x"></i></a>
                        <a role='button'><i class="far fa-share-square fa-2x"></i></a>
                     </div>
                      <p style="margin-top:10px; font-weight:bold;">좋아요  ${f.likecnt }개</p>
                      <div class='caption'>
                        <a href='${pageContext.request.contextPath }/board/friList.do?writer=${f.writer}'>${f.writer}</a>
                        <span>${b.content}</span>
                      </div>
                      <!-- 게시일 -->
                      <input class="public_yn" type = "text" hidden="hidden" name="public_yn" value="${f.public_yn}">
                      <div class='comment-list'>
                      	<c:forEach var="co" items="${coList }">
                      	<div class='comment-body' style="padding-left: ${co.lev*35}px">
                        	 <a href='${pageContext.request.contextPath }/board/friList.do' id='a1'><img id='fri_img' src='https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w'></a>
                       		 <a href='${pageContext.request.contextPath }/board/friList.do' class='user' id='a2'>${co.writer }</a>
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
                        </c:forEach>
                      <div class='comment-write'>
                        <input type='text' id='cmnt' placeholder='Add a comment...'>
                        <a><i class="fas fa-pen-nib fa-2x"></i></a>
                      </div>
                    </div> <!-- end Footer -->
                  </div> <!-- end Insta -->
                </section> <!-- end section -->
        </div>
	</div>
</div>
</c:forEach>
<%@ include file="../container/footer.jsp"%>