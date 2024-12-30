<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>다이어리 작성 폼</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @font-face {
            font-family: 'Pretendard-Regular';
            src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
            font-weight: 400;
            font-style: normal;
        }

        body {
            margin: 0;
            padding: 30px 0;
            background-color: #f8f8f8;
            font-family: 'Pretendard-Regular';
            background-image: url('/howAbout/resources/images/back2.png');
            background-position: center; /* 중앙에 위치 */
            background-repeat: no-repeat; /* 반복하지 않음 */
            background-size: cover;
        }

        .form-container {
            max-width: 60%;
            margin: 0 auto;
            padding: 30px;
            background: rgba(255, 255, 255, 0.4);
            border: 1px #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
        }

        .text-center {
            font-family: 'Pretendard-Regular';
            font-weight: 900;
        }
    </style>
</head>
<body>
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
                    <input type="text" class="form-control" name="visit_location" id="visit_location" required />
                    <button id="find" onclick="findLocation()" type="button" class="btn btn-secondary mt-2">장소검색</button>
                </div>
            </div>
            <div id="locationResults" style="display: none;"></div>
            <div class="mb-3 row">
                <label for="address" class="col-sm-4 col-form-label">주   소</label>
                <div class="col-sm-8" style="padding-left: 0;">
                    <input type="text" class="form-control" name="address" id="address" />
                </div>
            </div>
            <div class="mb-3 row">
                <label for="visit_diary" class="col-sm-4 col-form-label">메   모</label>
                <div class="col-sm-8" style="padding-left: 0;">
                    <input type="text" class="form-control" name="visit_diary" />
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
</body>

<script src="/howAbout/resources/js/locationAjax.js"></script>

</html>