<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$.ajax({
			method:'POST',
			data:{
				'email':$('#email').val()
				},
			url:'member/idResult.do',
			success:function(data){
				data = data.trim();
				if(data!= null){//data아이디 받아오기
					var result = "회원님의 아이디는 " + data + " 입니다.";
					$('span#resultdata').html(result).css('color', 'blue').show();
				}else if(data == null){
					var result = '위 정보에 맞는 아이디가 존재하지 않습니다. 다시 입력하세요'
					$('span#resultdata').html(result).css('color', 'red').show();
				}
			}
		});
	});
</script>
<div class="container-fluid" id="idResult">
<div class="row">
	<div class="col-lg-12">
		<div align="center" id=result>
				<strong><span id="resultdata"> 회원님의 아이디는 ${result}  입니다. </span></strong>
		</div>
	</div>
</div>
</div>