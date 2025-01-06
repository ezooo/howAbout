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
<title>Location</title>
</head>
<body>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
<%
	ArrayList<Location> locations = (ArrayList<Location>)request.getAttribute("locations");
%>
저장된 로케이션 모두 보여주기  &nbsp;&nbsp;<span><a href="/howAbout/location/locationCategory">&raquo;전체 카테고리 보기</a></span>
					&nbsp;&nbsp;<span><a href="/howAbout/location/locationArea">&raquo;전체 지역 보기</a></span>
<hr><hr>
<%
	for(Location lt : locations)
	{
%>
<%	//String title = URLEncoder.encode(lt.getData_title(),"UTF-8").replace("+", "%20");	//한글을 파라미터로 주기 위해 인코딩 %>
<p><a href="/howAbout/location/onelocation/<%= lt.getNum() %>"> <%= lt.getData_title() %> </a></p>
<img alt="image" src="<%= lt.getFileurl1() %>" />
<hr>
<%
	}
%>
</body>
</html>