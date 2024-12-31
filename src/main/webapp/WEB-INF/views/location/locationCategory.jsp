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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
    	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
		}
		
		*{
			margin : 0 auto;
			padding : 0px;
			box-sizing: border-box;
		}
		
        body {
            
            margin: 0;
            padding: 20px;
            background-image: url('/howAbout/resources/images/bac.png');
           	background-color : rgba(221, 223, 222, 0.53);
            background-position: center; /* 중앙에 위치 */
            background-repeat: no-repeat; /* 반복하지 않음 */
            background-size: cover;
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
            justify-content: space-between; /* 지그재그 배치 */
        }

        .container div {
            background-color: white;
            border: 1px solid #ddd;
            overflow: hidden;
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
            border-radius: 8px; /* 모서리 둥글게 */
            margin-bottom: 15px; /* 각 항목 간의 간격 */
            padding: 10px; /* 패딩 추가 */
            flex: 1 1 calc(30% - 15px); /* 3개씩 보이도록 설정 */
        }

        .container div:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .container a {
            text-decoration: none; /* 링크 밑줄 제거 */
            color: #333; /* 기본 글씨 색상 */
        }

        .container img {
            width: 100%; /* 이미지를 박스에 맞게 조정 */
            height: auto;
            padding: 10px; /* 이미지 패딩 추가 */
            box-sizing: border-box; /* 패딩 포함 */
        }

        .container p {
            padding: 10px;
            font-size: 18px; /* 제목 글씨 크기 조정 */
            margin: 0;
            font-family: ; /* Jua 글씨체 */
            color: #2c3e50; /* 글씨 색상 변경 */
        }
    </style>
</head>
<body>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<%
    ArrayList<Location> categoryList = (ArrayList<Location>)request.getAttribute("categoryList");
%>
    <div class="category-header">
        카테고리별 여행지
        <span>&nbsp;&nbsp;<a href="/howAbout/location/locationArea">&raquo;지역별 여행지 보기</a></span>
    </div>
    <hr>
    <div class="container">
        <%
        for(Location location : categoryList) {
        %>
            <div class="col-md-4">
                <a href="/howAbout/location/category/<%= location.getCategory_name1() %>">
                    <img alt="사진없당" src="<%= location.getFileurl1() %>" />
                    <p><%= location.getCategory_name1() %></p>
                </a>
            </div>
        <%
        }
        %>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>