<%@page import="com.springproject.domain.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네비게이션</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<style>
.noto-sans-kr-<uniquifier> {
	  font-family: "Noto Sans KR", serif;
	  font-optical-sizing: auto;
	  font-weight: <weight>;
	  font-style: normal;
	}
*{
	margin : 0 auto;
	padding : 0px;
	box-sizing: border-box;
	text-decoration: none;
}
#navbox
{
	font-family: "Noto Sans KR", serif;
	background-color: #6998AB;
	padding: 20px;
	display : flex;
	justify-content: space-between;
	width : 100%;
}
#navbox a{
	font-style: none;
	color : white;
	text-decoration: none;
	font-size: 14px;
	padding : 0 2px;
	font-weight : 600;
}

.navleft img
{
	width : 70px;
	height : 50px;
}

#navbox .navmiddle a
{
	padding : 0 10px;
}
</style>
</head>

<body>
<%
	HttpSession ssn = request.getSession(false);
%>
<div id="navbox">
	<div class="navleft">
		<a href="/howAbout/">howAbout </a>
	</div>
	<div class="navmiddle">
		<a href="/howAbout/diaries">다이어리</a>
		<a href="/howAbout/recommend">추천게시판</a>
		<a href="/howAbout/location">관광지</a>
		<a href="/howAbout/place">시설검색</a>
		<a href="/howAbout/review">리뷰</a>
		<a href="/howAbout/festival">축제</a>
		<a href="/howAbout/schedule">캘린더</a>
	</div>
	<div class="navright">
	<%
		if(ssn != null) 
		{
		    Member mb = (Member)ssn.getAttribute("userStatus");
		    if(mb != null) {
	%>
		    <a href="/howAbout/user/readOne">마이페이지</a>
		    <a href="/howAbout/user/logout">로그아웃</a>
	<%
		    }
		    else
		    {
	%>	    	
		    	<a href="/howAbout/user/login">로그인</a>
				<a href="/howAbout/user/joinMember">회원가입</a>
	<%
		    }
		}
		else
		{
	%>
			<a href="/howAbout/user/login">로그인</a>
			<a href="/howAbout/user/joinMember">회원가입</a>
	<%
		}
	%>
	</div>
</div>
</body>
</html>