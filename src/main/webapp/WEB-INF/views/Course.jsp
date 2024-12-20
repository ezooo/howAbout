<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="./">Home</a>
<p><a href="${pageContext.request.contextPath}/course/add" class="btn btn-secondary" role="button">course 추가 &raquo;</a></p>
<div class="container">
	<div class="row" align="center">
		<h1>[id 검색 결과]</h1>
		<form action="${pageContext.request.contextPath}/course/courseFindById">
			<input name="submitId" type="text" placeholder="아이디를 검색하세요"/>
			<input type="submit" value="아이디 검색"/>
		</form>
		<c:forEach items="${courseFindById}" var="course">
			<div class="col-md-4">
				<h3>코스 이름 : ${course.course_name}</h3>
				<p>장소 이름 : ${course.location_name}
				<br>유저 이름 : ${course.userId}|작성 날짜 : ${course.creation_date}</p>
				<a href="${pageContext.request.contextPath}/course/update?course_id=${course.course_id}">수정하기</a>
				|<a href="${pageContext.request.contextPath}/course/delete?course_id=${course.course_id}">삭제하기</a>
				<p>==========================================================</p>
			</div>
		</c:forEach>
	</div>
</div>
</body>
</html>