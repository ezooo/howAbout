package com.springproject.repository;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;

import com.springproject.domain.Location;

public interface LocationRepository 
{
	void addLocationAPI(JSONObject location);
	List<String> getAlltitle();
	List<Location> getAllLocation();
	Location getOneLocation(int num);
	List<Location> getLocationOfCategory(String category);
	List<Location> getAllCategory();
	void createLocation(Location location);
	void submitUpdateLocation(Location location);
	void deleteLocation(int num);
	List<Location> findLocationByTitle(String title);
	String[] getAPIContents(String jsonaddr);
	List<String> getAlladdr();
	List<String> getAllArea();
	List<Location> getLocationOfArea(String area);
	int searchOneLocationNum(String title, String address);
}
