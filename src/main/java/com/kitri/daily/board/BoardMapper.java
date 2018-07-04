package com.kitri.daily.board;

import java.util.ArrayList;
import java.util.List;

import com.kitri.daily.member.Member;

public interface BoardMapper {
	void insert(Board b);
	Board select(int board_seq);
	void update(Board b);
	void delete(int board_seq, String writer);
	List<Board> myList(String id);
	List<Comment> selectComments(int board_seq);
	void insertNewComment(Comment co);
	void insertRepComment(Comment co);
	List<Board> list(Board board);
	Like myType(Like like);
	void delType(Like like);
	void addLike(Like like);
	void addSiren(Like like);
	Member friend(String writer);
	ArrayList<Integer> selectFriendProfileCount(String id);
}
