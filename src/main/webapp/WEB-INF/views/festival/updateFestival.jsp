<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet">
<title>Festival 수정</title>
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
<jsp:include page="../nav.jsp" flush="false"></jsp:include>y>
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
	
	<div class="container">
			<div class="py-5 text-center">
		     
		      <h2>Course update form</h2>
		      <p class="lead">추천 코스를 수정해 주세요.</p>
		    </div>
		
		<br><br>
		<div class="row g-5">
				<div class="col-md-7 col-lg-8">
					<form:form modelAttribute="updateFestival"
								action="./update"
					 class="needs-validation"
					 method="post">
					<div class="row g-3">
					<fieldset>
						<legend class="mb-3">festival 수정</legend>
						<div class="col-12">
							<label class="form-label"> fesNo</label>
							<div class="col-sm-3">
								<form:input type="hidden" path="fesNo" class="form-control" value="${festival.fesNo}"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">축제명</label>
							<div class="col-sm-3">
								<form:input path="fstvlNm" class="form-control" type="text" value="${festival.fstvlNm}"/>
							</div>
						</div>
				
						<div class="col-12">
							<label class="form-label">개최장소</label>
							<div class="col-sm-3">
								<form:input path="opar" class="form-control" type="text" value="${festival.opar}"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">축제 시작 일자</label>
							<div class="col-sm-3">
								<form:input path="fstvlStartDate" class="form-control" value="${festival.fstvlStartDate}" type="date"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">축제 종료 일자</label>
							<div class="col-sm-3">
								<form:input path="fstvlEndDate" class="form-control" value="${festival.fstvlEndDate}" type="date"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">축제 내용</label>
							<div class="col-sm-3">
								<form:input path="fstvlCo" class="form-control" value="${festival.fstvlCo}"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">주관기관명</label>
							<div class="col-sm-3">
								<form:input path="mnnstNm" class="form-control" value="${festival.mnnstNm}"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">주최기관명</label>
							<div class="col-sm-3">
								<form:input path="auspcInsttNm" class="form-control" value="${festival.auspcInsttNm}"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">후원기관명</label>
							<div class="col-sm-3">
								<form:input path="suprtInsttNm" class="form-control" value="${festival.suprtInsttNm}"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">전화번호</label>
							<div class="col-sm-3">
								<form:input path="phoneNumber" class="form-control" value="${festival.phoneNumber}"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">홈페이지 주소</label>
							<div class="col-sm-3">
								<form:input path="homepageUrl" class="form-control" value="${festival.homepageUrl}"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">관련 정보</label>
							<div class="col-sm-3">
								<form:input path="relateInfo" class="form-control" value="${festival.relateInfo}"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">도로명주소</label>
							<div class="col-sm-3">
								<form:input path="rdnmadr" class="form-control" value="${festival.rdnmadr}"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">지번주소</label>
							<div class="col-sm-3">
								<form:input path="lnmadr" class="form-control" value="${festival.lnmadr}"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">위도</label>
							<div class="col-sm-3">
								<form:input path="latitude" class="form-control" value="${festival.latitude}"/>
							</div>
						</div>
						<div class="col-12">
							<label class="form-label">경도</label>
							<div class="col-sm-3">
								<form:input path="longitude" class="form-control" value="${festival.longitude}"/>
							</div>
						</div>
						
						<div class="col-12">
							<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" class="btn btn-primary" value="전송" />
							</div>
						</div>
					</fieldset>
					
					</div>
					</form:form>
				</div>
		</div>
	</div> 	
</body>
</html>