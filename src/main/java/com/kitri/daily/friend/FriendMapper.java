package com.kitri.daily.friend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.kitri.daily.alerm.Alerm;

public interface FriendMapper {
	List<HashMap<String, Object>> selectFriendRelationshipCount(String user_id);
	List selectRecommend(String user_id);
	String selectUserIntro(String user_id);
	ArrayList<Friend> selectRecommendHT1(Friend friend);
	ArrayList<Friend> selectRecommendHT2(Friend friend);
	ArrayList<Friend> selectRecommendHT3(Friend friend);
	ArrayList<Friend> selectRecommendHT4(Friend friend);
	ArrayList<Friend> selectRecommendHT5(Friend friend);
	ArrayList<Friend> selectRecommend2(String user_id);
	ArrayList<Friend> selectSubscribeList(String user_id);
	ArrayList<Friend> selectFollowingList(String id);
	ArrayList<Friend> selectFollowerList(String id);
	void insertSubscribe(Relationship subscribe);
	void deletefollow(Relationship relation);
	void deletesubscribe(Relationship relation);
	void insertfollow(Relationship relation);
	ArrayList<Integer> selectProfileCount(String user_id);
	ArrayList<Friend> selectFollowwaitList(String id);
	void insertFollowAlerm(Alerm alerm);
	Alerm selectAlerm(Alerm alerm);
	void deleteAlerm(Alerm alerm);
}
