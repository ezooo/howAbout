<%@page import="com.springproject.domain.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@page import="com.springproject.domain.Recommendation"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recommendation</title>
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
            font-size: 16px;
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
        th:nth-child(3), td:nth-child(3) {
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
#filterButton
{
	border : hidden;
	border-radius: 3px;
	padding : 3px 6px;
	margin : 0 10px 0 -2px;
}
</style>
</head>

<body>
<%
    ArrayList<Recommendation> recommendationList = (ArrayList<Recommendation>)request.getAttribute("recommendationList");
	HttpSession ssn = request.getSession(false);
	Member mb = null;
	if(ssn != null)
	{
		mb = (Member)ssn.getAttribute("userStatus");		
	}
%>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
    <div id="body">
        <div class="header">
            <h2><i class="fa-regular fa-clipboard"></i>&nbsp;Recommendation</h2>
            <p> 새로운 장소를 추천해주세요 ! </p>
        </div>
        <div class="boardnav">
			<%
			if(mb!=null)
			{
				if(mb.getUserId().equals("admin"))
				{
			%>		
					<select id="statusFilter">
		                <option value="">모두 보기</option>
		                <option value="미확인">미확인</option>
		                <option value="확인">확인</option>
		                <option value="처리완료">처리완료</option>
		            </select>
		            <button id="filterButton">적용</button>
			<%
				}
			}
			%>
            <a href="/howAbout/recommend/addRecommend"><i class="bi bi-pencil-square"></i>&nbsp;작성</a>
            <a href="/howAbout/recommend/my"><i class="fa-solid fa-list"></i>&nbsp;내 추천 보기</a>
        </div>

        <div class="container">
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>분류</th>
                        <th>추천 장소</th>
                        <th>등록일</th>
                        <th>처리상태</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int index = 1; // 인덱스 초기화
                        for (Recommendation rd : recommendationList) {
                    %>
                        <tr class="recommendation-row" data-status="<%= rd.getStatus() %>">
                            <td><%= index++ %></td>
                            <td><%= rd.getCategory() %></td>
                            <td><a href="recommend/recommendation/<%= rd.getRecommendId() %>"><%= rd.getRecommendTitle() %></a></td>
                            <td><%= rd.getRecommendDate() %></td>
                            <td><%= rd.getStatus() %></td> <!-- 처리 상태를 여기에 추가, 필요시 동적으로 변경 가능 -->
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
<script>
document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('filterButton').addEventListener('click', function() {
        	console.log("dlqpsxm");
            var selectedStatus = document.getElementById('statusFilter').value;
            console.log(selectedStatus);
            var rows = document.querySelectorAll('.recommendation-row');
            console.log(rows);
            rows.forEach(function(row) {
                if (selectedStatus === "" || row.getAttribute('data-status') === selectedStatus) {
                	console.log("여기는오니");
                    row.style.display = 'table-row'; // 해당 상태에 맞는 행은 보여줌
                } else {
                    row.style.display = 'none'; // 해당 상태에 맞지 않는 행은 숨김
                    console.log("그럼 여기는오니");
                }
            });
        });
});
</script>
</body>
</html>