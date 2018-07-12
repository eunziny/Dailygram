package com.kitri.daily.friend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.kitri.daily.alerm.Alerm;

public interface FriService {
	List<HashMap<String, Object>> getFriendRelationshipCount(String user_id);
	List getRecommend(String user_id);
	String getUserIntro(String user_id);
	ArrayList<Friend> getRecommendHT1(Friend friend);
	ArrayList<Friend> getRecommendHT2(Friend friend);
	ArrayList<Friend> getRecommendHT3(Friend friend);
	ArrayList<Friend> getRecommendHT4(Friend friend);
	ArrayList<Friend> getRecommendHT5(Friend friend);
	ArrayList<Friend> getRecommend2(String user_id);
	ArrayList<Friend> getsubscribeList(String user_id);
	ArrayList<Friend> getfollowingList(String id);
	ArrayList<Friend> getfollowerList(String id);
	ArrayList<Integer> profileCount(String user_id);
	void subscribe(Relationship subscribe);
	void cancelfollow(Relationship relation);
	void cancelsubscribe(Relationship relation);
	void addfollow(Relationship relation);
	ArrayList<Friend> getfollowwaitList(String id);
	void addfollowalerm(Alerm alerm);
	Alerm findAlerm(Alerm alerm);
	void deleteAlerm(Alerm alerm);
	void successFollow(Relationship relation);
	void updateRead(Alerm alerm);
	ArrayList<Integer> FriendprofileCount(String sender);
}
