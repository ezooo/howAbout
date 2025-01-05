<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@page import="com.springproject.domain.Recommendation"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HowAbout_Board</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
	    .header i
	    {
	    	font-size: 30px;
	    	font-weight: 400;
	    }
.recommend-title {
    flex: 0 0 60%;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    font-size: 20px; /* 글씨 크기 조정 */
    text-align: center; /* 가운데 정렬 */
}

.recommend-date,
.recommend-id {
    flex: 0 0 15%;
    text-align: center;
}

.list-group-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
}
</style>
</head>

<body>
<%
	ArrayList<Recommendation> recommendationList = (ArrayList<Recommendation>)request.getAttribute("recommendationList");
%>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<div id="body">
<div class="header">
	<h2><i class="bi bi-book"></i>&nbsp;Board</h2>
	<p> 새로운 여행지를 추천해주세요 ! </p>
</div>
<div class="boardnav">
	<a href="/howAbout/recommend/addRecommend"><i class="bi bi-pencil-square"></i>&nbsp;작성</a>
</div>

<div class="container">
    <div class="list-group">
        <%
        	int index = 1; // 인덱스 초기화
            for (Recommendation rd : recommendationList) {
        %>
        <a href="recommend/recommendation/<%= rd.getRecommendId() %>" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
			<span class="recommend-index" style="flex: 0 0 5%; text-align: center;">
                <%= index++ %>
            </span>
            <span class="recommend-id">
                추천 ID: <%= rd.getRecommendId() %>
            </span>
            <span class="recommend-title text-center">
                <%= rd.getRecommendTitle() %>
            </span>
            <span class="recommend-date">
                <%= rd.getRecommendDate() %>
            </span>
        </a>
        <%
            }
        %>
    </div>
</div>
</div>
</body>
</html>