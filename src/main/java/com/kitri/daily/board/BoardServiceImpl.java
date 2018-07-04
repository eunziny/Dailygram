package com.kitri.daily.board;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

import com.kitri.daily.member.Member;

@Component("boardService")
public class BoardServiceImpl implements BoardService {
	@Resource(name="sqlSession")//������ ����
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
	public void delBoard(int board_seq, String writer) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.delete(board_seq, writer);
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
	public List<Board> getList(Board board) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.list(board);
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
	public void deleteComment(Comment co) {
		boardMapper = sqlSession.getMapper(BoardMapper.class);
		boardMapper.deleteComment(co);
	}

	

}
