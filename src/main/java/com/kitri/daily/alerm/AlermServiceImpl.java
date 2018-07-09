package com.kitri.daily.alerm;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;


@Component("alermService")
public class AlermServiceImpl implements AlermService {
	@Resource(name="sqlSession")//의존성 주입
	private SqlSession sqlSession;
	private AlermMapper alermMapper;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	

	
	
}
