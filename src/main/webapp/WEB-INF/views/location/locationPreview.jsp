<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로케이션... 임시페이지</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>
.noto-sans-kr-<uniquifier> {
	  font-family: "Noto Sans KR", serif;
	  font-optical-sizing: auto;
	  font-weight: <weight>;
	  font-style: normal;
	}
*{
	margin : 0 auto;
	padding : 0px;
	box-sizing: border-box;
	text-decoration: none;
}
body{
	width : 100%;
}

	#gyugnamMap
	{
		position: relative;
		width: 800px;
		height: 800px;
		background-color: transparent;
		background-image: url('/howAbout/resources/img/map/2_전체지도.png');
		background-size: cover;
	    background-position: center;
	    background-repeat: no-repeat;
	}
	
	.region
	{
		position: absolute;
		background-color: transparent;
		z-index: 3;
	    font-family: 'NPSfontBold';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2310@1.0/NPSfontBold.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
	    font-size: 20px;
	    color: white;
	}
	
	.region_img
	{
		position: absolute;
		opacity: 0;
		z-index: 1;
		width: 800px;
		height: 800px;
		background-color: transparent;
		background-size: cover;
	    background-position: center;
	    background-repeat: no-repeat;
	}
	#region01
	{
		left: 460px;
		top: 600px;
		width: 100px;
		height: 130px;
		text-align: center;
		line-height: 130px;
	}
	
	#region02
	{
		left: 150px;
		top: 70px;
		width: 120px;
		height: 130px;
		text-align: center;
		line-height: 130px;
	}
	
	#region03
	{
		left: 290px;
		top: 500px;
		width: 120px;
		height: 110px;
		text-align: center;
		line-height: 110px;
	}
	
	#region04
	{
		left: 560px;
		top: 380px;
		width: 100px;
		height: 100px;
		text-align: center;
		line-height: 100px;
	}
	
	#region05
	{
		left: 140px;
		top: 610px;
		width: 100px;
		height: 100px;
		text-align: center;
		line-height: 100px;
	}
	
	#region06
	{
		left: 520px;
		top: 260px;
		width: 140px;
		height: 100px;
		text-align: center;
		line-height: 100px;
	}
	
	#region07
	{
		left: 180px;
		top: 450px;
		width: 120px;
		height: 110px;
		text-align: center;
		line-height: 110px;
	}
	
	#region08
	{
		left: 130px;
		top: 260px;
		width: 120px;
		height: 140px;
		text-align: center;
		line-height: 140px;
	}
	
	#region09
	{
		left: 650px;
		top: 310px;
		width: 100px;
		height: 100px;
		text-align: center;
		line-height: 100px;
	}
	
	#region10
	{
		left: 300px;
		top: 280px;
		width: 120px;
		height: 110px;
		text-align: center;
		line-height: 110px;
	}
	
	#region11
	{
		left: 220px;
		top: 380px;
		width: 140px;
		height: 110px;
		text-align: center;
		line-height: 110px;
	}
	
	#region12
	{
		left: 410px;
		top: 230px;
		width: 90px;
		height: 100px;
		text-align: center;
		line-height: 100px;
	}
	
	#region13
	{
		left: 420px;
		top: 410px;
		width: 130px;
		height: 90px;
		text-align: center;
		line-height: 90px;
	}
	
	#region14
	{
		left: 360px;
		top: 590px;
		width: 90px;
		height: 100px;
		text-align: center;
		line-height: 100px;
	}
	
	#region15
	{
		left: 90px;
		top: 400px;
		width: 90px;
		height: 120px;
		text-align: center;
		line-height: 120px;
	}
	
	#region16
	{
		left: 360px;
		top: 350px;
		width: 110px;
		height: 110px;
		text-align: center;
		line-height: 110px;
	}
	
	#region17
	{
		left: 70px;
		top: 150px;
		width: 90px;
		height: 150px;
		text-align: center;
		line-height: 150px;
	}
	
	#region18
	{
		left: 240px;
		top: 190px;
		width: 120px;
		height: 130px;
		text-align: center;
		line-height: 130px;
	}
	#region01_img { background-image: url('/howAbout/resources/img/map/거제시.png'); }
	#region02_img { background-image: url('/howAbout/resources/img/map/거창군.png'); }
	#region03_img { background-image: url('/howAbout/resources/img/map/고성군.png'); }
	#region04_img { background-image: url('/howAbout/resources/img/map/김해시.png'); }
	#region05_img { background-image: url('/howAbout/resources/img/map/남해군.png'); }
	#region06_img { background-image: url('/howAbout/resources/img/map/밀양시.png'); }
	#region07_img { background-image: url('/howAbout/resources/img/map/사천시.png'); }
	#region08_img { background-image: url('/howAbout/resources/img/map/산청군.png'); }
	#region09_img { background-image: url('/howAbout/resources/img/map/양산시.png'); }
	#region10_img { background-image: url('/howAbout/resources/img/map/의령군.png'); }
	#region11_img { background-image: url('/howAbout/resources/img/map/진주시.png'); }
	#region12_img { background-image: url('/howAbout/resources/img/map/창녕군.png'); }
	#region13_img { background-image: url('/howAbout/resources/img/map/창원시.png'); }
	#region14_img { background-image: url('/howAbout/resources/img/map/통영시.png'); }
	#region15_img { background-image: url('/howAbout/resources/img/map/하동군.png'); }
	#region16_img { background-image: url('/howAbout/resources/img/map/함안군.png'); }
	#region17_img { background-image: url('/howAbout/resources/img/map/함양군.png'); }
	#region18_img { background-image: url('/howAbout/resources/img/map/합천군.png'); }
	
	#region01:hover + #region01_img { opacity: 1; }
	#region02:hover + #region02_img { opacity: 1; }
	#region03:hover + #region03_img { opacity: 1; }
	#region04:hover + #region04_img { opacity: 1; }
	#region05:hover + #region05_img { opacity: 1; }
	#region06:hover + #region06_img { opacity: 1; }
	#region07:hover + #region07_img { opacity: 1; }
	#region08:hover + #region08_img { opacity: 1; }
	#region09:hover + #region09_img { opacity: 1; }
	#region10:hover + #region10_img { opacity: 1; }
	#region11:hover + #region11_img { opacity: 1; }
	#region12:hover + #region12_img { opacity: 1; }
	#region13:hover + #region13_img { opacity: 1; }
	#region14:hover + #region14_img { opacity: 1; }
	#region15:hover + #region15_img { opacity: 1; }
	#region16:hover + #region16_img { opacity: 1; }
	#region17:hover + #region17_img { opacity: 1; }
	#region18:hover + #region18_img { opacity: 1; }
	
	.wrapper
	{
		display: flex;
		justify-content: center;
		margin-top: 100px;
	}
</style>
</head>

<body>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
관광지를 찾아보세요 !
<a href="/howAbout/location/locations">전체 로케이션 보기</a>
<a href="/howAbout/location/locationCategory">카테고리 분류 보기</a>
<a href="/howAbout/location/locationArea">지역 분류 보기</a>
<a href="/howAbout/location/create">장소 추가</a>
<br><br>
 
	<button type="button" onclick="searchLocation()">클릭하고 여행지 찾기</button>
	<input type="text" id="searchLocation" placeholder="여행지 입력" style="display:none;"/>
<div id="results" ></div>
	<div class="wrapper">
		<div id="gyugnamMap">
			<div id="region01" class="region">거제시</div>
			<div id="region01_img" class="region_img"></div>
			
			<div id="region02" class="region">거창군</div>
			<div id="region02_img" class="region_img"></div>
			
			<div id="region03" class="region">고성군</div>
			<div id="region03_img" class="region_img"></div>
			
			<div id="region04" class="region">김해시</div>
			<div id="region04_img" class="region_img"></div>
			
			<div id="region05" class="region">남해군</div>
			<div id="region05_img" class="region_img"></div>
			
			<div id="region06" class="region">밀양시</div>
			<div id="region06_img" class="region_img"></div>
			
			<div id="region07" class="region">사천시</div>
			<div id="region07_img" class="region_img"></div>
			
			<div id="region08" class="region">산청군</div>
			<div id="region08_img" class="region_img"></div>
			
			<div id="region09" class="region">양산시</div>
			<div id="region09_img" class="region_img"></div>
			
			<div id="region10" class="region">의령군</div>
			<div id="region10_img" class="region_img"></div>
			
			<div id="region11" class="region">진주시</div>
			<div id="region11_img" class="region_img"></div>
			
			<div id="region12" class="region">창녕군</div>
			<div id="region12_img" class="region_img"></div>
			
			<div id="region13" class="region">창원시</div>
			<div id="region13_img" class="region_img"></div>
			
			<div id="region14" class="region">통영시</div>
			<div id="region14_img" class="region_img"></div>
			
			<div id="region15" class="region">하동군</div>
			<div id="region15_img" class="region_img"></div>
			
			<div id="region16" class="region">함안군</div>
			<div id="region16_img" class="region_img"></div>
			
			<div id="region17" class="region">함양군</div>
			<div id="region17_img" class="region_img"></div>
			
			<div id="region18" class="region">합천군</div>
			<div id="region18_img" class="region_img"></div>
		</div>
</body>

<script src="/howAbout/resources/js/locationAjax.js"></script>
<script type="text/javascript">
var region_btns = document.querySelectorAll('.region');
region_btns.forEach(function(btn) {
    btn.addEventListener('click', function() {
        // 클릭된 버튼의 텍스트를 가져옵니다.
        var region_text = $(this).text();
        
        // 텍스트의 두 글자를 잘라냅니다.
        var short_text = region_text.substring(0, 2);
        
     	// 새로운 URL로 리디렉션합니다.
        window.location.href = '/howAbout/location/area/' + encodeURIComponent(short_text);
    });
});
</script>
</html>