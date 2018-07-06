package com.kitri.daily.admin;

import java.util.HashMap;
import java.util.List;

import com.kitri.daily.search.Hashtag;

public interface AdminMapper {
	List<Hashtag> getBlockList();
	void addBlock(String tagname);
	void cancleBlock(List<String> checkArr);
	List<HashMap<Integer,Object>> joinCount();
	List<HashMap<Integer,Object>> ageCount();
	List<HashMap<Integer,Object>> genderCount();
	List<Like_Siren> getChargeList();
	List<Like_Siren> getPersonList(int bseq);
}
