<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- jQuery CDN -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>    
<!-- bootstrap CDN -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- fontawesome icon-->
<script src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<!-- Custom CSS -->
<link href="${pageContext.request.contextPath }/resources/css/admin_header.css" rel="stylesheet">
<title>admin header</title>
 <div id='nav-container' style="box-shadow: 0 0 10px #666666">
  <div id='navbar'>
    <div id='left' class="navbar-header">
    <!--Input Logo -->
     <a href='#'><img src='${pageContext.request.contextPath }/resources/img/logo.png' id='logo-name'></a>
    </div>
    <div id='center'>
        <ul class="nav navbar-right pull-right top-nav">
         <li>
         <a href="#"><i class="fas fa-chart-bar"></i>통계</a>
         </li>
         <li>
         <a href="${pageContext.request.contextPath }/admin/deleteHashtag.do"><i class="glyphicon glyphicon-eye-close"></i>해시태그관리</a>
         </li>
   		</ul>   
    </div>
    <div id='right'>
    	<ul class="nav navbar-right pull-right top-nav">
    	<li>
         <a href="${pageContext.request.contextPath }/admin/chargelist.do"><i class="fas fa-bullhorn"></i>신고게시물</a>
         </li>
         <li>
         <a href="${pageContext.request.contextPath }/member/logout.do"><i class="fa fa-fw fa-power-off"></i>Logout</a>
         </li>
         </ul>
    </div>
  </div>
</div>
</html>