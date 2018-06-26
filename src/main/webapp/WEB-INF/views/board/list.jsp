<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
 #add {
  background-color: #9770f9; 
  border: none;
  color: white;
  text-align: center;
}
 #form {
 	color: white;
 	text-decoration:none;
 }
 
.col-lg-12 {
   padding:0;
}
.col-lg-4 {
   padding-right:0;
   padding-left:5px;
}
.lookimg {
   width:100%;height:320px;margin-bottom:5px
}
.post_register {
	padding-bottom:5%;
}
/* #profile {
	width:100%;height:20%;
} */
</style>
<%@ include file="/WEB-INF/views/container/header.jsp"%>
<%@ include file="/WEB-INF/views/board/profile.jsp"%>

 <div class="container">
 <div class="post_register">
 <div class="col-lg-offset-10 col-lg-2">
  <button type="submit" class="btn btn-primary" id = "add">
  <a id = "form" href="${pageContext.request.contextPath}/board/form.do">게시물 등록</a>
 </button>
</div>
</div>
</div>
<div class="row">
   <div class="container">
      <div class="col-lg-12">
         <div class="gallery_product col-lg-4">
            <img src="http://www.bibigo.com/img/kr/img_delightful_mandu5_1.jpg"
               class="lookimg">
         </div>

         <div class="gallery_product col-lg-4">
            <img src="http://uruma.co.kr/skin/upload/menu_5_1.jpg"
               class="lookimg">
         </div>

         <div class="gallery_product col-lg-4">
            <img
               src="http://hanmandushop.com/web/product/small/201804/95_shop1_307843.jpg"
               class="lookimg">
         </div>

         <div class="gallery_product col-lg-4">
            <img src="http://uruma.co.kr/skin/upload/menu_5_1.jpg"
               class="lookimg">
         </div>

         <div class="gallery_product col-lg-4">
            <img
               src="http://img.enews24.cjenm.skcdn.com/News/Contents/20180429/98306354.jpg"
               class="lookimg">
         </div>

         <div class="gallery_product col-lg-4">
            <img src="http://www.bibigo.com/img/kr/img_delightful_mandu5_1.jpg"
               class="lookimg">
         </div>

         <div class="gallery_product col-lg-4">
            <img
               src="http://hanmandushop.com/web/product/small/201804/95_shop1_307843.jpg"
               class="lookimg">
         </div>

         <div class="gallery_product col-lg-4">
            <img src="http://uruma.co.kr/skin/upload/menu_5_1.jpg"
               class="lookimg">
         </div>

         <div class="gallery_product col-lg-4">
            <img src="http://www.bibigo.com/img/kr/img_delightful_mandu5_1.jpg"
               class="lookimg">
         </div>
      </div>
   </div>
 </div> 
 <%@ include file="/WEB-INF/views/container/footer.jsp"%> 
</html>