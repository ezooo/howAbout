<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false"%>
<%@ page import="com.springproject.domain.Member" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recommendation</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
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
.col-form-label {
    max-width: 150px;
    font-size: 20px;
    margin-right: -10px;
}
</style>
</head>
<body>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<div id="body">
    <div class="form-container">
        <h2 class="text-center">여행지 추천하기</h2><br>
		<form:form modelAttribute="recommendation" method="post">
			 <div class="mb-3 row">
                <label for="recommendTitle" class="col-sm-4 col-form-label">추천 장소</label>
                <div class="col-sm-9" style="padding-left: 0;">
                    <form:input path="recommendTitle" class="form-control" id="recommendTitle" required="required" />
                </div>
            </div>
            <div class="mb-3 row">
                <label for="recommendTitle" class="col-sm-4 col-form-label">분 류</label>
                <div class="col-sm-9" style="padding-left: 0;">
                    <form:select path="category" class="form-control" id="category" required="required">
                    	<option value="" disabled selected >선택하세요</option>
                    	<form:option value="관광지" ></form:option>
                    	<form:option value="축제" ></form:option>
                    	<form:option value="시설" ></form:option>
                    </form:select>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="recommendTitle" class="col-sm-4 col-form-label">지 역</label>
                <div class="col-sm-9" style="padding-left: 0;">
                    <form:select path="area" class="form-control" id="area" required="required">
                    	<option value="" disabled selected >선택하세요</option>
                    	<option value="거제시">거제시</option>
					    <option value="거창군">거창군</option>
					    <option value="고성군">고성군</option>
					    <option value="김해시">김해시</option>
					    <option value="남해군">남해군</option>
					    <option value="밀양시">밀양시</option>
					    <option value="사천시">사천시</option>
					    <option value="산청군">산청군</option>
					    <option value="양산시">양산시</option>
					    <option value="의령군">의령군</option>
					    <option value="진주시">진주시</option>
					    <option value="창원시">창원시</option>
					    <option value="창녕군">창녕군</option>
					    <option value="통영시">통영시</option>
					    <option value="하동군">하동군</option>
					    <option value="함안군">함안군</option>
					    <option value="함양군">함양군</option>
					    <option value="합천군">합천군</option>
                    </form:select>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="recommendContent" class="col-sm-2 col-form-label">내 용</label>
                <div class="col-sm-9" style="padding-left: 0;">
                    <form:textarea path="recommendContent" class="form-control" id="recommendContent" rows="4" required="required"></form:textarea>
                </div>
            </div>
            <div class="text-center">
                <input type="submit" class="btn btn-primary" value="제출" style="background-color : #6998AB; border-style: none;"/>
            </div>
		</form:form>
	</div>
</div>
</body>
</html>