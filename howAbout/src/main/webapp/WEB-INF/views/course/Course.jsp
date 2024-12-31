<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<body>
	<div class="container">
		<header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
		      <a href="/" class="d-flex align-items-center col-md-3 mb-2 mb-md-0 text-dark text-decoration-none"></a>
		      <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
		        <li><a href="${pageContext.request.contextPath}" class="nav-link px-2 link-secondary">Home</a></li>
		        <li><a href="${pageContext.request.contextPath}/course" class="nav-link px-2 link-dark">Course</a></li>
		        <li><a href="${pageContext.request.contextPath}/festival" class="nav-link px-2 link-dark">Festival</a></li>
		        <li><a href="${pageContext.request.contextPath}/location" class="nav-link px-2 link-dark">Location</a></li>
		        <li><a href="${pageContext.request.contextPath}/schedule" class="nav-link px-2 link-dark">Schedule</a></li>
		        <li><a href="${pageContext.request.contextPath}/weather" class="nav-link px-2 link-dark">Weather</a></li>
		      </ul>
		</header>
	</div>
<main class="container">
	<div class="p-4 p-md-5 mb-4 text-white rounded bg-dark">
	    <div class="col-md-6 px-0">
	      <h1 class="display-4 fst-italic">코스 검색 결과</h1>
	      <p class="lead my-3">아이디로 검색한 코스 결과입니다.</p>
		  <p class="lead mb-0"><a href="${pageContext.request.contextPath}/course/add"  class="text-white fw-bold">추천 코스 등록하러 가기 &raquo;</a></p>
	    </div>
	</div>

	<div class="container">
		<div class="row" align="center">
			<form action="${pageContext.request.contextPath}/course/courseFindById" class="d-flex my-3">
				<input name="submitId" class="form-control" type="text" placeholder="아이디를 검색하세요"/>
				<input type="submit" class="btn btn-outline-success mx-2" value="아이디 검색"/>
			</form>
			<c:forEach items="${courseFindById}" var="course">
				<div class="col-md-6">
					<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
						<div class="col p-4 d-flex flex-column position-static">
				          <strong class="d-inline-block mb-2 text-primary">World</strong>
				          <h3 class="mb-0">코스 이름 : ${course.course_name}</h3>
				          <div class="mb-1 text-muted"><p>유저 이름 : ${course.userId}|작성 날짜 : ${course.creation_date}</div>
				          <p class="card-text mb-auto">장소 : </p>
				          	<c:forEach var="location" items="${course.location_names}" varStatus="status">
								 <span>${location}  <c:if test="${!status.last}"> &rarr; </c:if></span>
							</c:forEach>
				          <a href="${pageContext.request.contextPath}/course/update?course_id=${course.course_id}" >수정하기</a>
							|<a href="${pageContext.request.contextPath}/course/delete?course_id=${course.course_id}"  >삭제하기</a>
				        </div>
				     </div>
				</div>
			</c:forEach>
		</div>
	</div>
</main>
</body>
</html>