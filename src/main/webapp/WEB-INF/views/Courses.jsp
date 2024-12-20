<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
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
		<form action="${pageContext.request.contextPath}/course/courseFindById">
			<input name="submitId" type="text" placeholder="아이디를 검색하세요"/>
			<input type="submit" value="아이디 검색"/>
		</form>
		<c:forEach items="${listOfCourses}" var="course">
			<div class="col-md-4">
				<h3>코스 이름 : ${course.course_name}</h3>
				<span> 장소 : </span>
				<c:forEach var="location" items="${course.location_names}" varStatus="status">
					 <span>${location}  <c:if test="${!status.last}"> &rarr; </c:if></span>
				</c:forEach>

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