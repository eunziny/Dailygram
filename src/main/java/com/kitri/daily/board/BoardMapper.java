package com.kitri.daily.board;

import java.util.List;

import com.kitri.daily.search.Hashtag;

public interface BoardMapper {
	void insert(Board b);
	Board select(int board_seq);
	void update(Board b);
	void delete(int board_seq, String writer);
	List<Board> myList(String id);
	List<Board> newsfeed(String id);
	List<Hashtag>insertTag(Hashtag h);
}
