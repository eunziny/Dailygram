package com.kitri.daily.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;
import com.kitri.daily.search.Hashtag;
import com.kitri.daily.alerm.Alerm;
import com.kitri.daily.friend.Relationship;
import com.kitri.daily.member.Member;

@Component("boardService")
public class BoardServiceImpl implements BoardService {
	@Resource(name="sqlSession")//의존성 주입
	private SqlSession sqlSession;
	private BoardMapper boardMapper;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void uploadBoard(Board b) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.insert(b);
	}

	@Override
	public Board detailBoard(int board_seq) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.select(board_seq);
	}

	@Override
	public void editBoard(Board b) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.update(b);
	}

	@Override
	public List<Board> getMyList(String id) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.myList(id);
	}

	@Override
	public List<Board> getNewsfeed(Board b) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.newsfeed(b);
	}

	@Override
	public Board selectByid(String id){
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.selectById(id);
	}

	@Override
	public void insertHashtag(Hashtag h) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.insertTag(h);
	}
	@Override
	public void deleteBoard(int board_seq) throws Exception {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.delAlerm(board_seq);
		boardMapper.dellikeSiren(board_seq);
		boardMapper.delHashtag(board_seq);
		boardMapper.delComment(board_seq);
		boardMapper.delAlerm(board_seq);
		boardMapper.delBoard(board_seq);
	}
	
	@Override
	public List<Comment> getComments(int board_seq) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.selectComments(board_seq);
	}

	@Override
	public void insertNewComment(Comment co) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.insertNewComment(co);
	}

	@Override
	public void insertRepComment(Comment co) throws Exception {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.updateStep(co);
		boardMapper.insertRepComment(co);
		boardMapper.updateReply(co);
		
	}
	
	public Like getType(Like like) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.myType(like);
	}

	@Override
	public void delType(Like like) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.delType(like);
	}

	@Override
	public void addLike(Like like) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.addLike(like);
	}

	@Override
	public void addSiren(Like like) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.addSiren(like);
	}

	@Override
	public Member friend(String writer) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.friend(writer);
	}

	@Override
	public void updateComment(Comment co) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.updateComment(co);
	}

	@Override
	public void deleteComment(Comment co) throws Exception {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.updateDownReply(co);
		boardMapper.updateDownStep(co);
		boardMapper.deleteComment(co);
	}

	public ArrayList<Integer> FriendprofileCount(String id) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		ArrayList<Integer> count = boardMapper.selectFriendProfileCount(id);
		return count;
	}

	@Override
	public String[] getStatus(Board b) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.getStatus(b);
	}

	@Override
	public List<Board> publicyn(Board b) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.publicyn(b);
	}
	
	@Override
	public List<Board> publicy(Board b) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.publicy(b);
	}

	@Override
	public String checkRelation(Relationship relation) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.selectcheckRelation(relation);
	}

	@Override
	public List<Comment> getNewsComm(HashMap<String, List<Integer>> hm) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.getNewsComm(hm);
	}

	@Override
	public List<Member> getProfileImg(HashMap<String,List<String>> hm2) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.getProfileImg(hm2);
	}

	@Override
	public String cntBoard(String id) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.cntBoard(id);
	}

	@Override
	public void addlikealerm(Alerm alerm) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.insertLikeAlerm(alerm);
	}
}
