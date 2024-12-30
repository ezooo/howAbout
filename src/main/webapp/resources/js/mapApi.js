var region_btns = document.querySelectorAll('.region');

region_btns.forEach(function(btn) {
    btn.addEventListener('click', function() {
		
		var region_text = $(this).text();
		let serch_text = "경상남도 "+ region_text+" 맛집";
		searchPlaces(serch_text);
		
    });
});

function searchPlaces(keyword) {
    for (let page = 1; page <= 3; page++) {
        setTimeout(() => {
            ps.keywordSearch(keyword, (data, status) => {
                placesSearchCB(data, status, page, keyword);
            }, {
                page: page
            });
        }, (page - 1) * 700);
    }
}

function placesSearchCB(data, status, page, keyword) {

    if (status === kakao.maps.services.Status.OK) {
        if (Array.isArray(data) && data.length > 0) {
            var placeData = data.map(place => ({
            	place_name: place.place_name,
                address_name: place.address_name,
                road_address_name : place.road_address_name,
                phone: place.phone,
                y: place.y,
                x: place.x,
                place_url: place.place_url,
                category_group_name: place.category_group_name,
                category_name: place.category_name,
                id: place.id,
				key: keyword
            }));
			
            sendToController(placeData);
        } else {
            alert('검색 결과가 존재하지 않습니다.');
        }
    } else {
        alert('검색 중 오류가 발생했습니다.');
    }
}

	function sendToController(placeData) {
			
		$.ajax({
			url: '/howAbout/place/kakaoMapconn', // 서버의 컨트롤러 URL로 변경
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(placeData),
			success: function(response) {
				places = response.list;
				displayResults();
				setupPagination();
			},
			error: function(xhr, status, error) {
				console.error('AJAX 오류:', error);
			}
		});
	}
	
	function displayResults() {
	    var resultsDiv = document.getElementById('results');
	    resultsDiv.innerHTML = ''; // 이전 결과 초기화

		const start = (currentPage - 1) * pageSize;
		const end = start + pageSize;
		const paginatedPlaces = places.slice(start, end);

		paginatedPlaces.forEach(place => {
		    const placeEl = document.querySelector('#list');
		    placeEl.innerHTML =
		        "<h2><a href='/howAbout/place/newGetOne/placeID/"+place.id+"'>"+place.place_name+"</a></h2> <p>주소: "+place.address_name+"</p><p>전화번호: "+place.phone+"</p><p><a href='"+place.place_url+"' target='_blank'>카카오맵에서 보기</a></p><hr />";
		    resultsDiv.appendChild(placeEl);
		});
	}

	function setupPagination() {
	    const totalPages = Math.ceil(places.length / pageSize);
	    const paginationDiv = document.getElementById('pagination');
	    paginationDiv.innerHTML = ''; // 이전 페이지네이션 초기화

	    for (let i = 1; i <= totalPages; i++) {
	        const pageLink = document.createElement('a');
			pageLink.className = 'pageNum';
	        pageLink.innerText = i;
	        pageLink.href = '#';
	        pageLink.onclick = function() {
	            currentPage = i;
	            displayResults();
	        };
	        paginationDiv.appendChild(pageLink);
	    }
	}