<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../container/header.jsp"%>
<link href="${pageContext.request.contextPath }/resources/css/post.css" rel="stylesheet">
<script>
	$(function() {
		$(".top-insta #silen").click(function() {
			alert("정말 해당 게시물을 신고하시겠습니까?");
		});
	});
</script>
<style>
input{
	border:none;
}
</style>
<div class="container">
    <div class="row">
		<div class="col-lg-offset-1 col-lg-10 col-lg-offset-1">
            <section>
                  <div class= 'insta'>
                    <div class='top-insta'>
                      <a href='${pageContext.request.contextPath }/board/friList.do?writer=${b.writer}'>
                      <c:set var="profile" value="${fri.profile_img}" /> 
					  <c:choose>
						<c:when test="${profile ne null}"> 
							<img id='user_img' src="/dailygram/thumbnail_mem/${fri.profile_img}">
						</c:when>
						<c:otherwise>
							<img id='user_img' src="http://www.technifroid-pro.fr/wp-content/uploads/2014/02/Technifroid-F.jpg">
						</c:otherwise>
					  </c:choose>
                      </a>
                      <a href='${pageContext.request.contextPath }/board/friList.do?writer=${b.writer}' class='user'>${b.writer}</a>
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
					  			<c:if test="${l.type eq null or l.type eq 'L'}">
							  		<li><a href="${pageContext.request.contextPath }/board/siren.do?bseq=${b.board_seq}">신고</a></li>
							  	</c:if>
							 	<c:if test="${l.type eq 'S'}">
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
                      	<c:if test="${l.type eq null or l.type eq 'S'}">
                        	<a role='button' href="${pageContext.request.contextPath }/board/like.do?bseq=${b.board_seq}">
                        		<i class="far fa-heart fa-2x"></i></a>
                        </c:if>
                        <c:if test="${l.type eq 'L'}">
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
                      	<c:forEach var="co" items="${coList }">
                      	<div class='comment-body' style="padding-left: ${co.lev*35}px">
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
                        <a><i class="fas fa-pen-nib fa-2x commwrite"></i></a>
                      </div>
                      </div>
                    </div> <!-- end Footer -->
                  </div> <!-- end Insta -->
                </section> <!-- end section -->
        </div>
	</div>
</div>
<script>

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
				$('.comment-body').remove(); //기존에 있던 댓글 전부 날리기.
				alert('댓글삭제 성공!');
				if(data != ""){
					
					$('.comment-write').remove();
					$(data).each(function(){
						var str = "";
							str += "<div class='comment-body' style='padding-left: "+(this.lev *35)+"px'>"
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
<%@ include file="../container/footer.jsp"%>