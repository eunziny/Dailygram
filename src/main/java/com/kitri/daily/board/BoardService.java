package com.kitri.daily.board;


public interface BoardService {
	void uploadBoard(Board b);
	Board detailBoard(int board_seq);
	void editBoard(Board b);
	void delBoard(int board_seq, String writer);
	/*List getAll();*/
}
