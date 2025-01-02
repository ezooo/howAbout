<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>장소 추가하기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
            background: rgba(255, 255, 255, 0.5);
            border: 1px  #ccc;
            border-radius: 2px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .large-input {
            height: 150px; /* 높이를 3배로 설정 */
        }
        .text-center{
        	font-family: 'Pretendard-Regular';
            font-weight : 900;

        }
    </style>
</head>
<body>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
    <div class="form-container">
        <h2 class="text-center">장소 추가하기</h2><br>
        <form method="post">
            <div class="mb-3 row">
                <label for="data_title" class="col-sm-3 col-form-label">장소명</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="data_title" name="data_title" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="user_address" class="col-sm-3 col-form-label">주소</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="user_address" name="user_address" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="latitude" class="col-sm-3 col-form-label">위도</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="latitude" name="latitude">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="longitude" class="col-sm-3 col-form-label">경도</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="longitude" name="longitude">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="insttnm" class="col-sm-3 col-form-label">담당기관</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="insttnm" name="insttnm" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="category_name1" class="col-sm-3 col-form-label">카테고리 구분 (ex.바다)</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="category_name1" name="category_name1" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="category_name2" class="col-sm-3 col-form-label">시군명</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="category_name2" name="category_name2">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="data_content" class="col-sm-3 col-form-label">내용</label>
                <div class="col-sm-9">
                    <textarea class="form-control large-input" id="data_content" name="data_content"></textarea>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="telno" class="col-sm-3 col-form-label">대표연락처</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="telno" name="telno">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="fileurl1" class="col-sm-3 col-form-label">이미지 주소 1</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="fileurl1" name="fileurl1">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="fileurl2" class="col-sm-3 col-form-label">이미지 주소 2</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="fileurl2" name="fileurl2">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="fileurl3" class="col-sm-3 col-form-label">이미지 주소 3</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="fileurl3" name="fileurl3">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="fileurl4" class="col-sm-3 col-form-label">이미지 주소 4</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="fileurl4" name="fileurl4">
                </div>
            </div>
            <div class="text-center">
                <input type="submit" class="btn btn-primary" value="저장">
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>