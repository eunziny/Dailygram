package com.kitri.daily.board;

import java.util.List;

public interface BoardMapper {
	void insert(Board b);
	Board select(int board_seq);
	void update(Board b);
	void delete(int board_seq, String writer);
	List<Board> myList(String id);
	List<Comment> selectComments(int board_seq);
	void insertNewComment(Comment co);
	void insertRepComment(Comment co);
}
