<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="./">Home</a>
<p><a href="schedule/add" class="btn btn-secondary" role="button">schedule 추가 &raquo;</a></p>
<div class="container">
	<div class="row" align="center">
		<c:choose>
			<c:when test="${listOfSchedules.isEmpty()}">
			<p>등록된 스케줄이 없습니다.</p>
			</c:when>
			<c:otherwise>
				<form action="${pageContext.request.contextPath}/schedule/month" method="post">
					<input name="stringMonth" type="month"/>
					<input type="submit" value="선택한 월 조회"/>
				</form>
				<form action="${pageContext.request.contextPath}/schedule/week" method="post">
					<input name="stringDate" type="date"/>
					<input type="submit" value="선택한 주 조회" />
				</form>
				<c:forEach items="${listOfSchedules}" var="schedule">
					<div class="col-md-4">
						<h3>날짜 : ${schedule.schedule_date}</h3>
						<p>내용 : ${schedule.schedule_record}
						<br>날씨 : ${schedule.weather}</p>
						<a href="${pageContext.request.contextPath}/schedule/update?schedule_id=${schedule.schedule_id}">수정하기</a>
						|<a href="${pageContext.request.contextPath}/schedule/delete?schedule_id=${schedule.schedule_id}">삭제하기</a>
						<p>==========================================================</p>
					</div>
				</c:forEach>
		</c:otherwise>
		</c:choose>
		
	</div>

</div>
</body> 
</html>