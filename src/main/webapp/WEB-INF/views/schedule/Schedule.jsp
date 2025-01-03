<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Schedule</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	*{
		font-family: "Noto Sans KR", serif;
		font-style: none;
		text-decoration: none;
		font-weight : 500;
	}
	body{
		width:100vw;
		background-color: #f9f9f9;
		display: flex;
		flex-direction: column;
		align-content: center;
		justify-content: center;
	}
	.container {
	        background-color: #f9f9f9;
	    }
	.container div {
		margin: 10px 0;
	 }

    .calendar {
        display: grid;
        grid-template-columns: repeat(7, 1fr); /* 7개의 열 */
        gap: 10px; /* 열 사이의 간격 */
        padding: 10px;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .header {
        background-color: #1A374D; /* 헤더 색상 */
        color: white;
        padding: 10px;
        text-align: center;
        font-weight: bold;
    }

    .dates {
        padding: 15px;
        text-align: center;
        border: 1px solid #ddd; /* 날짜 셀 경계선 */
        border-radius: 5px;
        background-color: #f0f0f0; /* 날짜 배경 색상 */
        transition: background-color 0.3s; /* 호버 효과 */
    }

    .dates:hover {
        background-color: #e0e0e0; /* 호버 시 색상 변화 */
    }

    button {
        padding: 10px 15px;
        font-size: 16px;
        background-color: #1A374D; /* 버튼 색상 */
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s; /* 호버 효과 */
    }

    button:hover {
        background-color: #0056b3; /* 버튼 호버 시 색상 변화 */
    }

    .calendar-navigation {
        display: flex;
        justify-content: space-between; /* 이전/다음 버튼 사이의 공간 조정 */
        align-items: center;
    }
</style>
<body>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<section class="text-center container" style="padding:0px; ">
    <div class="row justify-content-end" style="margin-top:20px;">
      <div class="col-lg-6 col-md-8" style="margin:0px; width: 200px;">
        <p style="margin:0px; width: 200px;">
          <a href="${pageContext.request.contextPath}/schedule/add" class="btn my-2" style="background-color:#1A374D; color: white;">Schedule 추가 &raquo;</a>
        </p>
      </div>
    </div>
</section>

<div class="text-center container">
	<div id="calendarButton" class="row pb-lg-3 col-lg-6 col-md-8 mx-auto">
		<div class="col text-center"><a href="${pageContext.request.contextPath}/schedule?year=${preYear}&month=${preMonth}"><button>이전 달</button></a></div>
		<div class="col text-center" style="font-size: 32px;">${year}년 ${month}월</div>
		<div class="col text-center"><a href="${pageContext.request.contextPath}/schedule?year=${nextYear}&month=${nextMonth}"><button>다음 달</button></a></div>
	</div>
	<div class="calendar mx-auto">
		<div class="header">일</div>
		<div class="header">월</div>
		<div class="header">화</div>
		<div class="header">수</div>
		<div class="header">목</div>
		<div class="header">금</div>
		<div class="header">토</div>
			<c:forEach var="i" begin="0" end="41">
				<div class="dates">
					<div id="date">
						${dates[i]}
					</div>
					<div id="schedule">
					<c:forEach items="${listOfSchedules}" var="schedule">
						<c:if test="${realDates[i] eq schedule.schedule_date}">
							<div class="row mx-auto justify-content-center">
								<p>${schedule.schedule_record}
								<div class="justify-content-between align-items-center">
				                	<div class="btn-group">
										<a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/schedule/update?schedule_id=${schedule.schedule_id}">수정</a>
										<a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/schedule/delete?schedule_id=${schedule.schedule_id}">삭제</a>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
					</div>
				</div>
			</c:forEach>
	</div>
</div>
</body> 
</html>