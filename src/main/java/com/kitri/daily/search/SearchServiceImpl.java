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
	public List<Look> getLook(int row) {
		searchMapper = sqlSession.getMapper(SearchMapper.class);
		return searchMapper.getLook(row);
	}

	@Override
	public String[] getLookCnt(String id) {
		searchMapper = sqlSession.getMapper(SearchMapper.class);
		return searchMapper.getLookCnt(id);
	}

	@Override
	public String getFriLookCnt(String id) {
		searchMapper = sqlSession.getMapper(SearchMapper.class);		
		return searchMapper.getFriLookCnt(id);
	}

	@Override
	public List<Look> getFriLookDown(Look lo) {
		searchMapper = sqlSession.getMapper(SearchMapper.class);
		return searchMapper.getFriLookDown(lo);
	}

	@Override
	public List<Look> getFriLookUp(Look lo) {
		searchMapper = sqlSession.getMapper(SearchMapper.class);
		return searchMapper.getFriLookUp(lo);
	}

}
