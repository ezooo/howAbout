<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.List"  %>
<%@ page import="org.springframework.ui.Model"  %>

<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Schedule</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
    	width: 200px;
        background-color: #1A374D; /* 헤더 색상 */
        color: white;
        padding: 10px;
        text-align: center;
        font-weight: bold;
    }

    .dates {
    	width: 200px;
    	height: 230px;
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
        <div class="col text-center"><a href="${pageContext.request.contextPath}/calendar?year=${preYear}&month=${preMonth}"><button>이전 달</button></a></div>
        <div class="col text-center" style="font-size: 32px;" id="monthDiv" > <span id="spanYear">${year}</span>년 <span id="spanMonth">${month}</span>월</div>
        <div class="col text-center"><a href="${pageContext.request.contextPath}/calendar?year=${nextYear}&month=${nextMonth}"><button>다음 달</button></a></div>
    </div>
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
						<span id="dates${i}">${dates[i]}</span>
						<p id="todaybox${i}"></p>
						<p id="todaytemp${i}"></p>
						<div id="nowWeather"></div>
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
<% List<String> realDatesString = (List<String>)request.getAttribute("realDatesString"); %>
</body> 
<script src="/howAbout/resources/js/weatherfunc.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
    $.ajax({
        url: '/howAbout/weather/callThree',
        type: 'GET',
        contentType: 'application/json',
        success: function(response) {
        	
        	for (const key in response) {
                if (response.hasOwnProperty(key)) {
                    const list = response[key];
                    var fcstDate = list[0].fcstDate;
					var year = fcstDate.substring(0, 4);	//년
				    var month = fcstDate.substring(4, 6);	//월
				    var day = fcstDate.substring(6, 8);		//일
				    console.log("월 : " + month + "일 : " + day);
				    
				    if($('#spanYear').text() === year){
				    	console.log($('#spanMonth').text())
				    
				    	if(parseInt($('#spanMonth').text()) === parseInt(month)){
				    		$('.dates').each(function() {
				    		    const dateText = $(this).text();
				    		    console.log(dateText)

				    		    if (parseInt(dateText) === parseInt(day)) {
				    		    	const temp = $('<p></p>');
				    		    	const spanTMN = $('<span></span>').text("최저"+Math.floor(list[0].fcstValue));
				    		    	const spanTMX = $('<span></span>').text("최고"+Math.floor(list[1].fcstValue));
				    		    	temp.append(spanTMN);
				    		    	temp.append(spanTMX);
				    		    	$(this).append(temp); 
				    		    }
				    		}); //엣헹
				    	}
                	}
            	}
        	}
        },
        error: function(xhr, status, error) {
            console.error('에러', error);
        }
    });
	
});

$(document).ready(function() {
		console.log("now weather 불러오는 함수 실행");
		$.ajax({
			url : '${pageContext.request.contextPath}/weather/callNow',
			type : 'GET',
			dataType : "json",
			contentType : "application/json",
			success : function(response){
				console.log("now weather 불러오기 성공");
				console.log('Response:', response);
				printNow(response);
			},
			error : function(xhr, status, error){
				console.error('Status:', status);
		        console.error('Error:', error);
		        console.error('Response Text:', xhr.responseText);
		        console.error('Response Status:', xhr.status);
			}
		});
});

function printNow(response){
	var realDatesString = <%= realDatesString%>;
	console.log("printNow 실행됨");
	for(var i=0; i<response.length; i++){
		var reponseDate = new Date(response[i].fcstDate);
		var realDate = new Date(realDatesString[i]);
		console.log("response 출력 : "+reponseDate);
		console.log("realDates 출력 : "+realDate);
		if(reponseDate.getTime() === realDate.getTime()){
			var html = '';
			html += '<div> 시간 : '+response[i].fcstTime+'</div><div> 기온 : '+response[i].T1H+'</div>';
			$('#nowWeather').html(html);
		}
	}
}
</script>
</html>