package com.kitri.daily.search;

import java.util.List;

import com.kitri.daily.board.Board;

public interface SearchService {
	List<Look> getLook();
	List<String> getLookCnt(String id);
}
