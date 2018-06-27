package com.kitri.daily.search;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

import com.kitri.daily.board.Board;

@Component("searchService")
public class SearchServiceImpl implements SearchService {
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	private SearchMapper searchMapper;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<Board> getLook(String id) {
		// TODO Auto-generated method stub
		return null;
	}

}
