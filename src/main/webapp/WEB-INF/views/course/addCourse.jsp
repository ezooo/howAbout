<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.springproject.domain.Location"%>
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
<title>코스 등록</title>
</head>
<style>
#selectionForm {
    display: none; /* 기본적으로 숨김 */
}

.noto-sans-kr-<uniquifier> {
	  font-family: "Noto Sans KR", serif;
	  font-optical-sizing: auto;
	  font-weight: <weight>;
	  font-style: normal;
	}
*{
	font-family: "Noto Sans KR", serif;
	font-style: none;
	text-decoration: none;
	font-weight : 500;
}
#main{
	background-color : #6998AB;
}
#main h1 {
	font-weight: 600;
}
</style>
<body>
<jsp:include page="../nav.jsp" flush="false"></jsp:include>
	<div class="container">
		<div class="py-5 text-center">
	     
	      <h2>Course add form</h2>
	      <p class="lead">추천 코스를 등록해 주세요.</p>
	    </div>
	    	
		<br><br>
		<div class="row g-5">
			<div class="col-md-7 col-lg-8">
				<form:form modelAttribute="NewCourse"
							action="./add"
				 class="needs-validation"
				 method="post">
				<div class="row g-3">
				<fieldset>
					<legend class="mb-3">추천 코스</legend>
					<div class="col-12">
						<label class="form-label">코스 이름</label>
						<div class="col-12">
							<form:input path="course_name" class="form-control"/>
						</div>
					</div>
					<div class="col-12">
						<label class="form-label">장소 이름</label>
						<div class="col-12 my-3">
							<input type="button" class="btn btn-secondary" style="width: 100px;" value="위치 추가" onclick="addInput()"/>
						</div>
						<div id="locationContainer" class="col-12">
							<div id="group0" class="locationGroup col-12 d-flex align-items-center my-3">
								<input type="button" class="btn btn-secondary" style="width: 150px;" value="위치 선택" onclick="openSelect(0)"/>
								<form:input path="location_names[0]" class="form-control col-md-12 mx-2" style="flex-grow: 1;" id="selectedLocation0"/>
								<input type="button" class="btn btn-secondary" style="width: 100px;" value="삭제" onclick="deleteSelect(0)"/>
							</div>		
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
		<div id="selectionForm" class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white">
	
			<input type="hidden" name="selectedLocation" id="selectedLocation"/>
		</div>
	
	</div>
	<%
	List<Location> locations = (List<Location>)request.getAttribute("locations");
	%>
<script>
	var currentIndex = null;
	var locationCount = 1;
	var contextPath = '${pageContext.request.contextPath}';
	function addInput(){
		var newDiv = document.createElement('div');
		newDiv.id='group'+locationCount;
		newDiv.className='locationGroup col-12 d-flex align-items-center my-3';
		console.log("locationCount : "+locationCount);
		newDiv.innerHTML = '<input type="button" class="btn btn-secondary" style="width: 150px;"  value="위치 선택" onclick="openSelect('+locationCount+')"/>' +
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