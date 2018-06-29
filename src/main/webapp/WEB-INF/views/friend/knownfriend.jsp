<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/container/header.jsp"%>
<style>
div.panel-group {
	width:65%;
	margin: auto;
	margin-top: 30px;
	margin-bottom: 50px;
	min-height: 100%;
}

ul.list-group>li>button{
	float:right;
	background-color: #9770f9;
	color:white;
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
<div class="panel-group">
	<div class="panelspace">
		<h4 class="panel-heading panel-known"><strong>추천 인물</strong></h4>
		<span class="panel-heading panel-known">최근 인기 게시물과 회원님의 소개글을 바탕으로 추천됩니다. 다른 회원님들과 폭넓은 소통을 나눠보시는건 어떠신가요?</span>
		<hr>
		<div class="panel-body">
			<ul class="list-group">
			<c:if test="${empty list }">다시한번 조회해주시기 바랍니다. </c:if>
			<c:if test="${not empty list }">
			<c:forEach var="p" items="${list }">
				<li class="list-group-item"><img alt="" class="img-circle"
					src="https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w"
					width="30"> 
					<a href=# style="color: black"><span>${p.id }</span></a>
					<button type="button" class="btn btn-xs">팔로우</button>
				</li>
			</c:forEach>
			</c:if>
			</ul>
		</div>
	</div>
</div>
<a id="TopButton" class="ScrollButton" ><img src="${pageContext.request.contextPath }/resources/img/topbtn.png"></a>
<a id="BottomButton" class="ScrollButton"><img src="${pageContext.request.contextPath }/resources/img/downbtn.png"></a>
<a id="footer"></a>
<script>

   // Top버튼 클릭시
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
         console.log('스크롤탑'+$(window).scrollTop());
         console.log('도큐먼트 높이'+$(document).height());
         console.log('윈도우 높이'+$(window).height());
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
               data : {row : lastrow} ,
               success : function(data){
                  var str = "";
                  console.log("데이터 길이:"+data.length);
                  // 5. 받아온 데이터가 ""이거나 null이 아닌 경우에 DOM handling을 해준다.
                  if(data != ""){
                     //6. 서버로부터 받아온 data가 list이므로 이 각각의 원소에 접근하려면 each문을 사용한다.
                     $(data).each(
                        // 7. 새로운 데이터를 갖고 html코드형태의 문자열을 만들어준다.
                        function(){
                           console.log(this);      
                           str +=   "<div class="+"'gallery_product col-lg-4 scrolling'"+">" 
                              +    "<img src="+"'/board/"+this.img+"'"+"class='lookimg'"+">"
                              +    "<input type="+"'hidden'"+ "class='scrolling'"+ "value='"+this.row+"'"+">"
                              +    "</div>";
                     });// each
                     if(data.length <9){
                        flag = false;
                     }else{
                        flag = true;
                     }
                     $(".scrollingtop").append(str);
                      
                     
                  }
               }//success
               
            });// ajax
           }//if : 현재 스크롤의 top 좌표가  <= 0 되는 순간
      }
         // lastScrollTop을 현재 currentScrollTop으로 갱신해준다.
         lastScrollTop = currentScrollTop;
      }//다운스크롤인 상태

   }); //스크롤 이벤트 종료
</script>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>
	