package com.kitri.daily.admin;


import java.util.List;
import com.kitri.daily.member.Member;
import com.kitri.daily.search.Hashtag;

public interface AdminMapper {
	List<Hashtag> getBlockList();
	void addBlock(String tagname);
	void cancleBlock(List<String> checkArr);
	List<Member> joinCount();
	List<Member> ageCount();
	List<Member> genderCount();
	List<Like_Siren> getChargeList();
	List<Like_Siren> getPersonList(int bseq);
}
