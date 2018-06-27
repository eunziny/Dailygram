package com.kitri.daily.search;

import java.util.List;

import com.kitri.daily.board.Board;

public interface SearchMapper {
	List<Board> getLook(String id);
}
