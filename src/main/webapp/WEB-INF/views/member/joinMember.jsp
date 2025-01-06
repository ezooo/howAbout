<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Yeseva+One&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/d75e97d418.js" crossorigin="anonymous"></script>
<style type="text/css">

	*{
	  font-family: "Noto Sans KR", serif;
	  font-optical-sizing: auto;
	  font-weight: <weight>;
	  font-style: normal;
	}

	.divCon
	{
		position: relative;
		width: 100%;
		height: 65vh;
		background-color: #6998ab;
	}
	
	#createDiv
	{
		position: absolute;
		width: 50%;
		height: 80vh;
		left: 50%;
		transform : translateX(-50%);
		top: 15%;
		background-color: white;
		border-radius: 30px;
		padding-top: 80px;
	}
	
	#joinForm
	{
		position: relative;
		width: 65%;
		margin: 0 auto;
	}
	
	.form_tag
	{
		margin-bottom: 3px;
		font-weight: 500;
	}
	
	
	.formInput
	{
		display: inline-blockblock;
		width: 100%;
		height: 45px;
		line-height: 30px;
		border: 2px solid #dddddd;
		border-radius: 5px;
		margin-bottom: 10px;
		padding-left: 20px;
		outline: none;
	}
	
	#joinBtn
	{
		display:block;
		width: 90px;
		height: 40px;
		background-color: #6998ab;
		border: none;
		border-radius: 5px;
		margin-top: 35px;
		font-weight: 500;
		color: white;
	}
	
	#joinBtnDiv
	{
		width: 100%;
		display: flex;
		justify-content: flex-end;
	}
	
	.results-container
	{
		position: absolute;
	    max-height: 150px; /* 최대 높이 설정 (원하는 높이로 조정 가능) */
	    width: 100%;
	    overflow-y: auto;  /* 세로 스크롤 가능 */
	    border: 1px solid #ccc; /* 경계선 추가 (선택 사항) */
	    background-color: #fff; /* 배경색 설정 (선택 사항) */
	    display: none; /* 초기에는 숨김 */
	}

	.results-container div
	{
		padding: 8px; /* 각 결과의 패딩 */
		cursor: pointer; /* 마우스 커서를 포인터로 변경 */
	}
	
	.results-container div:hover
	{
		background-color: #f0f0f0; /* 호버 효과 */
	}

</style>
</head>
<body>
	<jsp:include page="../nav.jsp" flush="false"></jsp:include>
	
	<div class="divCon">
	
		<div id="createDiv">
			<form:form id="joinForm" method="post" modelAttribute="member" enctype="multipart/form-data">
				<div class="memberInputDiv">
					<p class="form_tag">유저 이름 </p>
					<form:input class="formInput" path="userName"/>
				</div>
				<div class="memberInputDiv">
					<p class="form_tag">아이디 </p>
					<form:input class="formInput" id="userId" path="userId"/>
					<!-- <button type="button" id="matchTheID" onclick="sendToController('userId')" >아이디 중복검사</button>  -->
				</div>
				<div class="memberInputDiv">
					<p class="form_tag">비밀번호 </p>
					<form:input class="formInput" path="userPw"/>
				</div>
				<div class="memberInputDiv">
					<p class="form_tag">전화번호 </p>
					<form:input class="formInput" path="userTel"/>
				</div>
				<div class="memberInputDiv" id="memberAddrForm">
					<p class="form_tag">주소 </p><form:input placeholder="위치별 정보를 전해드립니다, 드롭박스 안에서 선택해주세요 (세부주소 X)" class="formInput" path="userAddr" type="text" id="locationInput" onkeyup="searchLocation()" />
					<div id="results" class="results-container"></div>
				</div>
				
				<div class="memberInputDiv">
					<p class="form_tag">이메일 </p>
					<form:input class="formInput" id="userEmail" path="userEmail"/>
					<!-- <button type="button" id="matchTheID" onclick="sendToController('userEmail')" >이메일 중복검사</button>  -->
				</div>
				<div class="memberInputDiv">
					<p class="form_tag">프로필 사진 </p>
					<input class="formInput form-control" type="file" name="userIcon" />
				</div>
				<div id="joinBtnDiv">
					<input id="joinBtn" type="submit" value="가입하기">
				</div>
				
			</form:form>
		</div>

	</div>
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