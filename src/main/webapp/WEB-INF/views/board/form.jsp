<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/container/header.jsp"%>
<style>
 #ok, #cancel{
  background-color: #9770f9; 
  border: none;
  color: white;
  text-align: center;
  margin-right:5px;
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
        	var ext = $('#imagefile').val().split('.').pop().toLowerCase();
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
               <b>게시물을 등록해주세요.</b>
            </p>
         </div>
      </div>
   </div>
  <div class="row">
    <form class="form-horizontal" action="${pageContext.request.contextPath }/board/upload.do"
    	method="post" enctype="multipart/form-data">
        <div class="form-group">
			<div class="col-lg-offset-3 col-lg-6 col-lg-offset-3">
          		<label>내용</label>
				<br>
          		<textarea class="form-control" id="content" name="content" 
          			placeholder="Content" rows="8"></textarea>
          		<br>
	    	</div>
	    	<div class="col-lg-offset-3 col-lg-6 col-lg-offset-3 imgUpload">
	    		<label>첨부파일&nbsp;
	    			(업로드하신 게시물은 1분 뒤에 공개됩니다.)</label>
	    		<br>
	    		<input type="file" name="file" id="imagefile" accept=".png, .jpg, .jpeg, .gif" /><br>
	    	</div>
	    	
			<c:set var="public_yn" value="${sessionScope.memInfo.publicyn }" />
			<c:choose>
				<c:when test="${public_yn eq 'y'}">
				    <div class="col-lg-offset-3 col-lg-6 col-lg-offset-3">
						<label><input type="radio" name="public_yn" value="y" checked>전체공개</label>&nbsp;&nbsp;
						<label><input type="radio" name="public_yn" value="n">친구공개</label>
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
	    
		<div class="col-lg-offset-8">
			<input type="hidden" name="writer" value="${sessionScope.memInfo.id }">
	    	<button type="submit" class="btn btn-primary" id = "ok">등록</button>
	    	<button type="button" onclick="location.href='${pageContext.request.contextPath }/board/myList.do'"
	    		 class="btn btn-primary" id = "cancel">취소</button>
	    </div>
  	</form>
  </div>
</div>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>