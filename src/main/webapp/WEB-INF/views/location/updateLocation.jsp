<%@page import="com.springproject.domain.Location"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Location</title>
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
	font-family: "Noto Sans KR", serif;
}
body{
	width : 100%;
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
	Location lt = (Location)request.getAttribute("location");
%>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<div id="body">
    <div class="form-container">
        <h2 class="text-center">장소 수정하기</h2><br>
        <form modelAttribute="location" method="post">
            <input type="hidden" name="num" value="<%= lt.getNum() %>"/>
            <div class="mb-3 row">
                <label for="data_title" class="col-sm-4 col-form-label">장소명</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="data_title" name="data_title" value="<%= lt.getData_title() %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="user_address" class="col-sm-4 col-form-label">주소</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="user_address" name="user_address" value="<%= lt.getUser_address() %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="latitude" class="col-sm-4 col-form-label">위도</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="latitude" name="latitude" value="<%= lt.getLatitude() %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="longitude" class="col-sm-4 col-form-label">경도</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="longitude" name="longitude" value="<%= lt.getLongitude() %>">
                </div>
            </div>
			<div class="mb-3 row">
			    <label for="insttnm" class="col-sm-4 col-form-label">소속</label>
			    <div class="col-sm-8">
			        <select class="form-control" id="insttnm" name="insttnm" required>
			            <option value="" disabled>선택하세요</option>
			            <option value="거제시" <%= lt.getInsttnm().equals("거제시") ? "selected" : "" %>>거제시</option>
			            <option value="거창군" <%= lt.getInsttnm().equals("거창군") ? "selected" : "" %>>거창군</option>
			            <option value="고성군" <%= lt.getInsttnm().equals("고성군") ? "selected" : "" %>>고성군</option>
			            <option value="김해시" <%= lt.getInsttnm().equals("김해시") ? "selected" : "" %>>김해시</option>
			            <option value="남해군" <%= lt.getInsttnm().equals("남해군") ? "selected" : "" %>>남해군</option>
			            <option value="밀양시" <%= lt.getInsttnm().equals("밀양시") ? "selected" : "" %>>밀양시</option>
			            <option value="사천시" <%= lt.getInsttnm().equals("사천시") ? "selected" : "" %>>사천시</option>
			            <option value="산청군" <%= lt.getInsttnm().equals("산청군") ? "selected" : "" %>>산청군</option>
			            <option value="양산시" <%= lt.getInsttnm().equals("양산시") ? "selected" : "" %>>양산시</option>
			            <option value="의령군" <%= lt.getInsttnm().equals("의령군") ? "selected" : "" %>>의령군</option>
			            <option value="진주시" <%= lt.getInsttnm().equals("진주시") ? "selected" : "" %>>진주시</option>
			            <option value="창원시" <%= lt.getInsttnm().equals("창원시") ? "selected" : "" %>>창원시</option>
			            <option value="창녕군" <%= lt.getInsttnm().equals("창녕군") ? "selected" : "" %>>창녕군</option>
			            <option value="통영시" <%= lt.getInsttnm().equals("통영시") ? "selected" : "" %>>통영시</option>
			            <option value="하동군" <%= lt.getInsttnm().equals("하동군") ? "selected" : "" %>>하동군</option>
			            <option value="함안군" <%= lt.getInsttnm().equals("함안군") ? "selected" : "" %>>함안군</option>
			            <option value="함양군" <%= lt.getInsttnm().equals("함양군") ? "selected" : "" %>>함양군</option>
			            <option value="합천군" <%= lt.getInsttnm().equals("합천군") ? "selected" : "" %>>합천군</option>
			        </select>
			    </div>
			</div>
            <div class="mb-3 row">
                <label for="category_name1" class="col-sm-4 col-form-label">카테고리</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="category_name1" name="category_name1" value="<%= lt.getCategory_name1() %>" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="category_name2" class="col-sm-4 col-form-label">시군명</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="category_name2" name="category_name2" value="<%= lt.getCategory_name2() %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="data_content" class="col-sm-4 col-form-label">내용</label>
                <div class="col-sm-8">
                    <textarea class="form-control large-input" id="data_content" name="data_content"><%= lt.getData_content() %></textarea>
                </div>
            </div>
            <div class="mb-3 row">
                <label for="telno" class="col-sm-4 col-form-label">대표 연락처</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="telno" name="telno" value="<%= lt.getTelno() %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="fileurl1" class="col-sm-4 col-form-label">이미지 주소 1</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="fileurl1" name="fileurl1" value="<%= lt.getFileurl1() %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="fileurl2" class="col-sm-4 col-form-label">이미지 주소 2</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="fileurl2" name="fileurl2" value="<%= lt.getFileurl2() %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="fileurl3" class="col-sm-4 col-form-label">이미지 주소 3</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="fileurl3" name="fileurl3" value="<%= lt.getFileurl3() %>">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="fileurl4" class="col-sm-4 col-form-label">이미지 주소 4</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="fileurl4" name="fileurl4" value="<%= lt.getFileurl4() %>">
                </div>
            </div>
            <div class="text-center">
                <input type="submit" class="btn btn-primary" value="제출" style="background-color : #6998AB; border : hidden;" />
            </div>
        </form>
    </div>
</div>
</body>
</html>