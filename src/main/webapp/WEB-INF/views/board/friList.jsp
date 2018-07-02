<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link href="${pageContext.request.contextPath }/resources/css/friList.css" rel="stylesheet">

<%@ include file="/WEB-INF/views/container/header.jsp"%>

<br>
<div class="container">
    <div class="row">
		<div class="col-lg-offset-1 col-lg-10 col-lg-offset-1">
            <div class="well row">
                <div class="col-md-4 useravatar">
                    <a href="#">
                        <img src="http://placehold.it/160">
                    </a>
                </div>
                <div class="col-md-8">
                    <div class="row">
                        <div class="col-md-5">
                            <h2 class="media-heading">${fri.id }</h2>
                        </div>
                    </div>
                    <br>
            		<div class="row">
            		    <div class="col-md-3 follow">
                            <h4>게시물</h4>
                            <a>10</a>
                        </div>
                        <div class="col-md-3 follow">
                            <h4>팔로우</h4>
                            <a href="${pageContext.request.contextPath }/friend/followerlist.do">25</a>
                        </div>
                        <div class="col-md-3 follow">
                            <h4>팔로잉</h4>
                            <a href="${pageContext.request.contextPath }/friend/followinglist.do">15</a>
                        </div>
                        <div class="col-md-3 follow">
                            <h4>구독</h4>
                            <a href="${pageContext.request.contextPath }/friend/subscribelist.do">5</a>
                        </div>
                    </div>
                    <br>
                    <h4>${fri.name}</h4>
                    <h4>${fri.intro }</h4>
                </div>
            </div>
        </div>
	</div>
</div>
<br>
<c:if test="${empty list }">
<div class="row" id="lookbottom">
	<div class="container">
		<div class="col-lg-12">
			<div class="gallery_product col-lg-offset-4 col-lg-4 col-lg-offset-4">
			<h4> 게시물이 없습니다. </h4>
		   </div>
		</div>
	</div>
</div>
</c:if>	
<c:if test="${not empty list }">
	<div class="row" id="lookbottom">
	<div class="container">
		<div class="col-lg-12">
		<c:forEach var="i" items="${list}">
			<div class="gallery_product col-lg-4">
				<a href="${pageContext.request.contextPath}/board/post.do?bseq=${i.board_seq}">
				<img src="/thumbnail/${i.img}"></a>
			</div>
		</c:forEach>
		</div>
	</div>
</div>		
</c:if>

<%@ include file="/WEB-INF/views/container/footer.jsp"%>