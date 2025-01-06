<%@page import="java.util.List"%>
<%@page import="com.springproject.domain.Review"%>
<%@page import="com.springproject.domain.Member"%>
<%@page import="com.springproject.domain.Place"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8ba5137fb1c2b1e37ac6722ae8d8e587&libraries&libraries=services"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Yeseva+One&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/d75e97d418.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8ba5137fb1c2b1e37ac6722ae8d8e587&libraries=services"></script>
<head>
<meta charset="UTF-8">
	<% Place place = (Place)request.getAttribute("place"); %>
<title>Insert title here</title>
<script type="text/javascript">

	$(document).ready(function() {
		
		let currentIndex = 0;
		
	    const currentUrl = window.location.href;
	    
	    let userId;
	    
	    $.ajax({
	        url: '/howAbout/review/sessionInfo',
	        type: 'GET',
	        success: function(memberData) {
	            userId = memberData.userId;
	        },
	        error: function(xhr, status, error) {
	            console.error('Member 정보 로드에 실패했습니다.', error);
	        }
	    });
	    
	    $.ajax({
	        url: '/howAbout/review/all', // 리뷰 데이터를 가져올 API 엔드포인트
	        method: 'GET',
	        data: { "url" : currentUrl },
	        success: function(data) {
	        	console.log(data);
				displayReviews(data);
	        },
	        error: function(xhr, status, error) {
	            console.error('리뷰 데이터를 가져오는 데 실패했습니다:', error);
	        }
	    });
	
	    function displayReviews(reviews) {
	        const container = $('#review-container');
	        container.empty();
	        
	        if (reviews.length === 0) {
                container.append('<p>작성된 리뷰가 없습니다.</p>');
                return;
            }
	        
	        reviews.forEach(function(review) {
	            const reviewElement = $('<div class="review"></div>');
	            const reviewTextBox = $('<div class="review_textBox"></div>')
	            // #review-container의 너비를 리뷰 수에 따라 조정
	            const containerWidth = reviews.length * 500; // 각 리뷰가 500px이므로
	            $('#review-container').css('width', containerWidth + 'px');
	            
	                let reviewText = review.reviewText;
	            
				    if (reviewText.length > 40) {
				        reviewText = reviewText.substring(0, 40) + '...';
				    }
	            
				reviewTextBox.append('<div class="review_userIcon" style="background-image: url(\'/howAbout/resources/userIcon/' + review.iconName + '\');"></div>');
	            reviewTextBox.append('<p class="reviewUser">'+ review.userId +'</p>');
	            reviewTextBox.append('<p class="reviewDate">'+ review.reviewDate +'</p>');
	            reviewTextBox.append('<p class="reviewText">'+ reviewText +'</p>');
	            reviewTextBox.append('<hr class="reviewBar">');
	            
	            reviewElement.append(reviewTextBox);
	            
	            if(review.userId == userId){
	            	reviewTextBox.append('<button type="button" class="editReview" data-id="'+review.millisId+'" data-text="'+review.reviewText+'">수정</button> | ');
	            	reviewTextBox.append('<a href="/howAbout/review/delete/'+review.millisId+'" class="deleteReview">삭제</a>');
	            } else {
	            	reviewTextBox.append('<button type="button" class="selectReview" onclick="">자세히 보기</button>');	
	            }
	            
	            container.append(reviewElement);
	            
	        });
	        
	        if (reviews.length > 2) {
	            setInterval(slideReviews, 3000);
	        }

	    }

	    function slideReviews() {
	        const totalReviews = $('#review-container .review').length;
	        const pixelsPerSlide = 500; // 각 리뷰의 너비는 500px

	     	// 슬라이드 이동
	        currentIndex++;

	        // 현재 인덱스가 총 슬라이드 수를 초과하면 초기화
	        if (currentIndex >= totalReviews-1) {
	            currentIndex = 0;

	            // 처음 리뷰를 다시 추가하여 부드럽게 이어지도록 함
	            $('#review-container').css('transform', 'translateX(0)'); // 처음 위치로 돌아감
	        } else {
	            $('#review-container').css('transform', 'translateX(' + (-currentIndex * pixelsPerSlide) + 'px)');
	        }
	    }
	    
	    let currentReviewId; // 현재 수정 중인 리뷰 ID

	    $(document).on('click', '.editReview', function(e) {
	        e.preventDefault();
	        currentReviewId = $(this).data('id'); 
	        const reviewText = $(this).data('text'); 
	        $('#editReviewText').val(reviewText); 
	        $('#editReviewModal').show();
	    });

	    
	    $('.close').click(function() {
	        $('#editReviewModal').hide();
	    });

	    // 리뷰 수정 저장
	    $('#saveChanges').click(function() {
	        const updatedText = $('#editReviewText').val(); // 수정된 텍스트 가져오기

	        $.ajax({
	            url: '/howAbout/review/update/' + currentReviewId,
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({ "reviewText" : updatedText }),
	            success: function(response) {
	                $('#editReviewModal').hide(); // 모달 닫기
	                // 리뷰 목록을 새로고침
	                $.ajax({
	                    url: '/howAbout/review/all',
	                    method: 'GET',
	                    data: { "url": currentUrl },
	                    success: function(data) {
	                        displayReviews(data);
	                    }
	                });
	                
	                alert('정상적으로 수정이 완료되었습니다.');
	            },
	            error: function(xhr, status, error) {
	                console.error('리뷰 수정에 실패했습니다:', error);
	            }
	        });
	    });
	    
	    $(document).on('click', '.deleteReview', function(e) {
	        e.preventDefault();
	        const reviewId = $(this).attr('href').split('/').pop();
	        // 삭제할 리뷰 ID 가져오기

	        if (confirm("이 리뷰를 정말 삭제하시겠습니까?")) {
	            $.ajax({
	                url: '/howAbout/review/delete/' + reviewId,
	                type: 'POST',
	                success: function(response) {
	                    $.ajax({
	                        url: '/howAbout/review/all',
	                        method: 'GET',
	                        data: { "url": currentUrl },
	                        success: function(data) {
	                            displayReviews(data);
	                        }
	                    });
	                },
	                error: function(xhr, status, error) {
	                    console.error('리뷰 삭제에 실패했습니다:', error);
	                }
	            });
	        }
	    });

	});
</script>
<style>

	*
	{
		font-family: "Noto Sans KR", serif;
	  	font-optical-sizing: auto;
	  	font-weight: <weight>;
	  	font-style: normal;
	}
	
	#backgroundCon2
	{
		position: fixed;
		z-index: -5;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: #FFF5E1;
	}

	#map
	{
		position: absolute;
		z-index: 2;
		top:150px;
		width: 1000px;
		height: 550px;
		border-radius: 10px;
		
	}

	.modal
	{
	    display: none;
	    position: fixed; 
	    z-index: 5; 
	    left: 0;
	    top: 0;
	    width: 100%; 
	    height: 100%; 
	    overflow: auto; 
	    background-color: rgb(0,0,0); 
	    background-color: rgba(0,0,0,0.4); 
	}
	
	.modal-content
	{
	    position: relative;
	    z-index: 10;
	    margin: 5% auto; 
	    padding: 20px;
	    border: 1px solid #888;
	    width: 60%; 
	    background-color: white;
	}
	
	.close
	{
	    color: #aaa;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	}
	
	.close:hover,
	.close:focus
	{
	    color: black;
	    text-decoration: none;
	    cursor: pointer;
	}
	
	iframe
	{
	    width: 100%;
	    height: 700px;
	}
	
	#openModal
	{
		background-color: #FEE500; /* 카카오 색상 */
		color: #3C1E1E; /* 글자 색상 */
		border: none;
		padding: 10px 20px;
		border-radius: 5px;
		cursor: pointer;
		font-weight: bold;
		text-align: center;
		margin-top: 20px;
	}
	
	
	.divCon
	{
		position: relative;
		padding-top: 50px;
		width: 1000px;
		margin: 0 auto;
	}
	
	#placeTitle
	{
		margin-bottom: 10px;
		color: white;
		text-align: left;
	}
	
	.iTag
	{
		display: inline-block;
		width: 30px;
		margin: 0;
		padding: 0;
	}
	
	#placeStatus
	{
		position: absolute;
		top: 450px;
		left: 30px;
		z-index: 4;
	}
	
	.placeStatusItag
	{
		display: flex;
	}
	
	.placeStatusItag > p
	{
		margin: 0;
		padding: 0;
		margin-left: 10px;
	}
	
	#kakaoStatus
	{
		padding-left: 20px;
		padding-top: 20px;
		background-color: rgba(255,255,255,1);
		border-radius: 10px;
		width: 390px;
		height: 200px;
	}
	
	#reviewCon
	{
		position: absolute;
		top: 610px;
		padding-left: 20px;
		width: 1000px;
		margin: 0 auto;
	}
	
	#backgroundCon
	{
		position: absolute;
		z-index: -3;
		width: 100%;
		height: 65vh;
		background-color: #6998ab;
	}
	
	#wishBtn
	{
		position: absolute;
		top: 60px;
		right: 0;
		background-color: white;
		border: none;
		width: 100px;
		height: 35px;
		border-radius: 5px;
	}
	
	.infoDiv
	{
		position: relative;
		top: -60px;
		text-align: center;
		width: 250px;
		height: 35px;
		line-height: 35px;
		background-color: white;
		border-radius: 10px;
	}
	
	.reviewCon
	{
		position: relative;
		z-index: 1;
		top: 20px;
		width: 1050px;
		height: 800px;
		background-color: white;
		border-radius: 25px;
	}
	
	#review-write
	{
		position: absolute;
		top: 200px;
	}
	
	#reviewText, #editReviewText
	{
		display: block;
		width: 850px;
		height: 150px;
		border-radius: 10px;
		padding-left: 10px;
		font-weight: 600;
		font-size: 20px;
		margin: 0 auto;
		border: 2px solid #ccc;
		font-size: 16px;
		padding: 20px;
	}
	
	#submitButton, #saveChanges
	{
		display: block;
		border: none;
		width: 130px;
		height: 35px;
		border-radius: 10px;
		background-color: #6998ab;
		color: white;
		margin: 20px auto;
	}
	
	#review-form
	{
		width: 1000px;
		margin: 0 auto;
	}
	
	.centerDiv
	{
		position: relative;
		width: 1000px;
	}
	

	
	.review_textBox
	{
		position: relative;
		border: 1px solid #ccc;
		border-radius: 10px;
		width: 400px;
		height: 170px;
		padding: 10px;
		padding-left: 50px;
		padding-right: 30px;
	}
	
	.review_userIcon
	{
		position: absolute;
		top: 50%;
		left: -40px;
		transform : translateY(-50%);
		width: 80px;
		height: 80px;
		border-radius:100px;
		background-size: cover;
		background-repeat: no-repeat;
		background-position: center;
	}
	
	.slider
	{
	    width: 100%; /* 슬라이더의 전체 너비 */
	    max-width: 1000px; /* 최대 너비를 1000px로 설정 */
	    overflow: hidden; /* 넘치는 부분은 숨김 */
	    position: relative; /* 슬라이드 애니메이션에 필요 */
	}
	
	#review-container
	{
	    display: flex; /* 가로로 나열 */
	    transition: transform 0.5s ease; /* 슬라이드 애니메이션 효과 */
	}
	
	.reviewText
	{
		height: 60px;
		padding-top: 7px;
	}
	
	.reviewUser
	{
		font-weight: 700;
		font-size: 20px;
	}
	
	.reviewDate
	{
		font-size: 12px;
		color: #ccc;
	}
	
	.reviewBar
	{
		margin-bottom: 10px;
	}
	
	.review
	{
		box-sizing: border-box;
    	width: 500px;
	}
	
	.editReview
	{
		border: none;
		width: 50px;
		height: 20px;
		background-color: #ccc;
		font-size: 12px;
		border-radius: 5px;
		cursor: pointer;
	}
	
	.selectReview
	{
		border: none;
		width: 80px;
		height: 20px;
		background-color: #ccc;
		font-size: 12px;
		border-radius: 5px;
		cursor: pointer;
		color: white;
	}
	
	.deleteReview
	{
		display: inline-block;
		width: 50px;
		height: 20px;
		background-color: red;
		text-align: center;
		font-size: 12px;
		border-radius: 5px;
	}
	
	.writeTitle > h2, .editTitle
	{
		width: 360px;
		text-align: center;
		color: #6998ab;
		margin-top: 30px;
		margin-bottom: 20px;
	}
	
	.writeBar
	{
		position: relative;
		top: 50px;
		z-index: -1;
	}
	
	.redText
	{
		color: #ccc;
		text-align: center;
		margin-bottom: 30px;
	}
	
</style>
</head>
<body>

	<jsp:include page="../nav.jsp" flush="false"></jsp:include>
	<div class="container" id="backgroundCon"></div>
	<div id="backgroundCon2"></div>
	<div class="divCon">
		<div id="placeTitleDiv">
			<div class="placeTitleDiv">
				<h1 id="placeTitle"><%= place.getPlaceName() %></h1>
				<p> <button id="wishBtn" type="button" onclick="saveWishList()">WishList + </button> </p>
			</div>
			<hr>
		</div>
		<div id="map"></div>
		<div id="placeStatus">
				<div id="kakaoStatus">
					<div class="placeStatusItag">
						<span class="iTag"><i class="fa-solid fa-tags"></i></span><p><%= place.getCategoryAll() %></p>
					</div>
					<div class="placeStatusItag">
						<span class="iTag"><i class="fa-solid fa-location-dot"></i></span><p><%= place.getAddressName() %></p>
					</div>
					<div class="placeStatusItag">
						<span class="iTag"></span><p><%= place.getRoadAddress() %></p>
					</div>
					<div class="placeStatusItag">
						<span class="iTag"><i class="fa-solid fa-phone"></i></span><p><%= place.getPhone() %></p>
					</div>
					
					<button type="button" id="openModal">카카오 정보 페이지 보기</button>
				</div>
		</div>
	</div>
	<div class="reviewCon">

		<div id="reviewCon">
			<div class="slider">
				<div id="review-container"></div>
			</div>
			
			<div id="review-write">
				<div class="writeTitle">
					<h2>시설에 대한 의견을 남겨보세요!</h2>
				</div>
				<div class="centerDiv">
					<%
						HttpSession session = request.getSession(false);
						
						if(session != null){
							Member member = (Member)session.getAttribute("userStatus");
							
							if(member != null){
								
					%>
						<form id="review-form" method="post">
							<textarea name="reviewText" id="reviewText" ></textarea> <button type="button" id="submitButton">작성하기</button>
						</form>
					<%
							} else {
					%>
							<p class="redText">-- 로그인 후 작성이 가능합니다 --</p>
					<%
							}
						} else {
					%>
							<p class="redText">-- 로그인 후 작성이 가능합니다 --</p>
					<%	
						}
					%>
				</div>
			</div>
		</div>

	</div>

    <!-- 모달 구조 -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <iframe id="modalIframe" src="" frameborder="0"></iframe>
        </div>
    </div>
    
    <!-- 리뷰모달 -->
	<div id="editReviewModal" class="modal">
	    <div class="modal-content">
	        <span class="close">&times;</span>
	        <h2 class="editTitle">리뷰 수정</h2>
	        <textarea id="editReviewText" rows="4" cols="50"></textarea>
	        <button id="saveChanges">수정</button>
	    </div>
	</div>
    
<script type="text/javascript">
	var placeName = '<%= place.getPlaceName() %>';
	var targetId = '<%= place.getPlaceID() %>';
	var x = "<%= place.getLongitude() %>";
	var y = "<%= place.getLatitude() %>";
    var kakaoInfoUrl = "<%= place.getPlaceUrl() %>";
    var placeCategory = "<%= place.getCategory() %>";
</script>

<script src="/howAbout/resources/js/onePlace.js"> </script>
<script type="text/javascript">

	function saveWishList(){
		
		$.ajax({
            url: '/howAbout/wish/myPlace',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                "placeID": targetId
            }),
            success: function(response) {
            	if(response.result){
            		alert('저장되었습니다.');
            	} else {
            		alert('이미 저장된 시설입니다.');
            	}
                
            },
            error: function(xhr, status, error) {
                alert('에러');
            }
        });
		
		
	}

	$(document).ready(function() {
	    $('#submitButton').on('click', function() {
	        const reviewText = $('#reviewText').val();
	
	        $.ajax({
	            url: '/howAbout/review/addReview',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({
	                "reviewText": reviewText,
	                "placeID": targetId
	            }),
	            success: function(response) {
	                alert('리뷰가 성공적으로 작성되었습니다.');
	                location.reload(); // 페이지 리로드
	            },
	            error: function(xhr, status, error) {
	                alert('리뷰 작성에 실패했습니다.');
	            }
	        });
	    });

	});
	
	
	
	
</script>
</body>
</html>