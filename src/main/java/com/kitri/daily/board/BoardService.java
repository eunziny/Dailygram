package com.kitri.daily.board;

import java.util.List;

public interface BoardService {
	void uploadBoard(Board b);
	Board detailBoard(int board_seq, String writer);
	void editBoard(Board b);
	void delBoard(int board_seq, String writer);
}
