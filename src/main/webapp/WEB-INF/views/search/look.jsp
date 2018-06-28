<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/container/header.jsp"%>
<style>
.col-lg-12 {
	padding: 0;
}

.col-lg-4 {
	padding-right: 0;
	padding-left: 5px;
}

.lookimg {
	width: 100%;
	height: 350px;
	margin-bottom: 5px
}

#looktop {
	margin-top: 30px;
	margin-bottom: 50px;
}

#lookbottom {
	margin-top: 80px;
	margin-bottom: 70px;
}
</style>
<script>
$(function(){
	<%--이전 스크롤 좌표--%>
	var lastScrollTop = 0;


	
	<%-- 1. 스크롤 이벤트 최초 발생 --%>
	$(window).scroll(function(){
		
		<%-- 현재 스크롤 좌표--%>
		var currentScrollTop = $(window).scrollTop();
		//다운 스크롤
		if(currentScrollTop - lastScrollTop > 0){
			//현재 스크롤 좌표를 이전 스크롤 좌표로 할당
			lastScrollTop = currentScrollTop;
			if ($(window).scrollTop() >= ($(document).height() - $(window).height()) ){
				//맨 마지막 row 값을 갖고 온다..
				var lastrow = $(".scrolling:last").val();
				
				$.ajax({
					type : 'post',
					url : contextPath+"/search/infiLoad.do",
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					dataType : 'json',
					data : JSON.stringify({
						row : lastrow
					}),
					success : function(data){
							var str = "";
						
						// 5. 받아온 데이터가 ""이거나 null이 아닌 경우에 DOM handling을 해준다.
						if(data != ""){
							//6. 서버로부터 받아온 data가 list이므로 이 각각의 원소에 접근하려면 each문을 사용한다.
							$(data).each(
								// 7. 새로운 데이터를 갖고 html코드형태의 문자열을 만들어준다.
								function(){
									console.log(this);		
									str +=	"<tr class=" + "'listToChange'" + ">" 
										+	 	"<td class=" +  "'scrolling'" + " data-bno='" + this.bno +"'>"
										+			this.bno
										+		"</td>"
										+		"<td>" + this.title + "</td>"		
										+		"<td>" + this.writer + "</td>"
										+		"<td>" + this.regdate + "</td>"
										+		"<td>" + this.viewcnt + "</td>"
								 		+ 	"</tr>";
								 		
							});// each
							// 8. 이전까지 뿌려졌던 데이터를 비워주고, <th>헤더 바로 밑에 위에서 만든 str을  뿌려준다.
							$(".listToChange").empty();// 셀렉터 태그 안의 모든 텍스트를 지운다.						
							$(".scrollLocation").after(str);
						 		
						}// if : data!=null
						else{ // 9. 만약 서버로 부터 받아온 데이터가 없으면 그냥 아무것도 하지말까..
							alert("더 불러올 데이터가 없습니다.");
						}// else
					}//success
				});// ajax

				// 스크롤 다운이벤트 때  ajax통신이 발생하지 않을때 까지의 좌표까지 스크롤을 내려가주기. 
				var position =($(document).height() - $(window).height()) -10;
				
				// 이동  위로 부터 position.top px 위치로 스크롤 하는 것이다. 그걸 500ms 동안 애니메이션이 이루어짐.
				$('html,body').stop().animate({scrollTop : position}, 600, easeEffect);
				
	        }//if : 현재 스크롤의 top 좌표가  <= 0 되는 순간
		
			// lastScrollTop을 현재 currentScrollTop으로 갱신해준다.
			lastScrollTop = currentScrollTop;
		}// else : 업 스크롤인 상태
		
	}); //스크롤 이벤트 종료
	
	

});
</script>
<div class="row" id="lookbottom">
	<div class="container">
		<div class="col-lg-12">
			<c:forEach items="${lookList }" var="lo">
				<div class="gallery_product col-lg-4 scrolling">
					<img src="/board/${lo.img}" class="lookimg"> <input
						type="hidden" class="scrolling" value="${lo.row }">
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/container/footer.jsp"%>