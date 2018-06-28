package com.kitri.daily.board;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BoardMapper {
	void insert(Board b);
	Board select(@Param("board_seq") int board_seq, @Param("writer") String writer);
	void update(Board b);
	void delete(int board_seq,String writer);
/*	List selectAll();*/
}
