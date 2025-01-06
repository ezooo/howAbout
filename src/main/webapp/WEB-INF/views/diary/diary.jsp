<%@page import="com.springproject.domain.Member"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.springproject.domain.Diary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다이어리 확인하기</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
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
        width: 100%;
    }
    .container {
    	margin: 0 auto; /* 중앙 정렬 */
        display: flex;
        justify-content: center;	 /* 중앙 정렬 */

    }
    .clickBox {
		padding : 10px 30px;
		width:100%;
        justify-content: flex-start;	 /* 중앙 정렬 */
        max-width : 1200px;
    }
    .clickBox span{
    	display: inline-block;
    	width: 70px;
    	text-align:center;
    	align-content:center;
    	text-decoration: none;
    	padding : 5px;
    	margin : 2px 20px 2px -30px;
    	border : 1px hidden;
    	border-radius: 7px;
    	background-color: rgba(247, 166, 89, 0.9); 
    	color : white;
    }
	.clickBox div{
    	display: inline-block;
    	text-align:center;
    	align-content:center;
    	text-decoration: none;
    	font-size: 16px;
    	padding : 5px 10px;
    	margin : 2px -40px 0;
    	border : 1px hidden;

    	background-color: #6998ab; 
    	color : white;
    }
    .clickBox a{
    	display: inline-block;
    	width: 70px;
    	text-align:center;
    	align-content:center;
    	text-decoration: none;
    	padding : 5px 15px;
    	margin : 2px;
    	border : 1px hidden;
    	border-radius: 7px;
    	background-color: #6998AB; 
    	color : white;
    }
.clickBox .delete
{	
	background-color:#D9534F;
}
    .clickBox a:hover {
        background-color: rgba(39, 118, 221, 0.5);
        transition: 0.5s ease;
    }
    
    .info {
        flex: 0 0 40%; /* 텍스트 영역 40% */
        margin: 10px;
        border : 1px hidden;
        box-shadow: 0 1px 5px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
        padding : 30px;
    }
    .album {
        flex: 0 0 60%; /* 앨범 영역 60% */
        display: flex;
        flex-direction: column; /* 세로 방향으로 정렬 */
        align-items: center; /* 가운데 정렬 */
        margin: 10px;
    }
    .main-image {
        width: 100%; /* 대표 이미지 영역 */
        height: auto; /* 자동 높이 */
        margin-bottom: 20px; /* 아래 여백 */
		border : 1px hidden;
        box-shadow: 0 5px 12px rgba(0, 0, 0, 0.5);
    }
    .thumbnails {
        display: grid;
        grid-template-columns: repeat(4, 1fr); /* 4개의 열로 구성 */
        gap: 10px;
        width: 100%; /* 전체 너비 */
        
    }
    .thumbnail {
	    width: 100%; /* 부모의 너비를 100%로 설정 */
	    padding-top: 100%; /* 높이를 너비와 동일하게 만들기 위해 패딩 사용 */
	    position: relative; /* 자식 요소에 대한 상대적 위치 설정 */
	    overflow: hidden; /* 내용이 영역을 벗어나지 않도록 설정 */
	    cursor: pointer; /* 클릭 가능 커서 */
	    border-radius: 5px;
	}
	.thumbnail img {
	    position: absolute; /* 절대 위치 지정 */
	    top: 0; /* 상단 정렬 */
	    left: 0; /* 좌측 정렬 */
	    width: 100%; /* 부모 div의 너비에 맞춤 */
	    height: 100%; /* 부모 div의 높이에 맞춤 */
	    object-fit: cover; /* 이미지 비율 유지하며 크기 맞춤 */
	    transition: transform 1s; /* 부드러운 변환 효과 */
	}
    .thumbnail img:hover {
        transform: scale(1.5); /* 마우스 오버 시 확대 */
    }
            .header{
        	text-align: center;
        }
	    .header h2 {
	        font-family: "Noto Sans KR", serif; /* 폰트 적용 */
	         /* 기울임체 적용 */
	        font-size: 20px;
	        padding-bottom: 10px;
	    }
	    .diaryNav
	    {
	    	text-align: right;
	    	align-content: center;
	    	padding: 10px 5%;
	    	width: 90%;
	    }
	    .diaryNav > a
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
    	width: 70px;
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
    Diary diary = (Diary)request.getAttribute("diary");
    HttpSession ssn = request.getSession(false);
    String[] filenames = {diary.getFilename0(), diary.getFilename1(), diary.getFilename2(), diary.getFilename3()};
    String mainImage = filenames[0]; // 기본적으로 첫 번째 이미지를 대표 이미지로 설정
%>
<div id="body">
<div class="header">
	<h2><i class="bi bi-tree"></i>&nbsp;
		<span style="font-size: 30px;"><%= diary.getVisit_location() %></span>&nbsp;&nbsp;방문 기록&nbsp;<i class="bi bi-tree-fill"></i>
	</h2>
</div>
<div class="diaryNav">
	<a href="/howAbout/diaries/my"><i class="bi bi-book"></i>&nbsp;내 다이어리</a>
	<a href="/howAbout/diaries"><i class="bi bi-book"></i>&nbsp;다이어리 홈으로</a>
</div>
<div class="container">
    <div class="info">
        <p style="font-size: 20px;"><i class="bi bi-calendar-week" style="font-size: 30px;"></i>&nbsp;&nbsp;<%= diary.getVisit_date() %></p>
        <p style="font-size: 20px;"><%= diary.getAddress() %></p>

        <hr>
        <% String content = diary.getVisit_diary().replace("\n", "<br>"); %>
        <p><%= content %></p>
    </div>

    <div class="album">
        <img src="/howAbout/resources/images/<%=mainImage%>" alt="대표 이미지" class="main-image" id="mainImage"/>
        
        <div class="thumbnails">
            <%
            for(int i = 0; i < filenames.length; i++) {
                if(filenames[i] != null) {
            %>
                <div class="thumbnail" onclick="changeImage('<%=filenames[i]%>')">
                    <img src="/howAbout/resources/images/<%=filenames[i]%>" alt="썸네일 <%=i+1%>"/>
                </div>
            <%
                }
            }
            %>
        </div>
    </div>
</div>
<div class="clickBox">
	<%
	if(ssn != null) {
	    Member mb = (Member)ssn.getAttribute("userStatus");
	    if(mb != null && mb.getUserId().equals(diary.getUserId())) {
	%>
	    <p>
	        <span>
            <% if(diary.getIsopen().equals("true")) { %> 공개글 <% } else { %> 비밀글 <% } %>
        	</span>
	        <a href="/howAbout/diaries/updateDiary?id=<%=diary.getDiaryId()%>">수정</a>
	        <a href="#" onclick="confirmDelete('<%=diary.getDiaryId()%>'); return false;" class="delete">삭제</a>
	    </p>
	<%
	    }
	    else
	    {
	%>	
		<div><%= diary.getUserId() %> &nbsp;님이 작성했어요 ! </div>
	<%
	    }
	}
    else
    {
	%>	
	<div><%= diary.getUserId() %> &nbsp;님이 작성했어요 !</div>
	<%
    }
	%>
</div>
</div>
<div id="overlay"></div>
<div id="customConfirm">
    <p>다이어리를 삭제하시겠습니까?</p>
    <div class="clickBoxx">
        <a href="#" onclick="confirmAction(true)">확인</a>
        <a href="#" onclick="confirmAction(false)">취소</a>
    </div>
</div>
<script>
    function changeImage(filename) {
        document.getElementById('mainImage').src = '/howAbout/resources/images/' + filename;
    }

    function confirmDelete(diaryId) {
        document.getElementById('overlay').style.display = 'block';
        document.getElementById('customConfirm').style.display = 'block';

        window.confirmAction = function(confirmed) {
            if (confirmed) {
                window.location.href = "/howAbout/diaries/deleteDiary?id=" + diaryId;
            }
            // 숨기기
            document.getElementById('overlay').style.display = 'none';
            document.getElementById('customConfirm').style.display = 'none';
        }
    }

</script>
</body>
</html>