package com.kitri.daily.board;

import org.apache.ibatis.annotations.Param;

public interface BoardMapper {
	void insert(Board b);
	Board select(int board_seq);
	void update(Board b);
	void delete(int board_seq,String writer);
/*	List selectAll();*/
}
