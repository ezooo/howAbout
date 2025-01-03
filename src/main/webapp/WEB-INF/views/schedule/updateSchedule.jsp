<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>스케줄 수정</title>
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

</style>
<body style="background-color:rgb(248 249 250);">
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
	<div class="container">
		<br><br>
		<div class="row g-5" >
			<div class="bg-body-tertiary col-md-7 col-lg-8 ">
				<div class="my-3 p-3">
					<form:form modelAttribute="updateSchedule"
								action="./update"
					 class="needs-validation"
					 method="post">
					<div class="row g-3 bg-body shadow-sm mx-auto p-5"  style="border-radius: 21px 21px 0 0;">
					<fieldset>
						<legend class="mb-3 display-5">Schedule 수정</legend>
						<div class="col-12">
							<div class="col-12">
								<form:input type="hidden" path="schedule_id" class="form-control" value="${schedule.schedule_id}"/>
							</div>
						</div>
						<div class="col-12">
							<div class="col-12">
								<form:input type="hidden" path="userId" class="form-control" value="${schedule.userId}"/>
							</div>
						</div>
						<div class="col-12 lead my-3">
							<label class="form-label mx-3">날짜</label>
							<div class="mx-5">
								<form:input path="schedule_date" class="form-control" type="date" value="${schedule.schedule_date}"/>
							</div>
						</div>
						<div class="col-12 lead my-3">
							<label class="form-label mx-3">내용</label>
							<div class="mx-5">
								<form:input path="schedule_record" class="form-control" value="${schedule.schedule_record}"/>
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
	</div>
</body>
</html>