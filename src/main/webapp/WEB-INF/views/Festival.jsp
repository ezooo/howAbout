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
		<div class="col-md-4">
			<h3>개최 기간 : ${festival.fstvlStartDate} - ${festival.fstvlEndDate}</h3>
			<p> 축제명 : ${festival.fstvlNm}</p>
			<p> 개최장소 : ${festival.opar}</p>
			<p> 축제내용 : ${festival.fstvlCo}</p>
			<p> 주관기관 : ${festival.mnnstNm} | 주최기관 : ${festival.auspcInsttNm} | 후원기관 : ${festival.suprtInsttNm}</p>
			<p> 전화번호 : ${festival.phoneNumber} | 홈페이지 : ${festival.homepageUrl}</p>
			<p> 관련정보 : ${festival.relateInfo}</p>
			<p> 주소 : ${festival.rdnmadr} | ${festival.lnmadr}</p>
			<p> 위치 : ${festival.latitude} | ${festival.longitude}</p>
			<p> 데이터 기준 일자 : ${festival.referenceDate}</p>
			
			<a href=" ${pageContext.request.contextPath}/festival/update?fesNo=${festival.fesNo}">수정하기</a>
			|<a href=" ${pageContext.request.contextPath}/festival/delete?fesNo=${festival.fesNo}">삭제하기</a>
			<p>==========================================================</p>
		</div>
	</div>
</div>
</body> 
</html>