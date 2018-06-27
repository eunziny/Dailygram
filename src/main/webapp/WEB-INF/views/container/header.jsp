<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jQuery CDN -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>    
<!-- bootstrap CDN -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- fontawesome icon-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="${pageContext.request.contextPath }/resources/css/header.css" rel="stylesheet">


<!------ Include the above in your HEAD tag ---------->

 <div id='nav-cntainer' style="box-shadow: 0 0 10px #666666">
  <div id='navbar'>
    <div id='left'>
      <a href='${pageContext.request.contextPath}/board/list.do'><img src='${pageContext.request.contextPath }/resources/img/logo.png' id='logo-name'></a>
    </div>
    <div id='center'><input id="input-field" type="text" placeholder='Search' style="text-align: center"></div>
    <div id='right'>
      <ul class="nav navbar-right pull-right top-nav">
      	<li class="dropdown dropdown-notification">
			<a href="${pageContext.request.contextPath }/board/look.do"><span class="glyphicon glyphicon-globe"></span></a>	
      	</li>
      	<li class="dropdown dropdown-notification">
			<a href="${pageContext.request.contextPath }/friend/knownfriend.do"><i class="fas fa-users"></i></a>	
      	</li>
		<li class="dropdown dropdown-notification"> <a class="dropdown-toggle" href="javascript:;" data-toggle="dropdown" data-hover="dropdown" data-close-others="true" aria-expanded="true"> <i class="fas fa-bell"></i> <span class="badge badge-default"> 5 </span> </a>
			<ul class="dropdown-menu dropdown-menu-alerm">
				<li class="external">
					<h3> <span class="bold">12 pending</span> notifications</h3>
					<a href="page_user_profile_1.html">view all</a> 
				</li>
				<li>
					<ul class="dropdown-menu-list">
						<li> <a href="javascript:;"> <span class="time">just now</span> <span class="details"> <span class="label label-sm label-icon label-success"> <i class="fa fa-plus"></i> </span> abb님이 좋아요를 눌렀습니다</span> </a> </li>
						<li> <a href="javascript:;"> <span class="time">3 mins</span> <span class="details"> <span class="label label-sm label-icon label-danger"> <i class="fa fa-bolt"></i> </span> good님이 댓글을 달았습니다:배고파!</span> </a> </li>
						<li> <a href="javascript:;"> <span class="time">10 mins</span> <span class="details"> <span class="label label-sm label-icon label-warning"> <i class="fa fa-bell-o"></i> </span> wow님이 좋아요를 눌렀습니다</span> </a> </li>
						<li> <a href="javascript:;"> <span class="time">14 hrs</span> <span class="details"> <span class="label label-sm label-icon label-info"> <i class="fa fa-bullhorn"></i> </span> happy님이 댓글을 남겼습니다:안녕?</span> </a> </li>
						<li> <a href="javascript:;"> <span class="time">14 hrs</span> <span class="details"> <span class="label label-sm label-icon label-info"> <i class="fa fa-bullhorn"></i> </span> hi님이 댓글을 남겼습니다:야호!</span> </a> </li>
					</ul>
				</li>
			</ul>
		</li>
		<li class="dropdown"> 
			<a href="#" class="dropdown-toggle users" data-toggle="dropdown" aria-expanded="true">
				<img alt="" class="img-circle" src="https://static1.squarespace.com/static/55198f1ce4b00c2cab3e5e30/t/5526d500e4b009f3ec94b422/1428608282728/600x600%26text%3Dprofile+img.gif?format=300w" width="30"> 
				<span class="hidden-xs">Admin User</span> 
			</a>
			<ul class="dropdown-menu">
				<li><a href="${pageContext.request.contextPath }/board/list.do"><i class="fa fa-fw fa-user"></i> My Page</a></li>
				<li><a href="${pageContext.request.contextPath }/member/mem_editForm.do"><i class="fa fa-fw fa-cog"></i> Edit Profile</a></li>
				<li class="divider"></li>
				<li><a href="${pageContext.request.contextPath }/member/login.do"><i class="fa fa-fw fa-power-off"></i> Logout</a></li>
			</ul>
		</li>
	</ul>
    </div>
  </div>
</div>

