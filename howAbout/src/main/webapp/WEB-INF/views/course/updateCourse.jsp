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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>코스 수정</title>
	<style>
        #selectionForm {
            display: none; /* 기본적으로 숨김 */
        }
    </style>
</head>
<body>
	<div class="container">
		<header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
		      <a href="/" class="d-flex align-items-center col-md-3 mb-2 mb-md-0 text-dark text-decoration-none"></a>
		      <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
		        <li><a href="${pageContext.request.contextPath}" class="nav-link px-2 link-secondary">Home</a></li>
		        <li><a href="${pageContext.request.contextPath}/course" class="nav-link px-2 link-dark">Course</a></li>
		        <li><a href="${pageContext.request.contextPath}/festival" class="nav-link px-2 link-dark">Festival</a></li>
		        <li><a href="${pageContext.request.contextPath}/location" class="nav-link px-2 link-dark">Location</a></li>
		        <li><a href="${pageContext.request.contextPath}/schedule" class="nav-link px-2 link-dark">Schedule</a></li>
		        <li><a href="${pageContext.request.contextPath}/weather" class="nav-link px-2 link-dark">Weather</a></li>
		      </ul>
		</header>
	</div>
	
	<div class="container">
		<div class="py-5 text-center">
	     
	      <h2>Course update form</h2>
	      <p class="lead">추천 코스를 수정해 주세요.</p>
	    </div>
	
		<br><br>
		<div class="row g-5">
			<div class="col-md-7 col-lg-8">
				<form:form modelAttribute="updateCourse"
							action="./update"
				 class="needs-validation"
				 method="post">
				<div class="row g-3">
				<fieldset>
					<legend class="mb-3">추천 코스 수정</legend>
					<div class="col-12">
						<label class="form-label">코스 아이디</label>
						<div class="col-12">
							<form:input type="hidden" path="course_id" class="form-control" value="${course.course_id}"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">유저 아이디</label>
						<div class="col-sm-3">
							<form:input type="hidden" path="userId" class="form-control" value="${course.userId}"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">코스 이름</label>
						<div class="col-12">
							<form:input path="course_name" class="form-control" value="${course.course_name}"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">장소 이름</label>
						<div class="col-12 my-3">
							<input type="button" class="btn btn-secondary" value="위치 추가" onclick="addInput()"/>
						</div>
						<div id="locationContainer" class="col-12">
							<% Course course = (Course)request.getAttribute("course"); %>
							<% List<String> list = course.getLocation_names(); %>
							<% int index; %>
							<% for(int i = 0; i<list.size(); i++){ %>
								<% request.setAttribute("index", i); %>
								<div id="group${index}" class="locationGroup col-12 d-flex align-items-center my-3">
									<input type="button" class="btn btn-secondary"  style="width: 150px;" value="위치 선택" onclick="openSelect(${index})"/>
									<form:input path="location_names[${index}]" class="form-control col-md-12 mx-2" style="flex-grow: 1;" id="selectedLocation${index}" value="<%=list.get(i)%>"/>
									<input type="button" class="btn btn-secondary" style="width: 100px;" value="삭제" onclick="deleteSelect(${index})"/>
								</div>	
							<% } %>	
						</div>
					</div>
			
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10 my-3">
						<input type="submit" class="btn btn-primary" value="전송" />
						</div>
					</div>
				</fieldset>
				</div>
				</form:form>
			</div>
		</div>
	</div> 
	
	<div id="selectionForm"  class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white">
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
		newDiv.className='locationGroup col-12 d-flex align-items-center my-3';
		console.log("locationCount : "+locationCount);
		newDiv.innerHTML = '<input type="button" class="btn btn-secondary" style="width: 150px;" value="위치 선택" onclick="openSelect('+locationCount+')"/>' +
        '<input type="text" name="location_names[' + locationCount + ']" class="form-control col-md-12 mx-2" style="flex-grow: 1;" id="selectedLocation'+ locationCount +'"/>'+
        '<input type="button" class="btn btn-secondary" style="width: 100px;"  value="삭제" onclick="deleteSelect('+locationCount+')"/>';
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
		var selectData = document.getElementById('selectData');
		if(selectData!=null){
			console.log("selectData가 null이 아님")
			selectionForm.innerHTML = '';
		}
		locations.forEach(function(locations){
			var selectionDiv = document.createElement('div');
			selectionDiv.id = 'selectData';
			selectionDiv.innerHTML = '<div class="list-group-item list-group-item-action py-3 lh-tight" style="cursor: pointer; margin: 5px; padding: 10px; border: 1px solid #ccc;" ' +
		    'onclick="selectLocation(this, \'' + locations.data_title.replace(/'/g, "\\'") + '\')">' +
		    locations.data_title +
		    '</div>';
			document.getElementById('selectionForm').appendChild(selectionDiv);
		})
	}
	function openSelect(index){
		console.log("openSelect 실행");
		currentIndex = index;
		getSelectList();
		console.log("getselectList 실행하고왓음")
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
	function deleteSelect(index){
		currentIndex = index;
		document.getElementById('group'+currentIndex).remove();
		console.log("group"+currentIndex+"삭제함");
		if(locationCount==currentIndex){
			locationCount--;
		}
		if(locationCount>currentIndex){
			
		}
	}
</script>

</body>
</html>