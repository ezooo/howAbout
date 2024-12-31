<%@page import="com.springproject.domain.Member"%>
<%@page import="com.springproject.domain.Location"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>로케이션</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .image-box {
            width: 100%;
            height: 200px; /* 원하는 높이 설정 */
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            border-radius: 8px; /* 둥근 모서리 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
            margin-bottom: 15px; /* 이미지 간격 */
        }

        .image-box img {
            max-width: 100%; /* 이미지가 박스를 넘지 않게 함 */
            max-height: 100%; /* 이미지가 박스를 넘지 않게 함 */
            object-fit: cover; /* 이미지 중앙에 위치 */
        }
        .title {
        	font-style: italic;
            font-size: 2rem; /* 제목 크기 */
            font-weight: bold; /* 제목 두께 */
            text-align: center; /* 가운데 정렬 */
            padding: 20px 0; /* 상하 패딩 추가 */
        }

        .title span {
             /* 기울임체 */
            font-family: 'Arial', sans-serif; /* 둥글고 부드러운 글꼴 */
            font-size: 3rem; /* 제목 크기 */
            background-color: rgba(144, 238, 144, 0.5); /* 불투명한 연두색 배경 */
            padding: 5px 10px; /* 패딩 추가 */
            border-radius: 5px; /* 약간 둥근 모서리 */
        }
    </style>
</head>
<body>
<%@ include file="main.jsp" %>
<%
    Location location = (Location)request.getAttribute("location");
    HttpSession ssn = request.getSession(false);
%>
<h1 class="title"><span><%= location.getData_title() %></span> 어때?</h1>
<div class="container mt-5">
    <div class="row">
        <div class="col-md-6">
            <div class="row">
                <div class="col-6">
                    <div class="image-box">
                        <img alt="image" src="<%= location.getFileurl1() %>" />
                    </div>
                </div>
                <div class="col-6">
                    <div class="image-box">
                        <img alt="image" src="<%= location.getFileurl2() %>" />
                    </div>
                </div>
                <div class="col-6">
                    <div class="image-box">
                        <img alt="image" src="<%= location.getFileurl3() %>" />
                    </div>
                </div>
                <div class="col-6">
                    <div class="image-box">
                        <img alt="image" src="<%= location.getFileurl4() %>" />
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <p> 카테고리 : <%= location.getCategory_name1() %> &raquo; <a href="/howAbout/location/category/<%= location.getCategory_name1() %>">해당 카테고리 더보기</a> </p>
            <p> 지 역 : <%= location.getInsttnm().substring(0, 2) %> &raquo; <a href="/howAbout/location/area/<%= location.getInsttnm().substring(0, 2) %>">해당 지역 더보기</a></p>
            <hr>
            <p> 주 소 : <%= location.getUser_address() %> </p>
            <p> 문 의 : <%= location.getTelno() %> </p>
            <p> <%= location.getData_content() %> </p>

            <p>
            <%
            if(ssn != null) {
                Member mb = (Member)ssn.getAttribute("member");
                if(mb != null) {
                    if(mb.getUserId().equals("admin")) {
            %>
                <a href="/howAbout/location/update?num=<%=location.getNum()%>">수정</a> |
                <a href="/howAbout/location/delete?num=<%=location.getNum()%>">삭제</a>
            <%
                    }
                }
            }
            %>
            </p>
            <p> <a href="/howAbout/location">location 홈으로</a> </p>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>