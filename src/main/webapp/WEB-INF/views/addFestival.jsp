<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet">
<title>스케줄 등록</title>
</head>
<body>
 	<nav class="navbar navbar-expand navbar-dark bg-dark">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="./">Home</a>
			</div>
		</div>
	</nav>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">
			TITLE
			</h1>
		</div>
	</div> 
	
		<!-- <div class="float-right">
			<form:form action="${pageContext.request.contextPath}/logout" method="POST">
				<input type="submit" class="btn btn-sm btn-success" value="Logout" />
			</form:form>
		</div> 
		
	<div class="container">
		<div class="float-right" style="padding-right:30px">
			<a href="?language=ko">Korean</a>|<a href="?language=en">English</a>
		</div>
		 -->
		<br><br>
		<form:form modelAttribute="NewFestival"
					action="./add"
		 class="form-horizontal"
		 method="post">
		<fieldset>
		<legend>subtitle</legend>

		<div class="form-group row">
			<label class="col-sm-2 control-label">축제명</label>
			<div class="col-sm-3">
				<form:input path="fstvlNm" class="form-control" type="text" />
			</div>
		</div>

		<div class="form-group row">
			<label class="col-sm-2 control-label">개최장소</label>
			<div class="col-sm-3">
				<form:input path="opar" class="form-control" type="text"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">축제 시작 일자</label>
			<div class="col-sm-3">
				<form:input path="fstvlStartDate" class="form-control" type="date"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">축제 종료 일자</label>
			<div class="col-sm-3">
				<form:input path="fstvlEndDate" class="form-control" type="date"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">축제 내용</label>
			<div class="col-sm-3">
				<form:textarea path="fstvlCo" class="form-control" type="text"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">주관기관명</label>
			<div class="col-sm-3">
				<form:input path="mnnstNm" class="form-control" type="text"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">주최기관명</label>
			<div class="col-sm-3">
				<form:input path="auspcInsttNm" class="form-control" type="text"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">후원기관명</label>
			<div class="col-sm-3">
				<form:input path="suprtInsttNm" class="form-control" type="text"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">전화번호</label>
			<div class="col-sm-3">
				<form:input path="phoneNumber" class="form-control" type="text"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">홈페이지 주소</label>
			<div class="col-sm-3">
				<form:input path="homepageUrl" class="form-control" type="text"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">관련 정보</label>
			<div class="col-sm-3">
				<form:input path="relateInfo" class="form-control" type="text"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">도로명주소</label>
			<div class="col-sm-3">
				<form:input path="rdnmadr" class="form-control" type="text"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">지번주소</label>
			<div class="col-sm-3">
				<form:input path="lnmadr" class="form-control" type="text"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">위도</label>
			<div class="col-sm-3">
				<form:input path="latitude" class="form-control" type="text"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">경도</label>
			<div class="col-sm-3">
				<form:input path="longitude" class="form-control" type="text"/>
			</div>
		</div>
		
		

		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
			<input type="submit" class="btn btn-primary" value="전송" />
			</div>
		</div>
		</fieldset>
		</form:form>
	</div>
</body>
</html>