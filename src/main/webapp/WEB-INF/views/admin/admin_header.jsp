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
 <div id='nav-container'>
  <div id='navbar'>
    <div id='left'>
    <!--Input Logo -->
      <a class="brand" href="#" name="top">Dailygram <!-- <img src="/docs/4.0/assets/brand/bootstrap-solid.svg" width="30" height="30" class="d-inline-block align-top" alt=""> --></a>		
    </div>
    <div id='center'>
    	 <ul class="nav navbar-right pull-right top-nav">
      	<li>
			<a href="#"><i class="fas fa-chart-bar"></i>통계</a>
      	</li>
      	<li>
			<a href="#"><i class="fas fa-bullhorn"></i>신고게시물</a>
      	</li>
      	<li>
			<a href="#"><i class="fa fa-fw fa-power-off"></i> Logout</a>
      	</li>
	</ul>	
    </div>
    <div id='right'>
    </div>
  </div>
</div>
</html>