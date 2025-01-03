<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Festival 등록</title>
</head>
<body>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
	<div class="container">
		<div class="py-5 text-center">
	     
	      <h2>Festival add form</h2>
	      <p class="lead">Festival를 등록해 주세요.</p>
	    </div> 
	
		<br><br>
		<div class="row g-5">
			<div class="col-md-7 col-lg-8">
				<form:form modelAttribute="NewFestival"
							action="./add"
				 class="needs-validation"
				 method="post">
				 <div class="row g-3">
					<fieldset>
					<legend class="mb-3">Festival</legend>
					
					<div class="col-12">
						<label class="form-label">축제명</label>
						<div class="col-sm-3">
							<form:input path="fstvlNm" class="form-control" type="text" />
						</div>
					</div>
			
					<div class="col-12">
						<label class="form-label">개최장소</label>
						<div class="col-sm-3">
							<form:input path="opar" class="form-control" type="text"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">축제 시작 일자</label>
						<div class="col-sm-3">
							<form:input path="fstvlStartDate" class="form-control" type="date"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">축제 종료 일자</label>
						<div class="col-sm-3">
							<form:input path="fstvlEndDate" class="form-control" type="date"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">축제 내용</label>
						<div class="col-sm-3">
							<form:textarea path="fstvlCo" class="form-control" type="text"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">주관기관명</label>
						<div class="col-sm-3">
							<form:input path="mnnstNm" class="form-control" type="text"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">주최기관명</label>
						<div class="col-sm-3">
							<form:input path="auspcInsttNm" class="form-control" type="text"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">후원기관명</label>
						<div class="col-sm-3">
							<form:input path="suprtInsttNm" class="form-control" type="text"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">전화번호</label>
						<div class="col-sm-3">
							<form:input path="phoneNumber" class="form-control" type="text"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">홈페이지 주소</label>
						<div class="col-sm-3">
							<form:input path="homepageUrl" class="form-control" type="text"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">관련 정보</label>
						<div class="col-sm-3">
							<form:input path="relateInfo" class="form-control" type="text"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">도로명주소</label>
						<div class="col-sm-3">
							<form:input path="rdnmadr" class="form-control" type="text"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">지번주소</label>
						<div class="col-sm-3">
							<form:input path="lnmadr" class="form-control" type="text"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">위도</label>
						<div class="col-sm-3">
							<form:input path="latitude" class="form-control" type="text"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">경도</label>
						<div class="col-sm-3">
							<form:input path="longitude" class="form-control" type="text"/>
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