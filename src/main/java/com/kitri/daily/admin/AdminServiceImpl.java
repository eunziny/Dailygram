package com.kitri.daily.admin;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

import com.kitri.daily.search.Hashtag;

@Component("adminService")
public class AdminServiceImpl implements AdminService {
	@Resource(name = "sqlSession")
	private SqlSession sqlSession;
	private AdminMapper adminMapper;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<Hashtag> getBlockList() {
		// TODO Auto-generated method stub
		adminMapper = sqlSession.getMapper(AdminMapper.class);
		return adminMapper.getBlockList();
	}

	@Override
	public void addBlocktag(String tagname) {
		// TODO Auto-generated method stub
		adminMapper = sqlSession.getMapper(AdminMapper.class);
		adminMapper.addBlock(tagname);
	}

	@Override
	public void cancleblock(List<String> checkArr) {
		// TODO Auto-generated method stub
		adminMapper = sqlSession.getMapper(AdminMapper.class);
		adminMapper.cancleBlock(checkArr);
	}

	@Override
	public List<HashMap<Integer,Object>> selectJoin() {
		adminMapper = sqlSession.getMapper(AdminMapper.class);
		return adminMapper.joinCount();
	}

	@Override
	public List<HashMap<Integer,Object>> selectAge() {
		adminMapper = sqlSession.getMapper(AdminMapper.class);
		return adminMapper.ageCount();
	}

	@Override
	public List<HashMap<Integer,Object>> selectGender() {
		adminMapper = sqlSession.getMapper(AdminMapper.class);
		return adminMapper.genderCount();
	}
	public List<Like_Siren> getChargeList() {
		// TODO Auto-generated method stub
		adminMapper = sqlSession.getMapper(AdminMapper.class);
		return adminMapper.getChargeList();
	}

	@Override
	public List<Like_Siren> getPersonList(int bseq) {
		// TODO Auto-generated method stub
		adminMapper = sqlSession.getMapper(AdminMapper.class);
		return adminMapper.getPersonList(bseq);
	}
}
