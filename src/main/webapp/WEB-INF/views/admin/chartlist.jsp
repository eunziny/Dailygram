<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/admin_header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- chart js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>

<script>
$(function(){
/* 	var joindata = {
			"com_seq":$(this).parents().children('input[id=com_seq]').val(),
			"board_seq": ${b.board_seq}
			}; */
	$.ajax({
        url: "${pageContext.request.contextPath}/admin/chartlist.do",
        type: 'GET',
       /*  dataType: 'json', */
        success: function(data) { 
        //월별 가입자 수 차트
        var joinData = {
        		labels : ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월",
   	    		 "11월", "12월"],
   	    		 datasets: [{
	    	            data: j, //컨트롤러에서 보낸 값을 받음
	    	            backgroundColor: [
	    	                'rgba(54, 162, 235, 0.2)'

	    	            ],
	    	          	label: "월별 가입자 수",
	    	            borderColor: [
	    	                'rgba(54, 162, 235, 1)'

	    	            ],
	    	            borderWidth: 1
	    	        }]
   	    		 
        };
        
        var lct = document.getElementById("lineChart");
		var LineChart = new Chart(lct, {
	    type: 'line', 
	    data: j
	    });
        }
       //연령대 차트
/* 		var bct = document.getElementById("barChart");
		var pieChart = new Chart(bct, {
		    type: 'bar', 
		    data : {
		    	 labels: ["10대", "20대", "30대", "40대", "50대"],
		    	 datasets: [{
		    		 [age],
		    	 }
		    	 label:"연령별 회원 수"
		    },
		    options: {
		    	  animation: {
		              duration: 0, // general animation time
		          },
		          hover: {
		              animationDuration: 0, // duration of animations when hovering an item
		          },
		          responsiveAnimationDuration: 0, // animation duration after a resize
		      }
		    });
		
        //성비 차트
		var pct = document.getElementById("pieChart");
		var pieChart = new Chart(pct, {
		    type: 'pie', 
		    data : {
		    	 labels: ["여자","남자"],
		    	 data: gender,
		    	 label:"회원 성비"
		    },
		    options: {
		    	  animation: {
		              duration: 0, // general animation time
		          },
		          hover: {
		              animationDuration: 0, // duration of animations when hovering an item
		          },
		          responsiveAnimationDuration: 0, // animation duration after a resize
		      }
		    }); */ 
	});
});
</script>

<div class="container">
	<div class="row">
		<div id="join" class="col-lg-offset-3 col-lg-6 col-lg-offset-3">
			<canvas id="lineChart" width="200" height="200"></canvas>
		</div>
		<div id="age"  class="col-lg-offset-3 col-lg-6 col-lg-offset-3">
			<canvas id="barChart" width="200" height="200"></canvas>
		</div>
		<div id="gender"  class="col-lg-offset-3 col-lg-6 col-lg-offset-3">
			<canvas id="pieChart" width="200" height="200"></canvas>
		</div>
	</div>
</div>