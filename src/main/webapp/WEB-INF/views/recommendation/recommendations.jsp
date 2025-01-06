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
<script src="https://kit.fontawesome.com/643a314a64.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
    max-width: 90%; /* 최대 너비 설정 */
    margin: 0 auto; /* 중앙 정렬 */
}
        .header {
            text-align: center;
        }
        .header h2 {
            font-size: 30px;
            margin-bottom: 10px;
        }
        .header p {
            font-size: 14px;
        }
        .boardnav {
            text-align: right;
            align-content: center;
	    	padding: 10px 5%;
        }
        .boardnav > a {
            padding: 5px 10px;
            text-decoration: none;
            color: black;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #dee2e6; /* 테두리 색상 */
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #e9ecef; /* 헤더 배경색 */
            font-weight: bold;
        }
        /* 제목 열의 너비를 조정 */
        th:nth-child(2), td:nth-child(2) {
            width: 50%; /* 제목 열을 50%로 설정 */
        }
        tr:hover {
            background-color: #f1f1f1; /* 마우스 오버 효과 */
        }
        tbody a
        {
        	text-decoration: none;
        	padding : 10px 50px;
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
            <h2><i class="fa-regular fa-clipboard"></i>&nbsp;Recommendation</h2>
            <p> 새로운 여행지를 추천해주세요 ! </p>
        </div>
        <div class="boardnav">
            <a href="/howAbout/recommend/addRecommend"><i class="bi bi-pencil-square"></i>&nbsp;작성</a>
        </div>

        <div class="container">
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>등록일</th>
                        <th>처리상태</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int index = 1; // 인덱스 초기화
                        for (Recommendation rd : recommendationList) {
                    %>
                        <tr>
                            <td><%= index++ %></td>
                            <td><a href="recommend/recommendation/<%= rd.getRecommendId() %>"><%= rd.getRecommendTitle() %></a></td>
                            <td><%= rd.getRecommendDate() %></td>
                            <td>대기중</td> <!-- 처리 상태를 여기에 추가, 필요시 동적으로 변경 가능 -->
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>