<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HowAboutYourTrip</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Yeseva+One&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/d75e97d418.js" crossorigin="anonymous"></script>
<style type="text/css">

	.divCon
	{
		position: relative;
		top: 0px;
		width: 100%;
		height: 65vh;
		background-color: #6998ab;
	}
	
	#backImg
	{
		position: absolute;
		top: 15%;
		right: 20%;
		width: 400px;
		height: 650px;
		border-radius: 150px;
		border: 6px solid rgb(255,255,255);
		background-image: url('/howAbout/resources/images/3405899.jpg');
		background-repeat: no-repeat;
		background-size: cover;
		background-position: center;
		box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.5);
	}
	
	#mainTitle
	{
		position: absolute;
		top: 10%;
		left: 10%;
		font-family: "Yeseva One", serif;
		font-weight: 600;
		font-style: normal;
		font-size: 24px;
		color: white;
	}
	
	#airPtag
	{
		position: absolute;
		top: 9.4%;
		left: 30%;
		color: white;
		display: inline-block;
 		transform: rotate(90deg);
	}
	
	#mainBox
	{
		
	}
	
</style>
</head>
<body>
	<jsp:include page="./nav.jsp" flush="false"></jsp:include>
	
	<div id="bodyDiv" class="divCon">
		<div id="backImg"></div>
		<div id="mainBox">
			<p id="mainTitle">How About Your Trip?　――――― </p>
			<p id="airPtag">
				<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-airplane-engines-fill" viewBox="0 0 16 16">
					<path d="M8 0c-.787 0-1.292.592-1.572 1.151A4.35 4.35 0 0 0 6 3v3.691l-2 1V7.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.191l-1.17.585A1.5 1.5 0 0 0 0 10.618V12a.5.5 0 0 0 .582.493l1.631-.272.313.937a.5.5 0 0 0 .948 0l.405-1.214 2.21-.369.375 2.253-1.318 1.318A.5.5 0 0 0 5.5 16h5a.5.5 0 0 0 .354-.854l-1.318-1.318.375-2.253 2.21.369.405 1.214a.5.5 0 0 0 .948 0l.313-.937 1.63.272A.5.5 0 0 0 16 12v-1.382a1.5 1.5 0 0 0-.83-1.342L14 8.691V7.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v.191l-2-1V3c0-.568-.14-1.271-.428-1.849C9.292.591 8.787 0 8 0"/>
				</svg>
			</p>
		</div>
	</div>
	
</body>
</html>