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
</style>
<body>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<section id="main" class="py-5 text-center">
    <div class="row py-lg-3">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-semibold">축제 목록</h1>
        <p class="lead text-muted fw-normal">경상남도에서 개최되는 축제 목록입니다.</p>
        <p>
          <a href="${pageContext.request.contextPath}/festival/add" class="btn btn-primary my-2" style="background-color : #1A374D; border: 0;">festival 추가 &raquo;</a>
        </p>
      </div>
    </div>
</section>
<div class="album py-5 bg-light">
	<div class="container">
		<div class="col-md-10 row col-lg-6 col-md-8 mx-auto mb-5 d-flex align-items-center text-center">
			<form class="col text-center d-flex align-items-center" action=" ${pageContext.request.contextPath}/festival/month" method="post">
				<input class="col text-center p-1" style="background-color : white; color: #1A374D; border: 2px solid #1A374D;" name="stringMonth" type="month"/>
				<input class="col text-center p-2 btn btn-primary m-2" style="background-color : #1A374D; border: 0;" type="submit" value="월별 조회"/>
			</form>
			<form class="col text-center d-flex align-items-center text-center" action=" ${pageContext.request.contextPath}/festival/week" method="post">
				<input class="col text-center p-1" style="background-color : white;  color: #1A374D; border: 2px solid #1A374D;" name="stringDate" type="date"/>
				<input class="col text-center p-2 btn btn-primary m-2" style="background-color : #1A374D; border: 0;" type="submit" value="주별 조회" />
			</form>
		</div>
		<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4 d-flex justify-content-center ">
			<c:choose>
				<c:when test="${listOfFestivals.isEmpty()}">
				<p class="col text-center">등록된 축제가 없습니다.</p>
				</c:when>
				<c:otherwise>
					<c:forEach items="${listOfFestivals}" var="festival">
						<div class="card shadow-sm mx-3 col-md-3">
							<svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false">
							<title>Placeholder</title>
							<rect width="100%" height="100%" fill="#55595c"></rect><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
							<div class="card-body">
								<h4>축제명 : ${festival.fstvlNm}</h3>
				              	<p class="card-text">개최 기간 : ${festival.fstvlStartDate} - ${festival.fstvlEndDate}</p>
				              	<p> 개최장소 : ${festival.opar}</p>
					            <div class="d-flex justify-content-between align-items-center">
					               <div class="btn-group">
					                  <a type="button" class="btn btn-sm btn-outline-secondary" href=" ${pageContext.request.contextPath}/festival/festivalNo?fesNo=${festival.fesNo}">자세히 보기</a>
					               </div>
					            </div>
				            </div>
						</div>
					</c:forEach>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
</body> 
</html>