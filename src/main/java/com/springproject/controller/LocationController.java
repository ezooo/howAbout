package com.springproject.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;
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
		return "location/locationPreview";
	}
	
	@RequestMapping("/addapi")
	public String addLocationAPI()
	{
		System.out.println("LocationController /addapi 매핑");
		System.out.println("API 받아와서 로케이션 저장하기");
		
		//api 요청 할 주소
		String apiUrl = "http://apis.data.go.kr/6480000/gyeongnamtournature/gyeongnamtournaturelist?"
			+ "serviceKey=axdk7ixVxHHdRzI6x1lL6%2FCGVvu%2BsCRNby2Z9thO7g6TdPJCowoZhR0q4PDgM59dCD9YX5EcHqKp0T%2BcSJoNXw%3D%3D&numOfRows=50&pageNo=1&resultType=json"; // 호출할 API URL
			    
		try 
	    {
			System.out.println("서버와 연결 try in");
	        URL url = new URL(apiUrl);
	        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	        connection.setRequestMethod("GET");
	        BufferedReader br;

	        int responseCode = connection.getResponseCode();
	        if (responseCode == 200) //HttpURLConnection.HTTP_OK 써도 됨
	        {
	        	System.out.println("정상적인 응답코드 200 확인 완료. 데이터를 읽어오자");
	            br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
	            
	            String inputLine;
	            StringBuffer response = new StringBuffer();	//json
	            
	            while((inputLine = br.readLine()) != null) 
	            {	
	            	response.append(inputLine);
	            }
	            br.close();
	            System.out.println("작성완료");

	            JSONTokener tokener = new JSONTokener(response.toString());
	            JSONObject json = new JSONObject(tokener);
	            JSONObject gyeongnam = json.getJSONObject("gyeongnamtournaturelist");
	            System.out.println(gyeongnam);
	            JSONObject body = gyeongnam.getJSONObject("body");
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
	            	//중복데이터는 받아오지 않도록 처리하기 위해 if문
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
	            	locationService.addLocationAPI(location);
	            }
	            System.out.println("로케이션 꺼내기 완료 !");
	        } 
	        else 
	        {
	            System.out.println("GET 요청 실패: " + responseCode);
	        }
	    } 
		catch (Exception e) 
		{
	        e.printStackTrace();
	    }
		
		System.out.println("로케이션 저장완료");
		return "redirect:/";
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
			model.addAttribute("areaList",areaList);
			return "location/locationArea";
		}
		System.out.println("getAllArea 카테고리 분류 fail...");
		return "location/errorLocation";
	}
	
	@GetMapping("/area/{area}")
	public String getLocationOfArea(@PathVariable String area, Model model)
	{
		List<Location> locationOfArea = locationService.getLocationOfArea(area);
		model.addAttribute("locationOfArea", locationOfArea);
		model.addAttribute(area);
		return "location/locationOfArea";
	}
	
	@GetMapping("/create")
	public String createLocation(@ModelAttribute Location location)
	{		
		return "location/createLocation";
	}
	
	@PostMapping("/create")
	public String submitCreateLocation(Location location)
	{
		System.out.println("LocationController submitCreateLocation in");
		locationService.createLocation(location);
		
		return "redirect:/location";
	}

	@GetMapping("/update")
	public String updateLocation(@RequestParam("lat") String lat, @RequestParam("log") String log, Model model)
	{
		System.out.println("LocationController updateLocation in : 폼으로 이동");
		String[] find = {lat, log};
		Location location = locationService.findLocation(find);
		if(location != null)
		{
			model.addAttribute("location",location);	
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
		return "redirect:/location/onelocation/"+num ;
	}

	@GetMapping("/delete")
	public String deleteLocation(@RequestParam("lat") String lat, @RequestParam("log") String log)
	{
		System.out.println("LocationController deleteLocation in");
		locationService.deleteLocation(lat, log);
		System.out.println("로케이션 삭제 완료");
		return "redirect:/location";
	}

	@GetMapping("/findLocation")
	@ResponseBody
	public List<Location> findLocations(@RequestParam String title)
	{
		System.out.println("LocationController findLocations in");
		List<Location> find = locationService.findLocationByTitle(title);
		return find;
	}

	@PostMapping("/locationTitles")
	@ResponseBody
	public List<Location> getLocationTitles()
	{
		System.out.println("LocationController getLocationTitles in");
		List<Location> locationTitles = locationService.getAllLocation();

		return locationTitles;
	}
	
}
