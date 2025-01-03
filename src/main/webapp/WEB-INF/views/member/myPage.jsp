<%@page import="com.springproject.domain.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Yeseva+One&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/d75e97d418.js" crossorigin="anonymous"></script>
</head>
<style>
		*
		{
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", serif;
	  		font-optical-sizing: auto;
	  		font-weight: <weight>;
	  		font-style: normal;
        }

        #backgroundCon
        {
        	position: absolute;
        	z-index: -3;
            width: 100%;
            height: 65vh;
            background-color: #6998ab;
        }
        
        #userCon
        {
        	width: 1300px;
        	height: 80vh;
        	background-color: white;
        	border-radius: 30px;
        	display: flex;
        	justify-content: space-between;
        }
        
        #userStatusCon
        {
        	padding: 40px;
        	display: flex;
       		justify-content: space-between;
        }
        
        #userImg
        {
        	width: 200px;
        	height: 200px;
        	border-radius: 30px;
        	background-repeat: no-repeat;
			background-position: center;
			background-size: cover;
			margin-right: 25px;
        }
        
        .userStatsu
        {
        	margin: 0;
        }
        
        .userStatsu:nth-child(2)
        {	
        	position: relative;
        	width: 700px;
        }
        
        .userStatsu > h2
        {
        	margin-top: 30px;
        	margin-bottom: 15px;
        }
        
        .userStatusDiv
        {
        	display : flex;
        	justify-content: space-between;
        	width: 1000px;
        }
        
        .userIdClass
        {
        	color: #ccc;
        	font-size: 12px;
        	font-weight: 600;
        }
        
        .pTagclass
        {
        	margin-bottom: 5px;
        	color: #909090;
        }
        
        .userSelect
        {
        	margin-top: 20px;
        }
        
        .selectAtag
        {
        	color: black;
        	font-size: 14px;
        }
        
        .delete
        {
        	color: red;
        }
        
        .statusLeftBar
        {
        	position: absolute;
        	left: 0;
        	width: 100px;
        	height: 200px;
        	margin: 0;
        	border-left: 5px dotted #6998ab;
        }
        
        .statusTitle
        {
        	height: 45px;
        	width: 550px;
        	line-height: 45px;
        	text-align: center;
        	background-color: #6998ab;
        	border-radius: 10px;
        	font-weight: 700;
        	font-size: 18px;
        	color: white;
        }
        
        .reviewAndDiary
        {
        	width: 550px;
        	display: flex;
        	justify-content: space-around;
        }
        
        .myWrite
        {
        	width: 250px;
        	height: 130px;
        	background-color: #FF6F61;
        	border-radius: 30px;
        	margin: 10px;
        }
        
        .myWrite:nth-child(2) {
			background-color: #FFF5E1;
		}
		
		.writeTitle
		{
			height: 35px;
			line-height: 35px;
			margin-top: 10px;
			text-align: center;
			font-weight: 700;
			font-size: 20px;
			color: #2C3E50;
		}
		
		.writeInt
		{
			text-align: center;
		}
        

</style>
<body>
	<jsp:include page="../nav.jsp" flush="false"></jsp:include>
	<div class="container-fluid" id="backgroundCon"></div>
	
	<% Member member = (Member)request.getAttribute("member"); %>
	
	<div id="userCon">
		<div id="rightMenu">
			<div id="userStatusCon">
				<div id="userImg"></div>
				<div class="userStatusDiv">
					<div class="userStatsu">
						<h2> <%= member.getUserName() %> <span class="userIdClass"> <%= member.getUserId() %> </span> </h2>
						<p class="pTagclass"> <%= member.getUserEmail() %> </p>
						<p class="pTagclass"> <%= member.getUserAddr() %> </p>
						<p class="userSelect">
							<a class="selectAtag" href="/howAbout/user/update/<%= member.getUserId() %>">정보수정</a> |
							<a class="selectAtag delete" href="/howAbout/user/delete">회원탈퇴</a>
						</p>
					</div>
					<div class="userStatsu">
						<div class="statusLeftBar"></div>
						<p class="statusTitle">내가 작성한 글을 확인해보세요</p>
						<div class="reviewAndDiary">
							<div class="myWrite">
								<p class="writeTitle">리뷰</p>
								<p class="writeInt">0개</p>
							</div>
							<div class="myWrite">
								<p class="writeTitle">다이어리</p>
								<p class="writeInt">0개</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="reviewAndDiary"></div>
			<div class="lastMenu"></div>
		</div>
	</div>
	
</body>

<script type="text/javascript">
	$(document).ready(function() {
	    $('#userImg').css('background-image', 'url("/howAbout/resources/userIcon/<%=member.getIconName()%>")');
	});
</script>
</html>