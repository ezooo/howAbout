<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>다이어리 작성 폼</title>
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
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<div id="body">

    <div class="form-container">
        <h2 class="text-center">다이어리 작성하기</h2><br>
        <form action="/howAbout/diaries/addDiary" method="post" enctype="multipart/form-data">
            <div class="mb-3 row">
                <label for="visit_date" class="col-sm-4 col-form-label">방 문 일</label>
                <div class="col-sm-8" style="padding-left: 0;">
                    <input type="date" class="form-control" name="visit_date" required />
                </div>
            </div>
            <div class="mb-3 row">
                <label for="visit_location" class="col-sm-4 col-form-label">방문 장소</label>
                <div class="col-sm-8" style="padding-left: 0;">
<<<<<<< HEAD
                    <input type="text" class="form-control" name="visit_location" id="visit_location" required />
=======
                    <input type="text" class="form-control" name="visit_location" id="visit_location" required placeholder="원하는 장소가 검색되지 않으면 직접 입력해주세요."/>
>>>>>>> f8c883457ef258d8fb686399b6980baf78f98eb1
                    <button id="find" onclick="findLocation()" type="button" class="btn btn-secondary mt-2">장소검색</button>
                </div>
            </div>
            <div id="locationResults" style="display: none;"></div>
            <div class="mb-3 row">
                <label for="address" class="col-sm-4 col-form-label">주   소</label>
                <div class="col-sm-8" style="padding-left: 0;">
<<<<<<< HEAD
                    <input type="text" class="form-control" name="address" id="address" />
=======
                    <input type="text" class="form-control" name="address" id="address" required/>
>>>>>>> f8c883457ef258d8fb686399b6980baf78f98eb1
                </div>
            </div>
            <div class="mb-3 row">
                <label for="visit_diary" class="col-sm-4 col-form-label">메   모</label>
                <div class="col-sm-8" style="padding-left: 0;">
<<<<<<< HEAD
                    <input type="text" class="form-control" name="visit_diary" />
=======
                    <input type="text" class="form-control" name="visit_diary" style="height: 200px; padding-top: 0px; line-height: 1;"/>
>>>>>>> f8c883457ef258d8fb686399b6980baf78f98eb1
                </div>
            </div>
            <div class="mb-3">
                <p>내 여행 사진을 업로드 하세요. (최대 4장)</p>
                <input type="file" class="form-control mb-2" name="uploadFile" />
                <input type="file" class="form-control mb-2" name="uploadFile" />
                <input type="file" class="form-control mb-2" name="uploadFile" />
                <input type="file" class="form-control mb-2" name="uploadFile" />
            </div>
            <div class="mb-3 row">
                <label for="isopen" class="col-sm-4 col-form-label">공개 여부</label>
                <div class="col-sm-8">
                    <select name="isopen" class="form-select" required>
                        <option value="true">공개</option>
                        <option value="false">비공개</option>
                    </select>
                </div>
            </div>
            <div class="text-center">
                <input type="submit" class="btn btn-primary" value="제출" />
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</div>
</body>

<script src="/howAbout/resources/js/locationAjax.js"></script>

</html>