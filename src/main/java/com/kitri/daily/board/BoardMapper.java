package com.kitri.daily.board;

public interface BoardMapper {
	void insert(Board b);
	Board select(int board_seq, String writer);
	void update(Board b);
	void delete(int board_seq,String writer);
}
