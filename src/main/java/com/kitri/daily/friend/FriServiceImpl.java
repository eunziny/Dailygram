package com.kitri.daily.friend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

import com.kitri.daily.board.BoardMapper;

@Component("friService")
public class FriServiceImpl implements FriService {
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	private FriendMapper friendMapper;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<HashMap<String, Object>> getFriendRelationshipCount(String user_id) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		List<HashMap<String, Object>> m = friendMapper.selectFriendRelationshipCount(user_id);
		return m;
	}
	
	@Override
	public List getRecommend(String user_id) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectRecommend(user_id);
	}

	@Override
	public String getUserIntro(String user_id) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectUserIntro(user_id);
	}

	@Override
	public ArrayList<Friend> getRecommendHT1(String tag1) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectRecommendHT1(tag1);
	}

	@Override
	public ArrayList<Friend> getRecommendHT2(Friend friend) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectRecommendHT2(friend);
	}

	@Override
	public ArrayList<Friend> getRecommendHT3(Friend friend) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectRecommendHT3(friend);
	}

	@Override
	public ArrayList<Friend> getRecommendHT4(Friend friend) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectRecommendHT4(friend);
	}

	@Override
	public ArrayList<Friend> getRecommendHT5(Friend friend) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectRecommendHT5(friend);
	}
	
	@Override
	public ArrayList<Friend> getRecommend2(String user_id) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectRecommend2(user_id);
	}

	@Override
	public ArrayList<Friend> getsubscribeList(String user_id) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectSubscribeList(user_id);
	}

	@Override
	public ArrayList<Friend> getfollowingList(String id) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectFollowingList(id);
	}

	@Override
	public ArrayList<Friend> getfollowerList(String id) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectFollowerList(id);
	}

	@Override
	public void subscribe(Relationship subscribe) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		friendMapper.insertSubscribe(subscribe);
	}

	@Override
	public void cancelfollow(Relationship relation) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		friendMapper.deletefollow(relation);
	}

	@Override
	public void cancelsubscribe(Relationship relation) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		friendMapper.deletesubscribe(relation);
	}

	@Override
	public void addfollow(Relationship relation) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		friendMapper.insertfollow(relation);	
	}

	@Override
	public ArrayList<Integer> profileCount(String user_id) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		ArrayList<Integer> count = friendMapper.selectProfileCount(user_id);
		return count;
	}

	@Override
	public ArrayList<Friend> getfollowwaitList(String id) {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectFollowwaitList(id);
	}
}
