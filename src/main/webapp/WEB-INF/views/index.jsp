<%@page import="com.springproject.domain.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HowAboutYourTrip</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/d75e97d418.js" crossorigin="anonymous"></script>
<style type="text/css">
	@font-face
	{
		font-family: 'GmarketSansMedium';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
	    font-weight: 700;
	    font-style: normal;
	}

	@font-face
	{
		font-family: 'LINESeedKR-Bd';
		src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
		font-weight: 700;
		font-style: normal;
	}
	
	*
	{
		font-family: 'LINESeedKR-Bd';
	}

	html
	{
		height: 100%;
		margin: 0;
		overflow: hidden;
		margin: 0;
		height: 100vh;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	#backgroundimg
	{
		position: absolute;
		z-index: -10;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		width: 100%;
	    height: 100vh; /* 뷰포트 전체 높이 설정 */
	    background-color: transparent;
	    background-image: url('/howAbout/resources/img/mainlogo.png');
	    background-size: cover;
	    background-position: center;
	    background-repeat: no-repeat;
	}
	
	.login-container {
		position: relative;
		z-index: 3; /* 로그인 창이 배경 위에 나타나도록 설정 */
		width: 400px;
	}

	.container
	{
		width: 100%;
    	height: 100vh; /* 뷰포트 전체 높이 설정 */
		display: flex; /* 필요한 경우 레이아웃 조정 */
		flex-direction: column; /* 세로 방향으로 정렬 */
		justify-content: center; /* 가로 가운데 정렬 */
		align-items: center; /* 세로 가운데 정렬 */
	}
	
	.map-container
	{
		position: relative;
		width: 100%;
		height: auto;
	}

	.map
	{
		width: 100%;
		height: auto;
	}
	
	.clickable-layer
	{
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		cursor: pointer;
		/* 레이어의 투명도 조절 */
		background-color: rgba(255, 255, 255, 0); /* 투명하게 설정 */
	}
	
	.modal-bg
	{
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: rgba(0, 0, 0, 0.3); /* 검은색 배경과 40% 투명도 */
		display: block;
		z-index: 2; /* 로그인 창 위에 위치하도록 설정 */
	}
	
	.login-form
	{
		z-index: 3; /* 로그인 폼이 모달 배경 위에 위치하도록 설정 */
	}
	
	.loginBG
	{
		background-color: rgba(255,255,255,0.7);
	}
	
	.action-buttons
	{
		position: relative;
		z-index: 3; /* 로그인 폼과 같은 z-index 수준 */
		display: flex;
		justify-content: space-around; /* 버튼 간격 조정 */
		margin-top: 20px; /* 로그인 폼과 버튼 간격 */
	}
	
	.category-btn
	{
		margin-top: 70px;
		margin-left: 45px;
		margin-right: 45px;
		width: 150px;
		height: 120px;
		border-radius: 130px;
		background-color: white;
		border: none;
	}
	
	.category-btn
	{
		color: gray;
	    font-family: 'GmarketSansMedium';
	    font-size: 20px;
	}
	
	.login-btn
	{
		margin-bottom: 10px;
		border: none;
		padding: 10px 20px;
		border-radius: 5px;
		cursor: pointer;
		font-weight: bold;
		width: 100%; /* 버튼을 가득 채움 */
	}
	
	.kakao-login-btn
	{
		background-color: #FEE500; /* 카카오 색상 */
		color: #3C1E1E; /* 글자 색상 */
		border: none;
		padding: 10px 20px;
		border-radius: 5px;
		cursor: pointer;
		font-weight: bold;
		width: 100%; /* 버튼을 가득 채움 */
		transition: background-color 0.3s; /* 배경 색상 변화에 애니메이션 추가 */
	}
	
	.kakao-login-btn:hover
	{
		background-color: #fdd835; /* hover 시 진해지는 색상 */
	}
	
	.homeNav
	{
		position: fixed; 
		top: 0;
		left: 0;
		z-index: 6;
		width: 100%;
		background-color: gray;
		padding: 10px 0;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.nav-item
	{
		display: inline-block;
		margin: 0 15px;
		color: white;
		text-decoration: none;
	}

	.userDiv
	{
		display: flex;
		justify-content: space-between;
	}
	
	.user-btn
	{
		display: inline-block;
		width: 47%;
		height: 50px;
		text-decoration: none;
		text-align: center;
		background-color: white;
		border-radius: 10px;
		line-height: 50px;
		margin-top: 10px;
	}
	
	#mainMenu
	{
		width: 1920px;
	}
	
	
	.main_one
	{
		width: 100%;
		display: flex;
		justify-content: space-between;
	}

	[class^="mainMenu"]
	{
		position: relative;
		width: 24%;
		height: 300px;
		background-color: white;
		border-radius: 30px;
		margin-bottom: 20px;
		text-align: center;
	}
	
	[class^="mainMenu"] > i
	{
		font-size: 90px;
		color: gray;
	}
	
	.mainMenuText
	{
		height: 0px;
		top: 30%; /* 부모 요소의 세로 중앙 */
    	left: 50%; /* 부모 요소의 가로 중앙 */
		position: absolute;
		transform : translate(-50%, -50%);
	}
	
	.category-btn > .fa-solid
	{
		font-size: 36px;
		color: gray;
	}
	
</style>
</head>

<body>

	<div class="container" id="backgroundimg"></div>

	<%
		String error = (String)request.getAttribute("miss");
		System.out.print(error);
		HttpSession session = request.getSession(false);
		Member member = null;
	
		if(session != null){ member = (Member)session.getAttribute("userStatus"); }
		
		if(member == null){
	%>
		<div class="modal-bg" id="modalBg"></div>
		<div class="container">
			<div class="login-container login-form">
				<div class="loginBG p-4 shadow rounded">
					<h2 class="LINESeedKR">로그인</h2>

					<form method="post" action="/howAbout/user/login" id="loginForm">
						<%
							if(error != null){
						%>
								<p>아이디 혹은 비밀번호가 맞지 않습니다.</p>
							
						<%
							}
						%>
						<div class="mb-3">
							<label for="username" class="form-label">아이디</label>
							<input name="userId" type="text" class="form-control" id="username" required>
						</div>
						<div class="mb-3">
							<label for="password" class="form-label">비밀번호</label>
							<input name="userPw" type="password" class="form-control" id="password" required>
						</div>
						<button type="submit" class="LINESeedKR login-btn">로그인</button>
						<button id="kakao-login-btn" class="kakao-login-btn">카카오로 로그인</button>
						<div class="userDiv">
							<a href="/howAbout/user/joinMember" class="LINESeedKR user-btn">회원가입</a>
							<a href="/howAbout/" class="LINESeedKR user-btn">회원조회</a>
						</div>
						
					</form>
				</div>
			</div>
			<div class="action-buttons">
				<button class="category-btn"><i class="fa-solid fa-explosion"></i><br>축제</button>
				<button class="category-btn"><i class="fa-solid fa-bowl-food"></i><br>맛집</button>
				<button class="category-btn"><i class="fa-solid fa-map-location-dot"></i><br>관광</button>
				<button class="category-btn"><i class="fa-solid fa-comments"></i><br>후기</button>
			</div>
		</div>
		
	<%
		} else {
	%>
		<div class="homeNav">
			<nav>
				<a href="/howAbout/user/logout" class="nav-item">로그아웃</a>
				<a href="/howAbout/" class="nav-item">회원정보</a>
				<a href="/howAbout/" class="nav-item">다이어리</a>
				<a href="/howAbout/" class="nav-item">여행계획</a>
				<a href="/howAbout/" class="nav-item">캘린더</a>
			</nav>
		</div>
		
		<div id="mainMenu" class="container">
			<div class="main_one">
				<div class="mainMenu1"> <div class="mainMenuText"><i class="fa-solid fa-user-tag"></i><br><a href="/howAbout/user/myPage">내 정보</a></div> <div class="main_under1"></div> </div>
				<div class="mainMenu2"> <div class="mainMenuText"><i class="fa-solid fa-book"></i><br>다이어리</div> <div class="main_under2"></div> </div>
				<div class="mainMenu3"> <div class="mainMenuText"><i class="fa-solid fa-paper-plane"></i><br>여행계획</div> <div class="main_under3"></div> </div>
				<div class="mainMenu4"> <div class="mainMenuText"><i class="fa-solid fa-calendar"></i><br>캘린더</div> <div class="main_under4"></div> </div>
			</div>
			<div class="main_one">
				<div class="mainMenu5"> <div class="mainMenuText"><i class="fa-solid fa-explosion"></i><br>축제</div></div>
				<div class="mainMenu6"> <div class="mainMenuText"><i class="fa-solid fa-bowl-food"></i><br><a href="/howAbout/place/serchRest">맛집</a></div></div>
				<div class="mainMenu7"> <div class="mainMenuText"><i class="fa-solid fa-map-location-dot"></i><br>관광</div></div>
				<div class="mainMenu8"> <div class="mainMenuText"><i class="fa-solid fa-comments"></i><br>후기</div></div>
			</div>
		</div>

	<%
		}
	%>

</body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
	$(document).ready(function() {
	    let userId;
	    
	    $.ajax({
	        url: '/howAbout/review/sessionInfo',
	        type: 'GET',
	        success: function(memberData) {
	        	if(memberData.userId != '-----'){
		        	var div = document.getElementById('backgroundimg');
		        	div.style.backgroundImage = "url('/howAbout/resources/img/mainlogo배경.png')";
	        	}

	        },
	        error: function(xhr, status, error) {
	            console.error('Member 정보 로드에 실패했습니다.', error);
	        }
	    });
	});
</script>
</html>