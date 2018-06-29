package com.kitri.daily.friend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface FriService {
	List<HashMap<String, Object>> getFriendRelationshipCount(String user_id);
	List getRecommend();
	String getUserIntro(String user_id);
	ArrayList<Friend> getRecommendHT1(String tag1);
	ArrayList<Friend> getRecommendHT2(Friend friend);
	ArrayList<Friend> getRecommendHT3(Friend friend);
	ArrayList<Friend> getRecommendHT4(Friend friend);
	ArrayList<Friend> getRecommendHT5(Friend friend);	
}
