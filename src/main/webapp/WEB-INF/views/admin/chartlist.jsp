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
/* 	$.ajax({
        url: "${pageContext.request.contextPath}/admin/chartlist.do",
        type: 'GET',
        dataType: 'json',
        success: function(data) { */ 
        //월별 가입자 수 차트
  /*       console.log(data); */
       /*  var j = [;
        for(var i in data) {
        	j.push(data[i].j);
        } */
      //차트 값 생성
     var data = new Array();
       <c:forEach items="${join}" var="j">
       	var json = new Object();
       	data.push("${j}");
       </c:forEach>
        var lct = document.getElementById("lineChart");
		var pieChart = new Chart(lct, {
		    type: 'line',
		    data : {
		    	 labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월",
	   	    		 "11월", "12월"],	 
		    	 datasets: [{
					data : data,
					backgroundColor : ['rgba(255, 99, 132, 0.2)'],
					 borderColor: ['rgba(255,99,132,1)'],
					 borderWidth: 1
					}] 
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
        /* } */
        console.log(data);
    });
/* }); */
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