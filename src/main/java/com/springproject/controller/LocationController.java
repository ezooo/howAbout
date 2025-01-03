package com.springproject.controller;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springproject.domain.Location;
import com.springproject.domain.Member;
import com.springproject.service.LocationService;

@Controller
@RequestMapping("/location")
public class LocationController 
{
	@Autowired
	LocationService locationService;
	
	@RequestMapping
	public String locationin()
	{
		return "location/locationArea";
	}
	
	@RequestMapping("/addapi")
	public String addLocationAPI(HttpServletRequest request)	//관리자만 사용할 수 있도록 코드 수정
	{
		String sessionid;
		if(request.getSession(false) != null)
		{
			System.out.println("세션은 받아왔니..");
			sessionid = request.getSession(false).getId();
			if(sessionid != null)
			{	System.out.println("여기는 왔니..");
				Member mb = (Member) request.getSession(false).getAttribute("userStatus");
				if(mb !=  null && mb.getUserId().equals("admin"))
				{
					System.out.println("LocationController /addapi 매핑 성공");
					APIFileWriting afile = new APIFileWriting();
					//api 요청 할 주소
					String apiUrl = "http://apis.data.go.kr/6480000/gyeongnamtournature/gyeongnamtournaturelist?"
						+ "serviceKey=axdk7ixVxHHdRzI6x1lL6%2FCGVvu%2BsCRNby2Z9thO7g6TdPJCowoZhR0q4PDgM59dCD9YX5EcHqKp0T%2BcSJoNXw%3D%3D&numOfRows=50&pageNo=2&resultType=json"; // 호출할 API URL
						    
					try 
				    {
						System.out.println("로케이션 받아오기 - 서버와 연결 try in");
				        // URL 객체 생성
				        URL url = new URL(apiUrl);
			
			//	        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			//	        connection.setRequestMethod("GET"); // 요청 방식 설정
			//	        BufferedReader br;	//input을 읽어오기 위한 클래스
			//
			//	        int responseCode = connection.getResponseCode();
			//	        if (responseCode == 200) //HttpURLConnection.HTTP_OK 써도 됨
			//	        {
			//	        	System.out.println("정상적인 응답코드 200 확인 완료. 데이터를 읽어오자");
			//	            // 응답 데이터 읽기
			//	            br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
			//	            
			//	            String inputLine;
			//	            StringBuffer response = new StringBuffer();	//json
			//	            
			//	            while((inputLine = br.readLine()) != null) 
			//	            {	
			//	            	response.append(inputLine);
			//	            }
			//	            br.close();
			//	            System.out.println("작성완료");
			//
			//	            JSONTokener tokener = new JSONTokener(response.toString());	//json
			//	            JSONObject json = new JSONObject(tokener);	
				        	JSONObject json = afile.returnJson(url);
				            JSONObject gyeongnam = json.getJSONObject("gyeongnamtournaturelist");	// json 객체에서 키로 경남꺼내기
				            System.out.println(gyeongnam);
				            JSONObject body = gyeongnam.getJSONObject("body");	//바디 객체 꺼내기
				            System.out.println("바디꺼냄 : "+body.toString());
				            JSONObject items = body.getJSONObject("items");
				            JSONArray item = items.getJSONArray("item");
				            
				            for(int i=0; i<item.length(); i++)
				            {
				            	JSONObject location = item.getJSONObject(i);
				            	System.out.println("location "+i+"번째 꺼냄 : "+location);
				            	
				            	//주소 가공하기
				            	String jsonaddr = location.getString("user_address");
				            	//이걸 함수에 실어보내서 api 요청함 --> 가공된 주소와 위도경도 받아오기
				            	String[] contents = locationService.getAPIContents(jsonaddr);
				            	if(contents!=null && contents.length!=0)
				            	{
				            		location.put("user_address", contents[0]);
				            		location.put("lattitude", contents[1]);
				            		location.put("logitude", contents[2]);
				            	}
				            	
				            	//중복데이터는 받아오지 않도록 처리하기 위해 if문 돌릴건데
				            	//방금 꺼낸 데이터랑 db 저장된 데이터 비교해야하므로 db 검색 함수 추가해야 함
				            	//data_title 만 가져와서 비교하도록 설정하기 String List 받아야 함
				            	List<String> titleList = locationService.getAlltitle();
				            	List<String> addrList = locationService.getAlladdr(); 	
				            	
				            	if(titleList.contains(location.getString("data_title")))
				            	{
				            		System.out.println("addLocationAPI 같은 이름 발견..");
				            		if(addrList.contains(location.getString("user_address")))
				            		{
				            			System.out.println("addLocationAPI 주소도 같음 중복 !! ");
				            			continue;
				            		}
				            	}
				            	System.out.println("장소이름은 : "+location.getString("data_title"));
				            	System.out.println("주소는 : "+location.getString("user_address"));
				            	
				            	locationService.addLocationAPI(location);
				            }
				            System.out.println("로케이션 꺼내기 완료 !");
			//	        } 
			//	        else 
			//	        {
			//	            System.out.println("GET 요청 실패: " + responseCode);
			//	        }
				    } 
					catch (Exception e) 
					{
				        e.printStackTrace();
				    }
					
					System.out.println("로케이션 저장완료");
				}
				else
				{
					System.out.println("로케이션 api 호출 권한이 없습니다. 실패 !");
				}
			}
		}
		return "redirect:/location";
	}

	@GetMapping("/locations")
	public String getAllLocation(Model model)
	{
		System.out.println("LocationController getAllLocation in");
		List<Location> locations = locationService.getAllLocation();
		
		if( !(locations.isEmpty()) )
		{
			model.addAttribute("locations", locations);
			
			return "location/locations";
		}
		return "location/errorLocation";
	}

	@GetMapping("/onelocation/{num}")
	public String getOneLocation(@PathVariable int num, Model model)
	{
		System.out.println("LocationController getOneLocation in");
		Location location = locationService.getOneLocation(num);
		if(location != null)
		{
			System.out.println("이름으로 장소찾기 완료 ! 뷰 페이지 반환합니다.");
			model.addAttribute("location",location);
			return "location/location";			
		}
		System.out.println("장소찾기 실패.. ");
		return "location/errorLocation";
	}

	
	@GetMapping("/category/{category}")
	public String getLocationOfCategory(@PathVariable String category, Model model)
	{
		System.out.println("LocationController getLocationCategory in");
		ArrayList<Location> locations = (ArrayList<Location>) locationService.getLocationOfCategory(category);
		if(locations != null)
		{
			System.out.println("로케이션 카테고리 찾기 성공 !");
			model.addAttribute("locations",locations);
			model.addAttribute("category", category);
			return "location/locationOfcategory";
		}
		System.out.println("로케이션 카테고리 못 찾음...");
		return "location/errorLocation";
	}

	@GetMapping("/locationCategory")
	public String getAllCategory(Model model)
	{
		System.out.println("LocationController getAllCategory in");
		ArrayList<Location> categoryList = (ArrayList<Location>) locationService.getAllCategory();
		if(categoryList != null)
		{
			System.out.println("getAllCategory 카테고리 분류 성공 !");
			model.addAttribute("categoryList",categoryList);
			return "location/locationCategory";
		}
		System.out.println("getAllCategory 카테고리 분류 fail...");
		return "location/errorLocation";
	}

	@GetMapping("/locationArea")
	public String getAllArea(Model model)
	{
		System.out.println("LocationController getAllArea in");
		ArrayList<String> areaList = (ArrayList<String>) locationService.getAllArea();
		if(areaList != null)
		{
			System.out.println("getAllArea 카테고리 분류 성공 !");
			model.addAttribute("areaList",areaList);
			return "location/locationArea";
		}
		System.out.println("getAllArea 카테고리 분류 fail...");
		return "location/errorLocation";
	}
	
	@GetMapping("/area/{area}")
	public String getLocationOfArea(@PathVariable String area, Model model)
	{
		System.out.println("LocationController getLocationOfArea in");
		List<Location> locationOfArea = locationService.getLocationOfArea(area);
		model.addAttribute("locationOfArea", locationOfArea);
		model.addAttribute(area);
		return "location/locationOfArea";
	}
	
	@GetMapping("/create")
	public String createLocation(@ModelAttribute Location location)
	{
		System.out.println("장소 추가하기 뷰 이동");
		
		return "location/addLocation";
	}
	
	@PostMapping("/create")
	public String submitCreateLocation(Location location)
	{
		System.out.println("LocationController submitCreateLocation in");
		locationService.createLocation(location);
		
		return "redirect:/location";
	}

	@GetMapping("/update")
	public String updateLocation(@RequestParam("num") int num, Model model)
	{
		System.out.println("LocationController updateLocation in : 폼으로 이동");
		//String[] find = {lat, log};
		Location location = locationService.getOneLocation(num);
		//int num = location.getNum();
		if(location != null)
		{
			model.addAttribute("location",location);
			//model.addAttribute("num", location.getNum());	//primary key 인 num값은 수정할 수 없도록 하기위해서 따로 담아서 이동
			
			return "location/updateLocation";
		}
		return "location/errorLocation";
	}
	
	@PostMapping("/update")
	public String submitUpdateLocation(@ModelAttribute Location location, Model model)
	{
		System.out.println("LocationController submitUpdateLocation in");

		int num = location.getNum();
		locationService.submitUpdateLocation(location);
		System.out.println("LocationController submitUpdateLocation 수정완료");
		//return "redirect:/location/onelocation/"+title2 ;
		return "redirect:/location/onelocation/"+num ;
	}

	@GetMapping("/delete")
	public String deleteLocation(@RequestParam("num") int num)
	{
		System.out.println("LocationController deleteLocation in");
		locationService.deleteLocation(num);
		System.out.println("로케이션 삭제 완료");
		return "redirect:/location";
	}

	@GetMapping("/findLocation")
	@ResponseBody
	public List<Location> findLocations(@RequestParam String title)
	{
		System.out.println("LocationController findLocations in");
		List<Location> find = locationService.findLocationByTitle(title);
		System.out.println(find + " 찾아옴");
		return find;
	}

	
	@PostMapping("/locationTitles")
	@ResponseBody	//json 형식으로 응답하기 위한 코드
	public List<Location> getLocationTitles()
	{
		System.out.println("LocationController getLocationTitles in");
		List<Location> locationTitles = locationService.getAllLocation();

		return locationTitles;
	}
	
	@PostMapping("/searchOneLocation/{title}/{address}")
	@ResponseBody
	public Integer searchOneLocation(@PathVariable("title") String title, @PathVariable("address") String address)
	{
		System.out.println("LocationController searchOneLocation in");
		System.out.println("받아온 파라미터 title : " + title);
		System.out.println("받아온 파라미터 address : " + address);

		int num = locationService.searchOneLocationNum(title, address);
		return num;
	}
}
