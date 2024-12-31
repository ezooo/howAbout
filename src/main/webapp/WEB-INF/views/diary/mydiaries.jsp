<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ page import="com.springproject.domain.Diary" %>
<%@ page import="com.springproject.domain.Member" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HowAbout_MyDiary</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
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
body{
	width : 100%;
}
#body {
    padding: 20px;
        width : 100%;
        font-family: "Noto Sans KR", serif;
}
.container {
     max-width: 80%; /* 최대 너비 설정 */
     margin: 0 auto; /* 중앙 정렬 */
     padding: 20px; /* 양쪽 여백 설정 */
 }
    .diary-box {
        position: relative;
        border: 1px hidden;
        border-radius: 4px; /* 둥글기 조정 */
        overflow: hidden;
        margin-bottom: 20px;
	    width: 100%; /* 박스 너비 100% */
	    aspect-ratio: 6 / 5; /* 가로:세로 비율 6:5 */
        background-color: rgba(255, 255, 255, 0.78); 
        display: flex; /* Flexbox 사용 */
        justify-content: center; /* 중앙 정렬 */
        align-items: center; /* 중앙 정렬 */
        transition: all 0.3s ease; /* 부드러운 전환 효과 */
        background-size: cover; /* 배경 이미지 크기 조정 */
	    background-position: center; /* 배경 이미지 중앙 정렬 */
	    margin-bottom: 0px; /* 아래쪽 간격 설정 */
	    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.5); /* 그림자 추가 */
    }

    /* 일반 박스의 최대 크기 설정 */
    .regular-box {
        max-width: 500px; /* 최대 가로 길이 300px */
        max-height: 400px; /* 최대 세로 길이 250px */
    }
    	        /* 박스 사이의 간격을 고정 */
	    .col-6, .col-md-4{
	        padding: 10px; /* 박스 간격 설정 (좌우 간격) */
	    }
    .hover-overlay {
        position: absolute; /* 이미지 위에 띄우기 */
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(255, 255, 255, 0.75); 
        opacity: 0; /* 기본적으로 숨기기 */
        transition: opacity 0.3s ease; /* 부드러운 전환 효과 */
    }
    .diary-box:hover .hover-overlay {
        opacity: 1; /* 호버 시 나타나기 */
    }
    .diary-info {
        position: absolute; /* 이미지 위에 띄우기 */
        bottom: 6px;
        left: 10px;
        right: 0;
        margin: 0;
        opacity: 0; /* 기본적으로 숨기기 */
        transform: translateY(100%);
        transition: opacity 0.3s ease, transform 0.6s ease; /* 부드러운 전환 효과 */
    }
    .diary-box:hover .diary-info {
        opacity: 1; /* 호버 시 나타나기 */
        transform: translateY(0);
    }
        .header{
        	text-align: center;
        }
	    .header h2 {
	        font-family: "Noto Sans KR", serif; /* 폰트 적용 */
	         /* 기울임체 적용 */
	        font-size: 30px;
	        padding-bottom: 10px;
	    }
	    .header p {
	        font-family: "Noto Sans KR", serif; /* 폰트 적용 */
	        font-size: 14px;
	    }
	    .diarywrite
	    {
	    	text-align: right;
	    	align-content: center;
	    	padding: 10px 5%;
	    }
	    .diarywrite > a
	    {
	    	padding : 0 5px;
	    	text-decoration: none;
	    	color : black;
	    }
	    .bi
	    {
	    	font-size: 16px;
	    }
	    .header i
	    {
	    	font-size: 30px;
	    	font-weight: 400;
	    }
	    .custom-badge {
            background-color: rgba(247, 166, 89, 0.9); 
            color: white; /* 텍스트 색상 */
            padding: 2px 4px; /* 패딩 조정 */
            font-size: 12px; /* 글꼴 크기 조정 */
            border-radius: 4px;
            font-weight: 300;
        }
</style>
</head>
<body>
<%
    List<Diary> diaryList = (List<Diary>)request.getAttribute("diaryList");
    HttpSession ssn = request.getSession(false);
    Member mb = (Member)ssn.getAttribute("userStatus");
%>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<div id="body">
<%
if(mb != null) {
%>  
<div class="header">
	<h2><i class="bi bi-book"></i>&nbsp;MY DIARY</h2>
	<p> 다이어리를 작성하고 추억을 저장해보세요 ! </p>
</div>
<div class="diarywrite">
	<a href="/howAbout/diaries/addDiary"><i class="bi bi-pencil-square"></i>&nbsp;작성</a>
	<a href="/howAbout/diaries"><i class="bi bi-book"></i>&nbsp;다이어리 홈으로</a>
</div>
    <div class="container">
        <div class="row">
<%
        for(Diary diary : diaryList) {
%>
            <div class="col-6 col-md-4">
                <div class="diary-box regular-box" style="background-image: url('/howAbout/resources/images/<%=diary.getFilename0()%>');">
                    <a href="/howAbout/diaries/diary/<%= diary.getDiaryId()%>" style="display: block; height: 100%;">
                        <div class="hover-overlay"></div>
                        <div class="diary-info">
                            <span class="badge custom-badge" style="margin-bottom: 5px;">
                            	<% if(diary.getIsopen().equals("true")) { %> 공개 <% } else { %> 비공개 <% } %>
                            </span>
                            <p style="font-size: 15px; margin: 0;">
                                <span style="font-size: 12px;"><%= diary.getVisit_date() %>&nbsp;</span> &raquo; <%= diary.getVisit_location()%> 
                            </p>
                        </div>
                    </a>
                </div>
            </div>
<%
        }
%>
        </div>
    </div>
<%
} else {
%>
    <p> 로그인하고 내 다이어리를 작성해보세요</p>
    <a href="login">로그인</a> <br>
<%
}
%>
</div>
</body>
</html>