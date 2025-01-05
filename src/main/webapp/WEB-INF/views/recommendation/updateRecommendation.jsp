<%@page import="com.springproject.domain.Recommendation"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false"%>
<%@ page import="com.springproject.domain.Member" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
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
</style>
</head>
<body>
<%
	Recommendation recommendation = (Recommendation)request.getAttribute("recommendation");
%>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<div id="body">
    <div class="form-container">
        <h2 class="text-center">추천글 수정하기</h2><br>
		<form:form modelAttribute="recommendation" method="post">
			 <div class="mb-3 row">
                <label for="recommendTitle" class="col-sm-4 col-form-label">제 목</label>
                <div class="col-sm-8" style="padding-left: 0;">
                    <form:input path="recommendTitle" class="form-control" id="recommendTitle"  value="<%= recommendation.getRecommendTitle() %>" required="required" />
                </div>
            </div>
            
            <div class="mb-3 row">
                <label for="recommendContent" class="col-sm-4 col-form-label">내 용</label>
                <div class="col-sm-8" style="padding-left: 0;">
                    <form:textarea path="recommendContent" class="form-control" id="recommendContent" rows="4"  value="<%= recommendation.getRecommendContent() %>" required="required"></form:textarea>
                </div>
            </div>
            <div class="text-center">
                <input type="submit" class="btn btn-primary" value="수정" style="background-color : #6998AB"/>
            </div>
		</form:form>
	</div>
</div>
</body>
</html>