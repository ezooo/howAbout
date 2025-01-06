<%@page import="com.springproject.domain.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@page import="com.springproject.domain.Recommendation"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recommendation</title>
<script src="https://kit.fontawesome.com/643a314a64.js" crossorigin="anonymous"></script>
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
.header h2 {
    font-size: 30px;
    margin-bottom: 10px;
}
.header p {
    font-size: 16px;
}
.header p span{
    font-size: 24px;
    color : #1A374D;
    font-weight: 600;
}
.recommend-title {
    font-weight: bold; /* 제목 두께 */
}
.recommend-content {
    line-height: 1.5; /* 추천 내용 줄 간격 조정 */
    display: flex;
	padding : 10px 20px;
    width:100%;
	border : hidden;
}
.spantitle
{
	width: 20%;
	background-color : #f8f8f8;
	display: inline-block;
	text-align: center;
	border : hidden;
	padding : 10px 20px;
	align-content: center;
}
.spancontent
{
	display: inline-block;
	width: 80%;
	border : solid 3px #f8f8f8;
	padding : 10px 20px;
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
    margin: 20px 2px;
    border: 1 hidden;
    border-radius: 7px;
    background-color: #6998AB; 
    color: white;
}
.clickBox .delete
{	
	background-color:#D9534F;
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
#updateStatusButton
{
	border : hidden;
	border-radius: 3px;
	padding : 10px 20px;
	margin : 0 10px 0 -2px;
	background-color:#b2cad4;
	
}
#statusFilter
{
	padding : 8px 15px;
}
</style>
</head>

<body>
<%
	Recommendation recommendation = (Recommendation)request.getAttribute("recommendation");	
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
		<p> <span><%= recommendation.getCategory() %></span> &nbsp;추천 </p>
	</div>
    <div class="boardnav">
		<a href="/howAbout/recommend/addRecommend"><i class="bi bi-pencil-square"></i>&nbsp;작성</a>
		<a href="/howAbout/recommend"><i class="fa-solid fa-list"></i>&nbsp;전체보기</a>
	</div>
    <div class="container mt-5">
        <div class="recommend-content"><span class="spantitle">추천 장소</span><span class="spancontent"><%= recommendation.getRecommendTitle() %></span></div>
        <div class="recommend-content"><span class="spantitle">작성자</span><span class="spancontent"><%= recommendation.getUserId() %></span></div>
        <div class="recommend-content"><span class="spantitle">작성일</span><span class="spancontent"><%= recommendation.getRecommendDate() %></span></div>
        <% String content = recommendation.getRecommendContent().replace("\n", "<br>"); %>
        <div class="recommend-content"><span class="spantitle">추천 내용 </span><div class="spancontent"><%= content %></div></div>
        <div class="clickBox">
        	<%
			    if(mb != null && mb.getUserId().equals(recommendation.getUserId())) {
			%>
            <a href="/howAbout/recommend/update/<%=recommendation.getRecommendId()%>">수정</a> 
            <a href="/howAbout/recommend/delete/<%=recommendation.getRecommendId()%>" class="delete">삭제</a>
            <%
			    }
            %>
        </div>
        <%
		if(mb!=null && mb.getUserId().equals("admin"))
		{
		%>		
        <div>
        	<span class="spantitle">처리상태</span>
				<select id="statusFilter">
					<option value="미확인">미확인</option>
					<option value="확인">확인</option>
					<option value="처리완료">처리완료</option>
				</select>
				<button id="updateStatusButton">상태 전송</button>
        </div>
		<%
		}
		%>
    </div>
</div>
<script>
    document.getElementById('updateStatusButton').addEventListener('click', function() {
        var selectedStatus = document.getElementById('statusFilter').value;
        var recommendId = "<%= recommendation.getRecommendId() %>"; // 현재 추천 ID

        // AJAX 요청
        fetch('/howAbout/recommend/setStatus', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                recommendId: recommendId,
                status: selectedStatus
            })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            console.log('성공:', data);
            alert('상태가 업데이트 되었습니다.');
        })
        .catch(error => {
            console.error('실패:', error);
            alert('상태 업데이트에 실패했습니다.');
        });
    });
</script>
</body>
</html>