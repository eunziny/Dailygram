package com.kitri.daily.board;

import java.util.List;

import com.kitri.daily.search.Hashtag;

public interface BoardMapper {
	void insert(Board b);
	Board select(int board_seq);
	void update(Board b);
	List<Board> myList(String id);
	List<Board> newsfeed(String id);
	void insertTag(Hashtag h);
	Board selectById(String id);
	void delHashtag(int board_seq);
	void delComment(int board_seq);
	void dellikeSiren(int board_seq);
	void delBoard(int board_seq);
}
