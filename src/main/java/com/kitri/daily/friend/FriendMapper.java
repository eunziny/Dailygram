package com.kitri.daily.friend;

import java.util.HashMap;
import java.util.List;

public interface FriendMapper {
	List<HashMap<String, Object>> selectFriendRelationshipCount(String user_id);
	List selectRecommend();
}
