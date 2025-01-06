<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@page import="com.springproject.domain.Recommendation"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recommendation</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<style>
.noto-sans-kr-<uniquifier> {
    font-family: "Noto Sans KR", serif;
    font-optical-sizing: auto;
    font-weight: <weight>;
    font-style: normal;
}
* {
    margin: 0 auto;
    padding: 0px;
    box-sizing: border-box;
    text-decoration: none;
}
body {
    width: 100%;
}
#body {
    padding: 20px;
    width: 100%;
    font-family: "Noto Sans KR", serif;
}
.container {
    max-width: 80%; /* 최대 너비 설정 */
    margin: 0 auto; /* 중앙 정렬 */
}
.header {
    text-align: center;
}
.header h1 {
    font-family: "Noto Sans KR", serif; /* 폰트 적용 */
    font-size: 30px;
    font-weight: 600;
}
.recommend-title {
    font-size: 1.5rem; /* 제목 글씨 크기 조정 */
    font-weight: bold; /* 제목 두께 */
}
.recommend-content {
    line-height: 1.5; /* 추천 내용 줄 간격 조정 */
}
.clickBox {
    padding: 10px 30px;
    width: 100%;
    display: flex;
    justify-content: center;
    max-width: 1200px;
}
.clickBox a {
    display: inline-block;
    width: 60px;
    text-align: center;
    text-decoration: none;
    padding: 5px 15px;
    font-size: 13px;
    margin: 20px 2px;
    border: 1 hidden;
    border-radius: 7px;
    background-color: #6998AB; 
    color: white;
}
.clickBox a:hover {
    background-color: rgba(39, 118, 221, 0.5);
    transition: 0.5s ease;
}
	    .boardnav
	    {
	    	text-align: right;
	    	align-content: center;
	    	padding: 10px 5%;
	    }
	    .boardnav > a
	    {
	    	padding : 0 5px;
	    	text-decoration: none;
	    	color : black;
	    }
	    .bi
	    {
	    	font-size: 16px;
	    }
</style>
</head>

<body>
<%
	Recommendation recommendation = (Recommendation)request.getAttribute("recommendation");
%>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<div id="body">
    <div class="header">
        <h1 class="title">여행지를 추천합니다!</h1>
    </div>
    <div class="boardnav">
		<a href="/howAbout/recommend/addRecommend"><i class="bi bi-pencil-square"></i>&nbsp;작성</a>
		<a href="/howAbout/recommend">&nbsp;전체보기</a>
	</div>
    <div class="container mt-5">
        <p>제 목 : <span class="recommend-title"><%= recommendation.getRecommendTitle() %></span></p>
        <p>작성자 : <span><%= recommendation.getUserId() %></span></p>
        <p>작성일 : <span><%= recommendation.getRecommendDate() %></span></p>
        <hr>
        <p>추천 내용 : <span class="recommend-content"><%= recommendation.getRecommendContent() %></span></p>
        <div class="clickBox">
            <a href="/howAbout/recommend/update/<%=recommendation.getRecommendId()%>">수정</a> 
            <a href="/howAbout/recommend/delete/<%=recommendation.getRecommendId()%>">삭제</a>
        </div>
    </div>
</div>
</body>
</html>