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
<title>Location</title>
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
    .header a {
        font-family: "Noto Sans KR", serif; /* 폰트 적용 */
        font-size: 30px;
        padding-bottom: 10px;
        text-decoration: none;
    	color : black;
    	font-weight: 600;
    }
    .header p {
        font-family: "Noto Sans KR", serif; /* 폰트 적용 */
        font-size: 16px;
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
            font-weight : 900;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content : flex-start;
            position: relative;
    		width: 100%;
    		margin-top: 20px;
        }

        .categoryItem {
        	width : 24%;
        	aspect-ratio: 3 / 4;
            background-color: white;
		    padding: 1px;
		    border: 1px solid #ddd;
		    transition: transform 0.3s, z-index 0.3s;
		    position: relative;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		    z-index: 2; /* 기본 z-index 설정 */
		    margin-top: 10px;
		    display : flex;
		    flex-direction : column;
		    justify-content: center;
        }
        #hoverbar
        {
        	position: absolute;
        	bottom: -10px; /* 부모 요소 아래로 살짝 나오게 조정 */
		    left: 50%; /* 중앙 정렬을 위한 왼쪽 위치 */
		    transform: translateX(-50%); /* 중앙 정렬을 위해 이동 */
        	width: 85%;
        	height: 15px;
        	background-color: #ebebeb;
        	z-index: -1;

        }

		
        .categoryItem:hover {
           /* transform: translateY(-5px) scale(1.05) rotateY(0deg);  마우스 오버 시 회전 복구 */
           	transform: ;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            z-index: 3;
            transition: transform 0.5s ease, box-shadow 0.3s ease; /* 부드러운 전환 효과 추가 */
        }


        .container a {
            text-decoration: none; /* 링크 밑줄 제거 */
            color: #333; /* 기본 글씨 색상 */
            width : 100%;
        }
        
        .imgbox
        {
        	width : 100%;
            aspect-ratio: 5 / 6;
            display: flex; /* flexbox 사용 */
		    flex-direction: column; /* 세로 방향으로 정렬 */
		    justify-content: center; /* 세로 방향 가운데 정렬 */
		    align-items: center; /* 가로 방향 가운데 정렬 */
        }

        .categoryItem img {
            width: 100%; /* 이미지를 박스에 맞게 조정 */
            object-fit: cover; /* 이미지 비율 유지하면서 잘라내기 */
        }

        .categoryItem a p {
            padding: 1px;
            font-size: 15px; /* 제목 글씨 크기 조정 */
            margin: 0;
            text-align: center;
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
	<a href="/howAbout/location"><i class="bi bi-map"></i>&nbsp;TOURIST AREA</a>
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
			<a href="/howAbout/location/addapi"><i class="bi bi-arrow-up-right-square"></i>&nbsp;API 호출</a>
	<%
		}
	}
	%>
	<a href="/howAbout/location"><i class="fa-solid fa-map-location-dot"></i>&nbsp;지역 보기</a>
	<a href="/howAbout/location/locations"><i class="fa-solid fa-earth-asia"></i>&nbsp;전체 보기</a>
</div>
<div class="container">
    <%
       // int count = 0;  카운터 초기화
        for (Location location : categoryList) {
            // 5개마다 새로운 행을 나누기 위해 div를 닫고 새로 열지 않음
    %>
            <div class="categoryItem">
                <a href="/howAbout/location/category/<%= location.getCategory_name1() %>">
                	<div class="imgbox"><img alt="사진없당" src="<%= location.getFileurl1() %>" /></div>
                    <p><%= location.getCategory_name1() %></p>
                </a>
                <div id="hoverbar"></div>
            </div>
    <%
           // count++;  카운터 증가
        }
    %>
</div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
</body>
</html>