<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Yeseva+One&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/d75e97d418.js" crossorigin="anonymous"></script>
<style type="text/css">

	*{
	  font-family: "Noto Sans KR", serif;
	  font-optical-sizing: auto;
	  font-weight: <weight>;
	  font-style: normal;
	}

	.divCon
	{
		position: relative;
		width: 100%;
		height: 65vh;
		background-color: #6998ab;
	}
	
	#loginDiv
	{
		position: absolute;
		top: 50%;
		left: 50%;
		transform : translate(-50%, -50%);
		display: flex;
		justify-content: space-around;
		width: 900px;
		height: 500px;
		border-radius: 20px;
		background-color: white;
	}
	
	.loginInput
	{
		display: block;
		height: 26px;
		border: none;
		border-bottom: 2px solid #6998ab;
		outline: none;
	}
	
	.inputTag
	{
		width: 30px;
		font-size: 16px;
	}
	
	.loginInputFormDiv
	{
		position: absolute;
		top: 55%;
		left: 45%;
		transform : translate(-50%, -50%);
	}
	
	.loginInputDiv
	{
		width: 300px;
		height: 50px;
		display: flex;
		justify-content: space-around;
	}
	
	.loginDivs
	{
		position: relative;
		width: 430px;
		margin: 5px;
	}
	
	#loginTitle
	{
		position: absolute;
		top: 15%;
		left: 50%;
		transform : translateX(-50%);
		color: #6998ab;
		font-size: 44px;
		text-align: center;
		font-weight: 600;
	}
	
	#loginBtn
	{
		display: block;
		position: absolute;
		top: 80%;
		left: 50%;
		transform : translate(-50%, -50%);
		width: 200px;
		height: 60px;
		background-color: #6998ab;
		border-radius: 30px;
		color: white;
		border: none;
	}
	
	#createTitle
	{
		position:absolute;
		top: 15%;
		left: 50%;
		transform : translateX(-50%);
		background-color: #6998ab;
		color: white;
		text-align: center;
		width: 300px;
		height: 60px;
		font-size: 34px;
		font-weight: 600;
	}
	
	#startMember
	{
		position:absolute;
		top: 30%;
		left: 50%;
		transform : translateX(-50%);
	}
	
	#joinMember
	{
		position:absolute;
		top: 72%;
		left: 50%;
		transform : translateX(-50%);
	}
	
	.startBtn
	{
		display: block;
		width: 300px;
		height: 45px;
		border-radius: 5px;
		color: white;
		text-decoration: none;
		background-color: #03c75a;
		margin: 10px;
		text-align: center;
		line-height: 45px;
		padding-left: 22px;
	}
	
	.kakaologin
	{
		background-image: url('/howAbout/resources/img/kakao_login_medium_wide.png');
		background-position: center;
		background-size: cover;
		background-repeat: no-repeat;
	}
	
	.naverlogin
	{
		background-image: url('/howAbout/resources/img/btnG_아이콘사각.png');
		background-position: left;
		background-size: contain;
		background-repeat: no-repeat;
	}
	
	#joinus
	{
		position: absolute;
		width: 200px;
		text-align: center;
		top: -10px;
		left: 50%;
		transform : translateX(-50%);
		color: gray;
	}
	
	.joinbar
	{
		display: block;
		height: 45px;
		line-height: 45px;
		color: gray;
	}
	
	.joinBtn
	{
		display: block;
		width: 200px;
		height: 45px;
		text-align: center;
		line-height: 45px;
		color: #6998ab;
	}
	
	.withMember
	{
		display: flex;
		justify-content: space-around;
		width: 300px;
	}
	
	.errorRed
	{
		color: red;
		width: 400px;
		font-weight: 700;
		position: absolute;
		top: 30%;
		left: 50%;
		transform : translateX(-50%);
		text-align: center;
		font-size: 16px;
	}
</style>
</head>
<body>
	<jsp:include page="../nav.jsp" flush="false"></jsp:include>
	
	<div class="divCon">
	
		<div id="loginDiv">
			<div class="loginDivs" id="loginFormDiv">
				<p id="loginTitle">Login</p>
				<form action="login" method="post">
					<%
						String error = (String)request.getAttribute("miss");
						if(error != null){
					%>
						<p class="errorRed">아이디 혹은 비밀번호가 맞지 않습니다.</p>
					<%
						}
					%>
					<div class="loginInputFormDiv">
						<div class="loginInputDiv">
							<p class="inputTag">ID</p>
							<input class="loginInput" type="text" name="userId" placeholder="아이디를 입력하세요"> 
						</div>
						<div class="loginInputDiv">
							<p class="inputTag">PW</p>
							<input class="loginInput" type="password" name="userPw" placeholder="비밀번호를 입력하세요">
						</div>
					</div>
					
					<input id="loginBtn" type="submit" value="로그인">
				</form>
			</div>
			<div class="loginDivs" id="loginRight">
				<p id="createTitle">Get Start</p>
				<div id="startMember">
					<a href="/howAbout/user/kakao/login" class="kakaologin startBtn"></a>
					<a class="startBtn naverlogin">네이버로 로그인</a>
				</div>
				<div id="joinMember">
					<p id="joinus">회원이 아니신가요?</p>
					<hr>
					<div class="withMember">
						<a href="/howAbout/user/joinMember" class="joinBtn">회원가입</a>
						<span class="joinbar">|</span>
						<a class="joinBtn">아이디 찾기</a>
						<span class="joinbar">|</span>
						<a class="joinBtn">비밀번호 찾기</a>
					</div>

				</div>
			</div>
		</div>

		
	</div>

	<p> <a href="/howAbout/user/home">Home</a> </p>
</body>
</html>