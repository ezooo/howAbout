<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Festival</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
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
<section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-light">축제 목록</h1>
        <p class="lead text-muted">경상남도에서 개최되는 축제 목록입니다.</p>
        <p>
          <a href="${pageContext.request.contextPath}/festival/add" class="btn btn-primary my-2">festival 추가 &raquo;</a>
        </p>
      </div>
    </div>
</section>
<div>
	<div class="container">
		<div class="row" align="center">
			<c:choose>
				<c:when test="${listOfFestivals.isEmpty()}">
				<p>등록된 축제가 없습니다.</p>
				</c:when>
				<c:otherwise>
					<form action=" ${pageContext.request.contextPath}/festival/month" method="post">
						<input name="stringMonth" type="month"/>
						<input type="submit" value="선택한 월 조회"/>
					</form>
					<form action=" ${pageContext.request.contextPath}/festival/week" method="post">
						<input name="stringDate" type="date"/>
						<input type="submit" value="선택한 주 조회" />
					</form>
					<c:forEach items="${listOfFestivals}" var="festival">
						<div class="col-md-4">
							<h3>개최 기간 : ${festival.fstvlStartDate} - ${festival.fstvlEndDate}</h3>
							<a href=" ${pageContext.request.contextPath}/festival/festivalNo?fesNo=${festival.fesNo}">축제명 : ${festival.fstvlNm}</a>
							<p> 개최장소 : ${festival.opar}</p>
							<p>==========================================================</p>
						</div>
					</c:forEach>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
</body> 
</html>