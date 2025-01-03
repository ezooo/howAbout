<%@page import="com.springproject.domain.Member"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.springproject.domain.Location"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로케이션 보여주기</title>
<script src="https://kit.fontawesome.com/643a314a64.js" crossorigin="anonymous"></script>
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
    .locationNav
    {
    	text-align: right;
    	align-content: center;
    	padding: 10px 5%;
    }
    .locationNav > a
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

        .category-header {
            font-size: 24px;
            margin-bottom: 20px;
            font-family: 'Pretendard-Regular';
            font-weight : 900;
            font-style: bold;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            position: relative;
    		overflow: hidden;
    		width: 100%;
        }

        .categoryItem {
        	width : 15%;
            background-color: white;
            margin: 5px;
		    padding: 15px;
		    border: 1px solid #ddd;
		    transition: transform 0.3s, z-index 0.3s;
		    position: relative;
		    flex: 1 1 calc(33.33% - 10px); /* 3개씩 나열 */
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .categoryItem:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            z-index: 1;
        }
        
        .container #categoryItem:nth-child(n+7) {
		    margin-top: -50px; /* 두 번째 줄이 첫 줄과 겹치도록 설정 */
		}

        .container a {
            text-decoration: none; /* 링크 밑줄 제거 */
            color: #333; /* 기본 글씨 색상 */
        }

        .categoryItem img {
            width: 100%; /* 이미지를 박스에 맞게 조정 */
            height: auto;
            object-fit: cover; /* 이미지 비율 유지하면서 잘라내기 */
        }

        .container p {
            padding: 10px;
            font-size: 18px; /* 제목 글씨 크기 조정 */
            margin: 0;
            color: #2c3e50; /* 글씨 색상 변경 */
        }
</style>
</head>
<body>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<%
	HttpSession ssn = request.getSession(false);
	Member mb = null;
	if(ssn != null)
	{
		mb = (Member)ssn.getAttribute("userStatus");		
	}
%>
<%
    ArrayList<Location> categoryList = (ArrayList<Location>)request.getAttribute("categoryList");
%>
<div id="body">
<div class="header">
	<h2><i class="bi bi-map"></i>&nbsp;TOURIST AREA</h2>
	<p> 원하는 주제의 관광지를 찾아보세요 ! </p>
</div>
<div class="locationNav">
	<%
	if(mb!=null)
	{
		if(mb.getUserId().equals("admin"))
		{
	%>		
			<a href="/howAbout/location/create"><i class="bi bi-pencil-square"></i>&nbsp;장소 추가</a>
			<a href="/howAbout/location/addapi"><i class="bi bi-arrow-up-right-square"></i>API 호출</a>
	<%
		}
	}
	%>
	<a href="/howAbout/location"><i class="fa-solid fa-map-location-dot"></i>&nbsp;지역 보기</a>
	<a href="/howAbout/location/locations"><i class="fa-solid fa-earth-asia"></i>&nbsp;전체 보기</a>
</div>
    <div class="container">
        <%
        for(Location location : categoryList) {
        %>
            <div class="categoryItem">
                <a href="/howAbout/location/category/<%= location.getCategory_name1() %>">
                    <img alt="사진없당" src="<%= location.getFileurl1() %>" />
                    <p><%= location.getCategory_name1() %></p>
                </a>
            </div>
        <%
        }
        %>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
</body>
</html>