<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
       //월별 가입자 수 차트
     	 //차트(선) 값 생성
     	var j = new Array();
       <c:forEach items="${join}" var="j">
       	var json = new Object();
       	j.push("${j.jan}");
       	j.push("${j.feb}");
       	j.push("${j.mar}");
       	j.push("${j.apr}");
       	j.push("${j.may}");
       	j.push("${j.jun}");
       	j.push("${j.jul}");
       	j.push("${j.aug}");
       	j.push("${j.sept}");
       	j.push("${j.oct}");
       	j.push("${j.nov}");
       	j.push("${j.de}");
       </c:forEach>
        var lct = document.getElementById("lineChart");
		var pieChart = new Chart(lct, {
		    type: 'line',
		    data : {
		    	 labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월",
	   	    		 "11월", "12월"],	
		    	 datasets: [{
					label: '월별',
					data : j,
					backgroundColor : ['rgba(54, 162, 235, 0.2)'],
					 borderColor: ['rgba(54, 162, 235, 1)'],
					 borderWidth: 1
					}] 
		    	 },
		    options: {
		    	  title: {
		              display: true,
		              text: '가입자 수',
		              fontSize:20
		          },
			    scales: { 
			    	 yAxes: [{ 
			    		ticks: { 
			    			beginAtZero:true ,
			    			  	} 
			    	  		}] 
		    	 		},   // 데이터값 시작을 0부터시작
		    	  
			      animation: {
		              duration: 0, // general animation time
		          },
		          hover: {
		              animationDuration: 0, // duration of animations when hovering an item
		          },
		          responsiveAnimationDuration: 0, // animation duration after a resize
		      }
		    });
			
			//연령대 차트
			//차트(막대) 값 생성
			var a = new Array();
       		<c:forEach items="${age}" var="a">
       		var json = new Object();
       		a.push("${a.age_10}");
	       	a.push("${a.age_20}");
	       	a.push("${a.age_30}");
	       	a.push("${a.age_40}");
	       	a.push("${a.age_50}");
	       	a.push("${a.age_60}");
       		</c:forEach>
			var bct = document.getElementById("barChart");
			var pieChart = new Chart(bct, {
				    type: 'bar', 
				    data : {
				    	 labels: ["10대", "20대", "30대", "40대", "50대"],
				    	 datasets: [{
								label: '나이별',
								data : a,
								backgroundColor : ['rgba(242, 133, 184, 0.2)','rgba(54, 162, 235, 0.2)','rgba(255, 159, 64, 0.2)', 
													'rgba(140, 66, 244, 0.2)', 'rgb(139, 239, 180, 0.2)'],
								 borderColor: ['rgba(242, 133, 184,1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 159, 64, 1)', 
									 			'rgba(140, 66, 244,1)', 'rgb(139, 239, 180, 1)' ],
								 borderWidth: 1
								}] 
					    	 },
					    options: {
					    	  title: {
					              display: true,
					              text: '연령대 별 회원 수',
					              fontSize:20
					          },
						    scales: { 
						    	 yAxes: [{ 
						    		ticks: { 
						    			beginAtZero:true ,
						    			  	} 
						    	  		}] 
					    	 		},   // 데이터값 시작을 0부터시작
					    	  
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
			 //차트(파이) 값 생성
			 var g = new Array();
       		<c:forEach items="${gender}" var="g">
       		var json = new Object();
       		g.push("${g.f}");
	       	g.push("${g.m}");
       		</c:forEach>
			var pct = document.getElementById("pieChart");
			var pieChart = new Chart(pct, {
			    type: 'pie', 
			    data : {
			    	 labels: ["여자","남자"],
			    	 datasets: [{
							label: '성별',
							data : g,
							backgroundColor : ['rgba(252, 247, 93, 0.2)','rgba(74, 247, 88, 0.2)'],
							 borderColor: ['rgba(252, 247, 93, 1)', 'rgba(74, 247, 88, 1)'],
							 borderWidth: 1
							}] 
				    	 },
			    options: {
			    	  title: {
			              display: true,
			              text: '회원 성비',
			              fontSize:20
			          },
				    scales: { 
				    	 yAxes: [{ 
				    		ticks: { 
				    			beginAtZero:true ,
				    			  	} 
				    	  		}] 
			    	 		},   // 데이터값 시작을 0부터시작
			    	  
				      animation: {
			              duration: 0, // general animation time
			          },
			          hover: {
			              animationDuration: 0, // duration of animations when hovering an item
			          },
			          responsiveAnimationDuration: 0, // animation duration after a resize
		}
	});
});
		
</script>
<style>
#age, #join, #gender {
	padding-bottom:10%;
}
</style>
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