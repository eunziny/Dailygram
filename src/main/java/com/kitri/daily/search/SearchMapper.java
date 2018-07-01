package com.kitri.daily.search;

import java.util.List;

import com.kitri.daily.board.Board;

public interface SearchMapper {
	List<Look> getLook(int row);
	String[] getLookCnt(String id);
	String getFriLookCnt(String id);
	List<Look> getFriLookDown(Look lo);
	List<Look> getFriLookUp(Look lo);
	List<Look> getLikeLook(Look lo);
	List<Look> getFrLiLook(Look lo);
}
