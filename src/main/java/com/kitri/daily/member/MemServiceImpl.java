package com.kitri.daily.member;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

@Component("memService")
public class MemServiceImpl implements MemService {
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	private MemberMapper memberMapper;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public Member getMember(String id) {
		memberMapper = sqlSession.getMapper(MemberMapper.class);
		return memberMapper.getMember(id);
	}

}
