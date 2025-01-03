<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Yeseva+One&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/d75e97d418.js" crossorigin="anonymous"></script>
<style type="text/css">

	*
	{
		font-family: "Noto Sans KR", serif;
		font-optical-sizing: auto;
		font-weight: <weight>;
		font-style: normal;
	}
	
	#backgroundCon
	{
		position: relative;
		width: 100%;
		height: 65vh;
		background-color: #6998ab;
	}


</style>
</head>
<body>
	<jsp:include page="../nav.jsp" flush="false"></jsp:include>
	
	<div class="container" id="backgroundCon"></div>
	<div id="createDiv">
		<form:form method="post" modelAttribute="member" enctype="multipart/form-data">
			<div class="memberInputDiv"><p class="form_tag">닉네임 </p><form:input class="formInput" path="userName"/></div>
			<div class="memberInputDiv"><p class="form_tag">아이디 </p><form:input class="formInput" id="userId" path="userId"/> <button type="button" id="matchTheID" onclick="sendToController('userId')" >아이디 중복검사</button> </div>
			<div class="memberInputDiv"><p class="form_tag">비밀번호 </p><form:input class="formInput" path="userPw"/></div>
			<div class="memberInputDiv"><p class="form_tag">전화번호 </p><form:input class="formInput" path="userTel"/></div>
			<div class="memberInputDiv" id="memberAddrForm">
				<p class="form_tag">주소 </p><form:input class="formInput" path="userAddr" type="text" id="locationInput" onkeyup="searchLocation()" />
				<div id="results" class="results-container"></div>
			</div>
			
			<div class="memberInputDiv"><p class="form_tag">이메일 </p><form:input class="formInput" id="userEmail" path="userEmail"/> <button type="button" id="matchTheID" onclick="sendToController('userEmail')" >이메일 중복검사</button> </div>
			<div class="memberInputDiv"><p class="form_tag">프로필 사진 </p><input class="formInput" type="file" name="userIcon" /></div>
			<input type="submit" value="전송">
		</form:form>
	</div>

	
	<p> <a href="/howAbout/user/home">Home</a> </p>
</body>

<script type="text/javascript">
	
	function sendToController(placeData) {
		
		let dataToSend = {};
		
	    if (placeData === 'userId') {
	    	dataToSend.userId = document.querySelector("#userId").value;
	    } else if (placeData === 'userEmail') {
	    	dataToSend.userEmail = document.querySelector("#userEmail").value;
	    }
			
		$.ajax({
			url: '/howAbout/user/matchUser',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(dataToSend),
			success: function(response) {
				if(response.email){
					if(response.status){
						alert('사용 가능한 이메일 입니다.'); 
					} else {
						alert('중복된 이메일이 존재합니다. 다른 이메일을 사용해주세요.');
						document.querySelector("#userEmail").value = ""
					}
				}
				
				if(response.userId){
					if(response.status){
						alert('사용 가능한 아이디 입니다.'); 
					} else {
						alert('중복된 아이디가 존재합니다. 다른 아이디를 사용해주세요.');
						document.querySelector("#userId").value = ""
					}
				}	
			},
			error: function(xhr, status, error) {
				console.error('AJAX 오류:', error);
			}
		});
	}
	
	function searchLocation() {
	    const input = $('#locationInput').val();

	    if (input.length < 1) {
	        $('#results').empty();
	        $('#results').hide();
	        return;
	    }

	    $.ajax({
	        url: '/howAbout/user/searchLocation',
	        method: 'POST',
	        data: JSON.stringify({ query : input }),
	        contentType: 'application/json', //얘를 빼고 JSON을 보내면 Failed to load resource: the server responded with a status of 415 () 에러 발생
	        dataType: 'json',
	        success: function(data) {
	            const resultsDiv = $('#results');
	            resultsDiv.empty(); // 이전 결과 초기화
	            
	            if (data.list.length > 0) { $('#results').show(); } // 결과가 있을 때만 표시 
	            else { $('#results').hide(); } // 결과가 없으면 숨김 

	            $.each(data.list, function(index, location) {
	                const div = $('<div></div>').text(location.address);
	                div.addClass('result-item');
	                div.on('click', function() {
	                    $('#locationInput').val(location.address); // 선택한 주소를 input에 설정
	                    resultsDiv.hide(); // 선택 후 결과 숨김
	                });
	                resultsDiv.append(div); // 결과를 결과 영역에 추가
	            });
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', error); // 오류 로그
	        }
	    });
	}
	
</script>

</html>