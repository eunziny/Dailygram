package com.kitri.daily.search;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

@Component("searchService")
public class SearchServiceImpl implements SearchService {
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	private SearchMapper searchMapper;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List getSearchByUser(String searchValue) {
		// TODO Auto-generated method stub
		searchMapper = sqlSession.getMapper(SearchMapper.class);
		return searchMapper.selectByUser(searchValue);
	}

	@Override
	public List getSearchByTag(String searchValue) {
		// TODO Auto-generated method stub
		searchMapper = sqlSession.getMapper(SearchMapper.class);
		return searchMapper.selectByTag(searchValue);
	}

}
