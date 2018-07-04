package com.kitri.daily.board;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.kitri.daily.search.Hashtag;

public interface BoardService {
	@Transactional
	void uploadBoard(Board b);
	Board detailBoard(int board_seq);
	void editBoard(Board b);
	void delBoard(int board_seq, String writer);
	List<Board> getMyList(String id);
	List<Board> getNewsfeed(String id);
	@Transactional
	void insertHashtag(Hashtag h);
	Board selectByid(String id);
}
