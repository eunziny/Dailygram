package com.kitri.daily.friend;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

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
	public List getRecommend() {
		friendMapper = sqlSession.getMapper(FriendMapper.class);
		return friendMapper.selectRecommend();
	}
}
