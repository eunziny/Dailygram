package com.kitri.daily.friend;

import java.util.HashMap;
import java.util.List;

public interface FriService {
	List<HashMap<String, Object>> getFriendRelationshipCount(String user_id);
	List getRecommend();	
}
