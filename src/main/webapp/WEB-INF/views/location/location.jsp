<%@page import="com.springproject.domain.Member"%>
<%@page import="com.springproject.domain.Location"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Location</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
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
         /* 기울임체 적용 */
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
    .header p span {
        font-family: "Noto Sans KR", serif; /* 폰트 적용 */
        font-size: 20px;
		color : #28596d;
		font-weight: 800;
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
        .image-box {
            width: 100%;
           	aspect-ratio: 6 / 5; /* 원하는 높이 설정 */
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            border-radius: 8px; /* 둥근 모서리 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
            margin-bottom: 15px; /* 이미지 간격 */
            background-size: cover; /* 배경 이미지를 요소에 맞게 조절 */
			background-position: center center; /* 배경 이미지의 위치를 중앙으로 설정 */
			background-repeat: no-repeat; /* 배경 이미지 반복 방지 */
        }

        .title {
            text-align: center; /* 가운데 정렬 */
            padding: 20px 0; /* 상하 패딩 추가 */
        }

        .title span {
            font-style: italic;
            font-family: 'Arial', sans-serif; /* 둥글고 부드러운 글꼴 */
            font-size: 30px; /* 제목 크기 */
            font-weight: bold; /* 제목 두께 */
            background-color: #E6F2F3; /* 불투명한 연두색 배경 */
            padding: 5px 10px; /* 패딩 추가 */
            border-radius: 5px; /* 약간 둥근 모서리 */
        }
        
    .clickBox {
		padding : 10px 30px;
		width:100%;
		display : flex;
        justify-content: center;
        max-width : 1200px;
    }
    
   .clickBox a{
    	display: inline-block;
    	width: 60px;
    	text-align:center;
    	align-content:center;
    	text-decoration: none;
    	padding : 5px 15px;

    	margin : 20px 2px;
    	border : 1px hidden;
    	border-radius: 7px;
    	background-color: #6998AB; 
    	color : white;
    }
    .clickBox a:hover {
        background-color: rgba(39, 118, 221, 0.5);
        transition: 0.5s ease;
    }
    a{
    	text-decoration: none;
    }
    
            /* 기본 스타일 */
        #customConfirm {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border: 1px solid #ccc;
            border-radius:5px;
            padding: 50px 80px 30px;
            z-index: 1000;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            align-items: center;
        }
        #overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
        .clickBoxx a{
    	display: inline-block;
    	width: 60px;
    	text-align:center;
    	align-content:center;
    	text-decoration: none;
    	padding : 5px 15px;
    	margin : 20px 10px;
    	border : 1px hidden;
    	border-radius: 7px;
    	background-color: #6998AB; 
    	color : white;
    }
    .clickBoxx a:hover {
        background-color: orange;
        transition: 0.5s ease;
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
    Location location = (Location)request.getAttribute("location");
%>
<div id="body">
	<div class="header">
		<a href="/howAbout/location"><i class="bi bi-map"></i>&nbsp;TOURIST AREA</a>
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
		<a href="/howAbout/location/locationCategory"><i class="fa-solid fa-mountain-sun"></i>&nbsp;카테고리 보기</a>
		<a href="/howAbout/location"><i class="fa-solid fa-map-location-dot"></i>&nbsp;지역 보기</a>
		<a href="/howAbout/location/locations"><i class="fa-solid fa-earth-asia"></i>&nbsp;전체 보기</a>
	</div>
<h1 class="title"><span><%= location.getData_title() %></span></h1>
<div class="container mt-5">
    <div class="row">
        <div class="col-md-6">
            <div class="row">
                <div class="col-6">
                    <div class="image-box" style="background-image: url('<%= location.getFileurl1() %>');"></div>
                </div>
                <div class="col-6">
                    <div class="image-box" style="background-image: url('<%= location.getFileurl2() %>');"></div>
                </div>
                <div class="col-6">
                    <div class="image-box" style="background-image: url('<%= location.getFileurl3() %>');"></div>
                </div>
                <div class="col-6">
                    <div class="image-box" style="background-image: url('<%= location.getFileurl4() %>');"></div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <p> 카테고리 : <%= location.getCategory_name1() %> &raquo; <a href="/howAbout/location/category/<%= location.getCategory_name1() %>">해당 카테고리 더보기</a> </p>
            <p> 지 역 : <%= location.getInsttnm().substring(0, 2) %> &raquo; <a href="/howAbout/location/area/<%= location.getInsttnm().substring(0, 2) %>">해당 지역 더보기</a></p>
            <p> 주 소 : <%= location.getUser_address() %> </p>
            <p> 문 의 : <%= location.getTelno() %> </p>
            <hr>
            
            <p> <%= location.getData_content() %> </p>
        </div>
		<div class="clickBox">
            <span>
            <%
    		if(mb!=null)
    		{
                if(mb.getUserId().equals("admin")) {
            %>
                <a href="/howAbout/location/update?num=<%=location.getNum()%>">수정</a>
                <a href="#" onclick="confirmDelete('<%=location.getNum()%>'); return false;">삭제</a>
            <%
                }
    		}
            %>
            </span>
        </div>
    </div>
</div>
<div id="overlay"></div>
<div id="customConfirm">
    <p>장소를 삭제하시겠습니까?</p>
    <div class="clickBoxx">
        <a href="#" onclick="confirmAction(true)">확인</a>
        <a href="#" onclick="confirmAction(false)">취소</a>
    </div>
</div>
<script>
    function confirmDelete(num) {
        document.getElementById('overlay').style.display = 'block';
        document.getElementById('customConfirm').style.display = 'block';

        window.confirmAction = function(confirmed) {
            if (confirmed) {
                window.location.href = "/howAbout/location/delete?num=" + num;
            }
            // 숨기기
            document.getElementById('overlay').style.display = 'none';
            document.getElementById('customConfirm').style.display = 'none';
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
</body>
</html>