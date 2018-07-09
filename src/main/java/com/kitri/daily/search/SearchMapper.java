package com.kitri.daily.search;

import java.util.List;

public interface SearchMapper {
	List<Look> getLook(int row);
	String[] getLookCnt(String id);
	String getFriLookCnt(String id);
	List<Look> getFriLookDown(Look lo);
	List<Look> getFriLookUp(Look lo);
	List<Look> getLikeLook(Look lo);
	List<Look> getFrLiLook(Look lo);
	List<Search> selectByUser(String tagname);
	List<Search> selectByTag(Search sc);
	List<Search> selectByAuto(String term);
	List<Search> getInfiTag(Search sc);
	List<Search> getListSize(String tagname);
}
