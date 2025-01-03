<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false"%>
<%@ page import="com.springproject.domain.Diary" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다이어리 수정하기</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
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
		font-family: "Noto Sans KR", serif;
	}
#body {
    margin: 0;
    padding: 30px 0;
    background-color: #f8f8f8;
}
.form-container {
    max-width: 60%;
    margin: 0 auto;
    padding: 30px;
    background: rgba(255, 255, 255, 0.4);
    border: 1px #ccc;
    border-radius: 5px;
}
        .text-center {
            font-weight: 600;
        }
    </style>
</head>
<body>
<%
	Diary diary = (Diary)request.getAttribute("diaryById");
%>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<<<<<<< HEAD
<br>
<p>다이어리 수정 폼 입니다.</p>
<form action="/howAbout/diaries/updateDiary" method="post" enctype="multipart/form-data">
	<input name="diaryId" value="<%=diary.getDiaryId() %>" type="hidden" />
	<p>방 문 일 : <input type="date" name="visit_date" value="<%=diary.getVisit_date() %>" required /> </p>
	<p>방문 장소 : <input type="text" name="visit_location" id="visit_location" value="<%=diary.getVisit_location() %>" required /> 
					<button id="find" onclick="findLocation()" type="button">장소검색</button> </p>
	<div id="locationResults" style="display: none;"></div>
	<p>주   소 : <input type="text" name="address" id="address" value="<%=diary.getAddress() %>"/> </p>
	<p>메   모 : <input type="text" name="visit_diary" value="<%=diary.getVisit_diary() %>"/> </p>

	<p> 사진 수정을 원하시면 새 파일을 업로드 하세요. </p>
	<p> <input type="file" name="uploadFile"/> </p>
	<p> <input type="file" name="uploadFile"/> </p>
	<p> <input type="file" name="uploadFile"/> </p>
	<p> <input type="file" name="uploadFile"/> </p>
	
	<select name="isopen" required>
		<% String status = diary.getIsopen(); %>
		<option value="true" <% if(status != null){if(status.equals("true")){out.print("selected");}} %> >공개</option>
		<option value="false" <% if(status != null){if(status.equals("false")){out.print("selected");}} %> >비공개</option>	
	</select>
	<p><input type="submit" value="제출"> </p>
</form>
=======
<div id="body">
<div class="form-container">
	<h2 class="text-center">다이어리 수정하기</h2><br>
    <form action="/howAbout/diaries/updateDiary" method="post" enctype="multipart/form-data">
        <input name="diaryId" value="<%=diary.getDiaryId() %>" type="hidden" />
        <div class="mb-3 row">
            <label for="visit_date" class="col-sm-4 col-form-label">방 문 일</label>
            <div class="col-sm-8" style="padding-left: 0;">
                <input type="date" class="form-control" name="visit_date" value="<%=diary.getVisit_date() %>" required />
            </div>
        </div>
        <div class="mb-3 row">
            <label for="visit_location" class="col-sm-4 col-form-label">방문 장소</label>
            <div class="col-sm-8" style="padding-left: 0;">
                <input type="text" class="form-control" name="visit_location" id="visit_location" value="<%=diary.getVisit_location() %>" required />
                <button id="find" onclick="findLocation()" type="button" class="btn btn-secondary mt-2">장소검색</button>
            </div>
        </div>
        <div id="locationResults" style="display: none;"></div>
        <div class="mb-3 row">
            <label for="address" class="col-sm-4 col-form-label">주   소</label>
            <div class="col-sm-8" style="padding-left: 0;">
                <input type="text" class="form-control" name="address" id="address" value="<%=diary.getAddress() %>" required />
            </div>
        </div>
        <div class="mb-3 row">
            <label for="visit_diary" class="col-sm-4 col-form-label">메   모</label>
            <div class="col-sm-8" style="padding-left: 0;">
                <textarea class="form-control" name="visit_diary" rows="5" required><%=diary.getVisit_diary() %></textarea>
            </div>
        </div>
        <p>사진 수정을 원하시면 새 파일을 업로드 하세요.</p>
        <div class="mb-3">
            <input type="file" class="form-control mb-2" name="uploadFile" />
            <input type="file" class="form-control mb-2" name="uploadFile" />
            <input type="file" class="form-control mb-2" name="uploadFile" />
            <input type="file" class="form-control mb-2" name="uploadFile" />
        </div>
        <div class="mb-3 row">
            <label for="isopen" class="col-sm-4 col-form-label">공개 여부</label>
            <div class="col-sm-8">
                <select name="isopen" class="form-select" required>
                    <%
                        String status = diary.getIsopen();
                    %>
                    <option value="true" <% if(status != null && status.equals("true")) { out.print("selected"); } %> >공개</option>
                    <option value="false" <% if(status != null && status.equals("false")) { out.print("selected"); } %> >비공개</option>	
                </select>
            </div>
        </div>
        <div class="text-center">
            <input type="submit" class="btn btn-primary" value="제출" />
        </div>
    </form>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
>>>>>>> f8c883457ef258d8fb686399b6980baf78f98eb1
</body>

<script src="/howAbout/resources/js/locationAjax.js"></script>

</html>
