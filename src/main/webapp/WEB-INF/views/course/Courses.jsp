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
<style>
.noto-sans-kr-<uniquifier> {
	  font-family: "Noto Sans KR", serif;
	  font-optical-sizing: auto;
	  font-weight: <weight>;
	  font-style: normal;
	}
*{
	font-family: "Noto Sans KR", serif;
	font-style: none;
	text-decoration: none;
	font-weight : 500;
}
#main{
	background-color : #6998AB;
}
#main h1 {
	font-weight: 600;
}
#idSearch{
	color: white;
	background-color:#1A374D;
}
</style>
<body>

<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<main class="container">
	<div id="main" class="p-4 p-md-5 mb-4 text-white rounded" style=" background-color: #b4ccd5; ">
	    <div class="col-md-6 px-0">
	      <h1 class="display-4 fst-italic">코스 추천</h1>
	      <p class="lead my-3">사람들이 추천하는 코스를 확인해 보세요. 나만이 알고 있는 코스도 추가해 보세요!</p>
		  <p class="lead mb-0"><a href="${pageContext.request.contextPath}/course/add"  class="text-white fw-bold">추천 코스 등록하러 가기 &raquo;</a></p>
	    </div>
	</div>
	<div class="container">
		<div class="row" align="center">
			<div class="d-flex align-items-center justify-content-center" style="width:100%;">
				<form action="${pageContext.request.contextPath}/course/courseFindById" class="my-3 d-flex" >
					<input name="submitId" type="text" class="form-control d-flex align-items-center" style="width:50%;" placeholder="아이디를 검색하세요"/>
					<input id="idSearch" type="submit" class="btn btn-outline-success mx-2 d-flex align-items-center" style=" border-color:#1A374D;" value="아이디 검색"/>
				</form>		
			</div>
	  
			<c:forEach items="${listOfCourses}" var="course">
				<div class="col-md-6">
					<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
						<div class="col p-4 d-flex flex-column position-static">
				          <strong class="d-inline-block mb-2 text-primary">World</strong>
				          <h3 class="mb-0">코스 이름 : ${course.course_name}</h3>
				          <div class="text-muted d-flex"><p>작성자 : ${course.userId} | 작성 날짜 : ${course.creation_date}</div>
				          <div class="d-flex my-3">
					          <p class="card-text mb-auto d-flex">장소 :&nbsp;</p>
					          	<c:forEach var="location" items="${course.location_names}" varStatus="status">
									 <span class="d-flex">${location}  <c:if test="${!status.last}"> &rarr; &nbsp;</c:if></span>
								</c:forEach>
				          </div>
						  <div class="justify-content-between align-items-center my-3">
					               <div class="btn-group">
							          <a type="button" class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/course/update?course_id=${course.course_id}" >수정하기</a>
									  <a type="button" class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/course/delete?course_id=${course.course_id}" >삭제하기</a>
					               </div>
					       </div>
				        </div>
		      		</div>
	 			</div>
			</c:forEach>
		</div>
	</div>
</main>
</body>
</html>