package com.kitri.daily.admin;

import java.util.List;

import com.kitri.daily.search.Hashtag;

public interface AdminMapper {
	List<Hashtag> getBlockList();
	void addBlock(String tagname);
	void cancleBlock(List<String> checkArr);
	List<Integer> joinCount();
	List<Integer> ageCount();
	List<Integer> genderCount();
	List<Like_Siren> getChargeList();
	List<Like_Siren> getPersonList(int bseq);
}
