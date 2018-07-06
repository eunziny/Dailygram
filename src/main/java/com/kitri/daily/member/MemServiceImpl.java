package com.kitri.daily.member;

import java.util.ArrayList;

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

	@Override
	public void delete(String id) {
		memberMapper = sqlSession.getMapper(MemberMapper.class);
		memberMapper.delMember(id);
	}
	
	@Override
	public ArrayList<Integer> profileCount(String id) {
		memberMapper = sqlSession.getMapper(MemberMapper.class);
		ArrayList<Integer> count = memberMapper.selectProfileCount(id);
		return count;
	}

	@Override
	public void editMem(Member m) {
		memberMapper = sqlSession.getMapper(MemberMapper.class);
		memberMapper.updateMem(m);
	}

	@Override
	public void insertMem(Member m) {
		memberMapper = sqlSession.getMapper(MemberMapper.class);
		memberMapper.insertMem(m);
	}
}
