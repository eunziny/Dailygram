package com.kitri.daily.search;

import java.util.List;

import com.kitri.daily.board.Board;

public interface SearchMapper {
	List<Look> getLook(int row);
	List<String> getLookCnt(String id);
}
