<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.springproject.domain.Location"%>
<%@ page import="com.springproject.domain.Course"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>코스 수정</title>
	<style>
        #selectionForm {
            display: none; /* 기본적으로 숨김 */
        }
    </style>
</head>
<body>
 	<nav class="navbar navbar-expand navbar-dark bg-dark">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="./">Home</a>
			</div>
		</div>
	</nav>
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">
			TITLE
			</h1>
		</div>
	</div> 
	
		<!-- <div class="float-right">
			<form:form action="${pageContext.request.contextPath}/logout" method="POST">
				<input type="submit" class="btn btn-sm btn-success" value="Logout" />
			</form:form>
		</div> 
		
		 -->
		<br><br>
		<form:form modelAttribute="updateCourse"
					action="./update"
		 class="form-horizontal"
		 method="post">
		<fieldset>
		<legend>subtitle</legend>
		
		<div class="form-group row">
			<label class="col-sm-2 control-label"> course_id</label>
			<div class="col-sm-3">
				<form:input type="hidden" path="course_id" class="form-control" value="${course.course_id}"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label"> user_id</label>
			<div class="col-sm-3">
				<form:input type="hidden" path="userId" class="form-control" value="${course.userId}"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">course_name</label>
			<div class="col-sm-3">
				<form:input path="course_name" class="form-control" value="${course.course_name}"/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2 control-label">location_name</label>
			<div id="locationContainer" class="col-sm-3">
				<% Course course = (Course)request.getAttribute("course"); %>
				<% List<String> list = course.getLocation_names(); %>
				<% int index; %>
				<% for(int i = 0; i<list.size(); i++){ %>
					<% request.setAttribute("index", i); %>
					<div class="locationGroup">
						<input type="button" class="btn btn-secondary" value="위치 선택" onclick="openSelect(${index})"/>
						<form:input path="location_names[${index}]" class="form-control"  id="selectedLocation${index}" value="<%=list.get(i)%>"/>
					</div>	
				<% } %>	
			</div>
			<div>
				<input type="button" class="btn btn-secondary" value="위치 추가" onclick="addInput()"/>
			</div>
		</div>

		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
			<input type="submit" class="btn btn-primary" value="전송" />
			</div>
		</div>
		</fieldset>
		</form:form>
	<div id="selectionForm">
			<c:if test="${empty sessionScope.locations}">
        		<p>위치가 없습니다.</p> <!-- 위치가 없을 때 메시지 -->
    		</c:if>
		<c:forEach var="location" items="${sessionScope.locations}">
			<div style="cursor: pointer; margin: 5px; padding: 10px; border: 1px solid #ccc;"
			 onclick="selectLocation(this,'${location.data_title}')">
			${location.data_title}
			</div>
		</c:forEach>
		<input type="hidden" name="selectedLocation" id="selectedLocation"/>
	</div>
	<%
	List<Location> locations = (List<Location>)request.getAttribute("locations");
	%>
<script>
	var currentIndex = null;
	var locationCount = ${fn:length(course.location_names)};
	var contextPath = '${pageContext.request.contextPath}';
	function addInput(){
		var newDiv = document.createElement('div');
		console.log("locationCount : "+locationCount);
		newDiv.innerHTML = '<input type="button" class="btn btn-secondary" value="위치 선택" onclick="openSelect('+locationCount+')"/>' +
        '<input type="text" name="location_names[' + locationCount + ']" class="form-control" id="selectedLocation'+ locationCount +'"/>';

		document.getElementById('locationContainer').appendChild(newDiv);
		locationCount++;
	}
	function getSelectList(){
		$.ajax({
			url : '${pageContext.request.contextPath}/course/selectLocation',
			type : 'GET',
			dataType : "json",
			contentType : "application/json",
			success : function(response){
				console.log('Response:', response.locations);
				printSelectList(response.locations);
			},
			error : function(xhr, status, error){
				console.error('Status:', status);
		        console.error('Error:', error);
		        console.error('Response Text:', xhr.responseText);
		        console.error('Response Status:', xhr.status);
			}
		});
	}
	function printSelectList(locations){
		locations.forEach(function(locations){
			var selectionDiv = document.createElement('div');
			selectionDiv.innerHTML = '<div style="cursor: pointer; margin: 5px; padding: 10px; border: 1px solid #ccc;" ' +
		    'onclick="selectLocation(this, \'' + locations.data_title.replace(/'/g, "\\'") + '\')">' +
		    locations.data_title +
		    '</div>';
			document.getElementById('selectionForm').appendChild(selectionDiv);
		})
	}
	function openSelect(index){
		currentIndex = index;
		getSelectList();
		document.getElementById("selectionForm").style.display = "block";
	} 
	function closeSelect(){
		document.getElementById("selectionForm").style.display = "none";
	}
	
	function selectLocation(element,title){
		$.ajax({
			url : '${pageContext.request.contextPath}/course/selectReturn',
			type : 'POST',
			data : {selectedLocation: title},
			success : function(response){
				console.log(response);
			},
			error : function(error){
				
				console.error(error);
			}
		});	
		console.log(title);
		document.getElementById('selectedLocation'+ currentIndex).value=title;
		closeSelect();
	}
</script>

</body>
</html>