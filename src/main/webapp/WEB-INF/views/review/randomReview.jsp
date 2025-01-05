<%@page import="com.springproject.domain.Place"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.springproject.domain.Review"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Yeseva+One&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/d75e97d418.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8ba5137fb1c2b1e37ac6722ae8d8e587&libraries=services"></script>
<style type="text/css">

	*
	{
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", serif;
	  		font-optical-sizing: auto;
	  		font-weight: <weight>;
	  		font-style: normal;
    }

	#backgroundCon
	{
		position: absolute;
		z-index: -3;
		width: 100%;
		height: 65vh;
		background-color: #6998ab;
	}
	
	#reviewCon
	{
		width: 1300px;
		height: 75vh;
		background-color: white;
		border-radius: 30px;
		padding-top: 165px;
	}
	
	.map-container
	{
		position: relative;
		width: 340px; /* 맵 이미지의 너비 */
		height: 290px; /* 맵 이미지의 높이 */
		margin-bottom: 20px;
		border-radius: 20px;
		overflow: hidden;
	}
	
	.mapwrap
	{
		position: relative;
		margin-bottom: 90px;
	}
	
	.kakaoMapDiv
	{
		position: absolute;
		border-radius: 20px;
		top: -50px;
	}
	
	.review-row
	{
		width: 1100px;
		height: 350px;
		display: flex;
		justify-content: space-around;
	}
	
	.placeName
	{
		position: absolute;
		left: 10px;
		top: -40px;
		z-index: 3;
		
	}
	
	.placeName > a
	{
		color: #2C3E50;
		font-size: 24px;
	}
	
	.reviewHoverDiv
	{
		width: 100%;
		height: 100%;
		position: absolute;
		left: 0;
		top: 120px;
		z-index: 2;
		background-color: rgb(44,62,80);
		overflow: hidden;
	}
	
	.userId
	{
		width: 200px;
		height: 50px;
		line-height: 50px;
		background-color: rgb(44,62,80);
		left: 0;
		border-top-right-radius: 30px;
	}
	
	.userId, .userReview
	{
		position: absolute;
		z-index: 4;
		top: 80px;
		padding-left: 20px;
		font-size: 24px;
		font-weight: 600;
		color: white;
	}
	
	.userReview
	{
		top: 120px;
		font-size: 14px;
		font-weight: 400;
	}
	
	.comment
	{	
		position: absolute;
		top: 20px;
		left: 20px;
		z-index: 3;
		color: rgba(0,0,0,0.1);
	}
	
	.userReviewText
	{
		width: 80%;
		position: absolute;
		left: 20px;
		top: 160px;
		z-index: 4;
		color: #FFF5E1;
		font-size: 18px;
		font-weight: 500;
	}
	
    .header
    {
      width: 100%;
      position: absolute;
      text-align: center;
      top: 80px;
      left: 50%;
      transform : translateX(-50%);
      z-index: 10;
    }
    
	.header h2
	{
	   font-family: "Noto Sans KR", serif;
	   font-size: 30px;
	   padding-bottom: 10px;
	}
	 
	.header p
	{
	   font-family: "Noto Sans KR", serif;
	   font-size: 14px;
	}
	
</style>
</head>
<body>
	<jsp:include page="../nav.jsp" flush="false"></jsp:include>
	<div class="container-fluid" id="backgroundCon"></div>
	
	<div class="header">
		<h2>Review</h2>
		<p> 회원님들이 남겨주신 소중한 리뷰를 확인해보세요 ! </p>
	</div>
	
	<div id="reviewCon">

	
	<%
    	List<Review> list = (List<Review>) request.getAttribute("list");
		List<Place> placeList = (ArrayList<Place>)request.getAttribute("placeList");

    	if (list != null && !list.isEmpty()) {
	%>
        <div class="review-container">
            <%
                int totalReviews = list.size();
                for (int i = 0; i < totalReviews; i++) {
                	
                	String review = list.get(i).getReviewText();
                	
                	if(review.length() > 70){ review = review.substring(0, 70) + "..."; }

                    if (i % 3 == 0) {
            %>
                <div class="review-row">
            <%
                    }
            %>
                <div class="review-item">
	                <div class="mapwrap">
		                <h2 class="placeName"> <a href="/howAbout/place/newGetOne/placeID/<%= placeList.get(i).getPlaceID()%>"> <%= placeList.get(i).getPlaceName() %> </a></h2>
	                	<div class="map-container" data-lat="<%= placeList.get(i).getLatitude() %>" data-lng="<%= placeList.get(i).getLongitude() %>">
	                    	<p class="userId"><%= list.get(i).getUserId() %></p>
	                    	<p class="userReview">회원님의 리뷰</p>
	                    	<p class="userReviewText"><%= review %></p>
	
		                    <div class="reviewHoverDiv">
			                    <div class="comment">
		                    		<svg xmlns="http://www.w3.org/2000/svg" width="130" height="130" fill="currentColor" class="bi bi-chat-left-dots-fill" viewBox="0 0 16 16">
									  <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H4.414a1 1 0 0 0-.707.293L.854 15.146A.5.5 0 0 1 0 14.793zm5 4a1 1 0 1 0-2 0 1 1 0 0 0 2 0m4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
									</svg>
		                    	</div>
		                   
		                    </div>
	                	</div>
	                </div>
                </div>
            <%
                    // 3개가 끝나면 닫는 div
                    if (i % 3 == 2 || i == totalReviews - 1) {
            %>
                </div> <!-- review-row 닫기 -->
            <%
                    }
                }
            %>
        </div> <!-- review-container 닫기 -->
<%
    } else {
%>
        <p>리뷰가 없습니다.</p>
<%
    }
%>
	
	</div>
</body>
<script type="text/javascript">

	//모든 맵 컨테이너 가져오기
	const mapContainers = document.querySelectorAll('.map-container');
	
	// 각 컨테이너에 대해 카카오 맵을 생성
	mapContainers.forEach(function(container) {
	    const latitude = parseFloat(container.getAttribute('data-lat'));
	    const longitude = parseFloat(container.getAttribute('data-lng'));
	
	    // 카카오 맵 생성
	    const mapContainer = document.createElement('div');
	    mapContainer.className = 'kakaoMapDiv';
	    mapContainer.style.width = '100%';
	    mapContainer.style.height = '100%';
	
	    container.appendChild(mapContainer);
	
	    const options = {
	        center: new kakao.maps.LatLng(latitude, longitude),
	        level: 3
	    };
	
	    const map = new kakao.maps.Map(mapContainer, options);
	
	    // 마커 추가
	    const markerPosition = new kakao.maps.LatLng(latitude, longitude);
	    const marker = new kakao.maps.Marker({
	        position: markerPosition
	    });
	
	    marker.setMap(map);
	});
	
</script>
</html>