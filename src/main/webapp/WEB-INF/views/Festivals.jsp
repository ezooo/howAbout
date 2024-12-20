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
<p><a href=" ${pageContext.request.contextPath}/festival/add" class="btn btn-secondary" role="button">festival 추가 &raquo;</a></p>
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
</body> 
</html>