package com.springproject.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.springproject.domain.WeatherNow;
import com.springproject.domain.WeatherNowByDate;
import com.springproject.repository.WeatherCallNow;
import com.springproject.service.WeatherService;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import org.json.JSONArray;
import org.json.JSONObject;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mysql.cj.Session;
import com.springproject.domain.Member;
import com.springproject.domain.ThreeWeather;
import org.springframework.web.bind.annotation.PostMapping;
import com.springproject.domain.WeatherOfMidterm;




@RequestMapping("/weather")
@Controller
public class WeatherController {

	@Autowired
	WeatherService weatherService;
	@Autowired
	private WeatherCallNow weatherCallNow;
	@GetMapping
	public String mainPage() {
		return "Weather";
	}

	@GetMapping("/search")
	public String requestAddr(Model model) {
		System.out.println("requesAddr 입장");
		List<String> siList=weatherCallNow.getAddrInfo();
		System.out.println("siList 잘 넘어왔는지 확인 "+ siList);
		model.addAttribute("siList",siList);
		return "WeatherNow";
	}
	
	@GetMapping("/now")
	@ResponseBody
	public List<WeatherNowByDate> requestWeatherByDate(@RequestParam String selectSi,
										@RequestParam String selectDong,
										Model model, HttpSession session) throws Exception {
		System.out.println("requestWeatherByDate 입장");
		List<WeatherNow> weatherNowList = weatherCallNow.mainCall(selectSi, selectDong);
		List<WeatherNowByDate> weatherNowByDateList = weatherCallNow.getWeatherByDate(weatherNowList);
		model.addAttribute("weatherNowByDateList",weatherNowByDateList);
		session.setAttribute("weatherNowByDateList", weatherNowByDateList);
		for(int i=0;i<weatherNowByDateList.size();i++) {
			WeatherNowByDate oneWeather = weatherNowByDateList.get(i);
			System.out.println("하나씩 출력해 보기2 : "+oneWeather.getDate());
			System.out.println("하나씩 출력해 보기2 : "+oneWeather.getFcstDate());
			System.out.println("하나씩 출력해 보기2 : "+oneWeather.getPTY());
			System.out.println("하나씩 출력해 보기2 : "+oneWeather.getT1H());
			System.out.println("하나씩 출력해 보기2 : "+oneWeather.getRN1());
		}
		return weatherNowByDateList;
	}
	@GetMapping("/selectSi")
	@ResponseBody
	public List<String> requestDong(@RequestParam String selectSi){
		List<String> dongList = weatherCallNow.getDongInfo(selectSi);
		
		return dongList;
	}
	
	@GetMapping("/callNow")
	@ResponseBody
	public List<WeatherNowByDate> callWeatherNow(Model model, HttpSession session) throws Exception {
		System.out.println("callWeatherNow 입장");
		String userNx = "90";
		String userNy = "77";
		if(session != null) {
			Member user = (Member)session.getAttribute("userStatus");
			if(user != null) {
				userNx = String.valueOf(user.getNx());
				userNy = String.valueOf(user.getNy());
			}
		}
		List<WeatherNow> weatherNowList = weatherCallNow.mainCallByXY(userNx, userNy);
		
		List<WeatherNowByDate> weatherNowByDateList = weatherCallNow.getWeatherByDate(weatherNowList);
		model.addAttribute("weatherNowByDateList",weatherNowByDateList);
		session.setAttribute("weatherNowByDateList", weatherNowByDateList);
		for(int i=0;i<weatherNowByDateList.size();i++) {
			WeatherNowByDate oneWeather = weatherNowByDateList.get(i);
			System.out.println("하나씩 출력해 보기2 : "+oneWeather.getDate());
			System.out.println("하나씩 출력해 보기2 : "+oneWeather.getFcstDate());
			System.out.println("하나씩 출력해 보기2 : "+oneWeather.getPTY());
			System.out.println("하나씩 출력해 보기2 : "+oneWeather.getT1H());
			System.out.println("하나씩 출력해 보기2 : "+oneWeather.getRN1());
		}
		return weatherNowByDateList;
	}
	
	
	@ResponseBody
	@GetMapping("/callThree")
	public Map<String, ArrayList> wheather(HttpServletRequest req) throws IOException {
		
		HttpSession session = req.getSession(false);
		Map<String, ArrayList> data = new HashMap<String, ArrayList>();
		String userNx = "90";
		String userNy = "77";
		
		if(session != null) {
			Member user = (Member)session.getAttribute("userStatus");
			if(user != null) {
				userNx = String.valueOf(user.getNx());
				userNy = String.valueOf(user.getNy());
			}
		}
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		
        LocalDate today = null;
        
        LocalTime currentTime = LocalTime.now();
        LocalTime fiveAM = LocalTime.of(5, 0);
        
        if(currentTime.isAfter(fiveAM)) { today = LocalDate.now(); }
        else { today = LocalDate.now().minusDays(1); }
        
        String formattedDate = today.format(formatter);
        String one = (today.plusDays(1)).format(formatter);
        String two = (today.plusDays(2)).format(formatter);
        String three = (today.plusDays(3)).format(formatter);

        try {
        	
        	StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"); /*URL*/
        	
			urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=8a5yxDAXFyOyai1ZLcXy%2FdG0jSa2vqtKlUPxIBP1aELcn7jSpmLosDgAM%2BAVZJ8P2ELqQf8EejHNeyb3e5W3wQ%3D%3D");
			urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("1000", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON) Default: XML*/
	        urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(formattedDate, "UTF-8")); /*‘21년 6월 28일 발표*/
	        urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode("0500", "UTF-8")); /*오전 5시 발표*/
	        urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(userNx, "UTF-8")); /*예보지점 X 좌표값*/
	        urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(userNy, "UTF-8")); /*예보지점 Y 좌표값*/
	        URL url = new URL(urlBuilder.toString());
	        
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        
	        StringBuilder sb = new StringBuilder();
	        String line;
	        
	        while ((line = rd.readLine()) != null) { sb.append(line); }
	        
	        rd.close();
	        conn.disconnect();
	        
	        JSONObject json = new JSONObject(sb.toString());
	        JSONObject response = json.getJSONObject("response");
	        JSONObject body = response.getJSONObject("body");
	        JSONObject items = body.getJSONObject("items");
	        JSONArray item = items.getJSONArray("item");
	        
	        List<ThreeWeather> list = new ArrayList<ThreeWeather>();
	        ObjectMapper objectMapper = new ObjectMapper(); //JACKSON objectMapper 생성, 이게 있어야 파싱이 가능함
	        
	        for(int i=0; i<item.length(); i++) {
	        	
	        	JSONObject we = item.getJSONObject(i);
	        	String jsonString = we.toString(); //받아온 JSON객체를 문자열로 출력
	        	ThreeWeather whe = objectMapper.readValue(jsonString, ThreeWeather.class); //저장한 문자열을 객체에 파싱
	        	
	        	list.add(whe);
	        }
	        
	        ArrayList<ThreeWeather> listOne = new ArrayList<ThreeWeather>();
	        ArrayList<ThreeWeather> listTwo = new ArrayList<ThreeWeather>();
	        ArrayList<ThreeWeather> listThree = new ArrayList<ThreeWeather>();
	        
	        
	        for(int i=0; i<list.size(); i++) {
	        	ThreeWeather whe = list.get(i);
	        	
	        	if((whe.getFcstDate().equals(one))&&(whe.getCategory().equals("TMX")||whe.getCategory().equals("TMN"))) { listOne.add(whe); }
	        	if((whe.getFcstDate().equals(two))&&(whe.getCategory().equals("TMX")||whe.getCategory().equals("TMN"))) { listTwo.add(whe); }
	        	if((whe.getFcstDate().equals(three))&&(whe.getCategory().equals("TMX")||whe.getCategory().equals("TMN"))) { listThree.add(whe); }	
	        	
	        }
	        
	        data.put("one", listOne);
	        data.put("two", listTwo);
	        data.put("three", listThree);
	        
	        ThreeWeather sub = (ThreeWeather)data.get("three").get(0);
	        
	        System.out.println(sub.getFcstDate());
	        
		} catch (UnsupportedEncodingException e) { e.printStackTrace(); }
        
        return data;
        
	}
	
	@PostMapping("/callMidterm")
	@ResponseBody
	public WeatherOfMidterm callMidterm(HttpServletRequest request)
	{
		System.out.println("WeatherController callMidterm in");
		APIFileWriting afile = new APIFileWriting();	//모듈을 위한 클래스
		String clientKey = "axdk7ixVxHHdRzI6x1lL6%2FCGVvu%2BsCRNby2Z9thO7g6TdPJCowoZhR0q4PDgM59dCD9YX5EcHqKp0T%2BcSJoNXw%3D%3D";

		WeatherOfMidterm weather = new WeatherOfMidterm();	// 담을 객체
		
		String regId;	// 하늘 상태는 고정이라서 변수 쓸 필요 X
		String tt;
		String today;
		String baseDate;
		
		LocalTime sixAM = LocalTime.of(6, 0);		
		if(LocalTime.now().isAfter(sixAM))
		{
			// 현재 시간이 06시가 넘었으면 오늘 날짜로 api 호출 가능
			System.out.println("오전 6시 넘었다");
			tt = ""+LocalDate.now()+"";
		}
		else
		{
			// 현재 시간이 06시 안 넘었으면 받아올 수 없다 : 어제 날짜로 api 호출해야함
			System.out.println("오전 6시 안 넘었다. 어제날짜 호출");
			tt = ""+LocalDate.now().minusDays(1)+"";
		}
		today = tt.replaceAll("-", "");
		baseDate = today+"0600";

		// 중기 육상 예보 받아오기
		try 
		{
			 StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst"); /*URL*/
		     urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "="+clientKey); /*Service Key*/
		     urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
		     urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
		     urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식L*/
		     urlBuilder.append("&" + URLEncoder.encode("regId","UTF-8") + "=" + URLEncoder.encode("11H20000", "UTF-8")); //부산, 울산, 경상남도
		     urlBuilder.append("&" + URLEncoder.encode("tmFc","UTF-8") + "=" + URLEncoder.encode(baseDate, "UTF-8")); 
		     /*-일 2회(06:00,18:00)회 생성 되며 발표시각을 입력 YYYYMMDD0600(1800)-최근 24시간 자료만 제공*/
	        System.out.println("urlBuilder : "+urlBuilder);
	        
	        URL url = new URL(urlBuilder.toString());
	        
	        JSONObject json = afile.returnJson(url);

	        JSONObject response = json.getJSONObject("response");
	        JSONObject body = response.getJSONObject("body");
	        JSONObject items = body.getJSONObject("items");
	        JSONArray item = items.getJSONArray("item");
	        System.out.println("중기예보 제이슨 : "+item);
	        
	        weather.setBasedate(baseDate);
	        weather.setWf4(item.getJSONObject(0).getString("wf4Am"));
	        weather.setWf5(item.getJSONObject(0).getString("wf5Am"));
	        weather.setWf6(item.getJSONObject(0).getString("wf6Am"));
	        weather.setWf7(item.getJSONObject(0).getString("wf7Am"));
	        weather.setWf8(item.getJSONObject(0).getString("wf8"));
	        weather.setWf9(item.getJSONObject(0).getString("wf9"));
	        weather.setWf10(item.getJSONObject(0).getString("wf10"));

	        System.out.println("중기예보 set 완료");
	        
	        
	        //기온 불러오기
	        System.out.println("이제 기온 불러오기");
	        //일단 회원의 지역코드 받아와야 함
	        String sessionid;
	        String areaname="창원";
			if(request.getSession(false) != null)
			{
				sessionid = request.getSession(false).getId();
				if(sessionid != null)
				{
					//세션에서 유저아이디 꺼내기
					Member mb = (Member) request.getSession(false).getAttribute("member");
					if(mb !=  null)
					{
						String useraddr = mb.getUserAddr();
						System.out.println("유저 주소는 : "+ useraddr);
						if(useraddr != null && useraddr != "")
						{
							System.out.println("로그인했고 유저 주소있을때만 지역코드 바뀜");
							areaname = useraddr.substring(0, 2);
						}
					}
					System.out.println("세션은 있는데 로그인 안됐음");
				}
			}
	        regId = weatherService.getRegCode(areaname);	
	        System.out.println("지역코드 받아옴");
	        
	        StringBuilder urlTempBuilder = new StringBuilder("http://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa"); /*URL*/
	        urlTempBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "="+clientKey); /*Service Key*/
	        urlTempBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlTempBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
	        urlTempBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON)Default: XML*/
	        urlTempBuilder.append("&" + URLEncoder.encode("regId","UTF-8") + "=" + URLEncoder.encode(regId, "UTF-8")); /*11B10101 서울, 11B20201 인천 등 ( 별첨엑셀자료 참고)*/
	        urlTempBuilder.append("&" + URLEncoder.encode("tmFc","UTF-8") + "=" + URLEncoder.encode(baseDate, "UTF-8")); /*-일 2회(06:00,18:00)회 생성 되며 발표시각을 입력- YYYYMMDD0600(1800) 최근 24시간 자료만 제공*/
	        URL urlTemp = new URL(urlTempBuilder.toString());
	        
	        JSONObject json2 = afile.returnJson(urlTemp);
	        System.out.println(json);
	        JSONObject response2 = json2.getJSONObject("response");
	        JSONObject body2 = response2.getJSONObject("body");
	        JSONObject items2 = body2.getJSONObject("items");
	        JSONArray item2 = items2.getJSONArray("item");
	        System.out.println(item2);
	        // 3일 후 예상최저기온(℃) taMin3, 3일 후 예상최고기온(℃) taMax3 이라고 해놓고 키는 또 4부터 시작함
	        System.out.println("3일 후 예상 최고 기온 : "+item2.getJSONObject(0).getInt("taMax4"));
	        weather.setRegId(regId);
	        weather.setTaMin4(item2.getJSONObject(0).getInt("taMin4"));
	        weather.setTaMin5(item2.getJSONObject(0).getInt("taMin5"));
	        weather.setTaMin6(item2.getJSONObject(0).getInt("taMin6"));
	        weather.setTaMin7(item2.getJSONObject(0).getInt("taMin7"));
	        weather.setTaMin8(item2.getJSONObject(0).getInt("taMin8"));
	        weather.setTaMin9(item2.getJSONObject(0).getInt("taMin9"));
	        weather.setTaMin10(item2.getJSONObject(0).getInt("taMin10"));
	        weather.setTaMax4(item2.getJSONObject(0).getInt("taMax4"));
	        weather.setTaMax5(item2.getJSONObject(0).getInt("taMax5"));
	        weather.setTaMax6(item2.getJSONObject(0).getInt("taMax6"));
	        weather.setTaMax7(item2.getJSONObject(0).getInt("taMax7"));
	        weather.setTaMax8(item2.getJSONObject(0).getInt("taMax8"));
	        weather.setTaMax9(item2.getJSONObject(0).getInt("taMax9"));
	        weather.setTaMax10(item2.getJSONObject(0).getInt("taMax10"));
		} 
		catch (Exception e) 
		{
			System.out.println("중기예보 apicall 트라이캐치 에러에러");
			e.printStackTrace();
		}
		
		return weather;
	}
}