<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.springproject.domain.Location"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역 분류 보여주기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<style type="text/css">
@font-face {
   font-family: 'Pretendard-Regular';
   src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
   font-weight: 400;
   font-style: normal;
}

*{
	margin : 0 auto;
	padding : 0px;
	box-sizing: border-box;
}

body {
    
    margin: 0;
    padding: 20px;
    background-image: url('/howAbout/resources/images/back2.png');
    background-position: center; /* 중앙에 위치 */
    background-repeat: no-repeat; /* 반복하지 않음 */
    background-size: cover;
}

.category-header {
    font-size: 24px;
    margin-bottom: 20px;
    font-family: 'Pretendard-Regular';
    font-weight : 900;
    font-style: bold;
}
</style>

</head>
<body>
<%@ include file="main.jsp" %>
<%
	ArrayList<String> areaList = (ArrayList<String>)request.getAttribute("areaList");
%>
<div class="category-header">
지역별 여행지 
<span>&nbsp;&nbsp;<a href="/howAbout/location/locationCategory">&raquo;카테고리별 여행지 보기</a></span>
 </div>
<hr>
<div class="container">
<%
if(areaList != null)
{
	for(String areaname : areaList)
	{
		String area = URLEncoder.encode(areaname, "UTF-8");
%>
<div>
<p><a href="/howAbout/location/area/<%= area %>"> <%= areaname %> </a></p>
</div>
<%
	}
}
%>
</div>
</body>
</html>