package com.kitri.daily.alerm;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

import com.kitri.daily.search.SearchMapper;


@Component("alermService")
public class AlermServiceImpl implements AlermService {
	@Resource(name="sqlSession")//의존성 주입
	private SqlSession sqlSession;
	private AlermMapper alermMapper;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<Alerm> getMyAlerm(String id) {
		alermMapper = sqlSession.getMapper(AlermMapper.class);
		return alermMapper.selectMyAlerm(id);
	}

	

	
	
}
