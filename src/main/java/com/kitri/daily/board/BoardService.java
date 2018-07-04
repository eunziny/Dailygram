package com.kitri.daily.board;

import java.util.List;

import com.kitri.daily.search.Hashtag;

public interface BoardService {
	void uploadBoard(Board b);
	Board detailBoard(int board_seq);
	void editBoard(Board b);
	void delBoard(int board_seq, String writer);
	List<Board> getMyList(String id);
	List<Board> getNewsfeed(String id);
	List<Hashtag>insertHashtag(Hashtag h);
}
