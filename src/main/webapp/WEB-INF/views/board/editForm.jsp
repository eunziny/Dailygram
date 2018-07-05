<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/container/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
 #ok, #cancel{
  background-color: #9770f9; 
  border: none;
  color: white;
  text-align: center;
  margin:2px;
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

<div class="container">
   <div class="page-header">
      <div class="row">
         <div class="col-lg-12">
            <p align="center">
               <b>게시물 내용을 수정해주세요.</b>
            </p>
         </div>
      </div>
   </div>
  <div class="row">
    <form class="form-horizontal" action="${pageContext.request.contextPath }/board/edit.do?writer=${update.writer}&board_seq=${update.board_seq}" 
    	  method="post" enctype="multipart/form-data">
        <div class="form-group">
			<div class="col-lg-offset-3 col-lg-6 col-lg-offset-3">
          		<label>내용</label>
				<br>
          		<textarea class="form-control" id="content" name="content" placeholder="Content"
          			 rows="8">${update.content}</textarea>
          		<br>
	    	</div>
	    	<div class="col-lg-offset-3 col-lg-6 col-lg-offset-3">
	    		<label>첨부파일</label>
	    		<br>
	    		<input type="file" name="file" id = "file" value="file"><br>
	    	</div>
		
		    <c:set var="public_yn" value="${sessionScope.memInfo.publicyn }" /> 
		    <c:set var="check" value="${update.public_yn}"/> 
		    <c:choose>
				<c:when test="${public_yn eq 'y' and check eq 'y'}"> 
				     <div class="col-lg-offset-3 col-lg-6 col-lg-offset-3">
						<label><input type="radio" name="public_yn" value="y" checked>전체공개</label>&nbsp;&nbsp;
						<label><input type="radio" name="public_yn" value="n">친구공개</label>
				     </div>
					</c:when>
					<c:when test="${public_yn eq 'y' and check eq 'n' }">
				     <div class="col-lg-offset-3 col-lg-6 col-lg-offset-3">
						<label><input type="radio" name="public_yn" value="y">전체공개</label>&nbsp;&nbsp;
						<label><input type="radio" name="public_yn" value="n" checked>친구공개</label>
				     </div>
					</c:when>			
				<c:otherwise>
				    <input type="hidden" name="public_yn" value="n">
				    <div class="col-lg-offset-3 col-lg-6 col-lg-offset-3">
				    	<p>* 업로드하신 게시물은 팔로워에게만 공개됩니다. *</p>
				    </div>
				</c:otherwise>	
			</c:choose>
	    </div>
	    <input class="date" type = "date" hidden="hidden" name="posted" value="${update.posted}">
	    <input type ="hidden" name="img" value="${update.img }">
	    <input class="public_yn" type = "text" hidden="hidden" name="public_yn" value="${update.public_yn}">
		<div class="col-lg-offset-8">
	    	<button type="submit" class="btn btn-primary" id = "ok">수정</button>
	    	<button type="button" class="btn btn-primary" id = "cancel" onclick="location.href='${pageContext.request.contextPath }/board/post.do?bseq=${update.board_seq}'">취소</button>
	    </div>
  	</form>
  </div>
</div>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>
