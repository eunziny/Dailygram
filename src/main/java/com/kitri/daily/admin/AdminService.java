package com.kitri.daily.admin;

import java.util.List;

import com.kitri.daily.search.Hashtag;

public interface AdminService {
	List<Hashtag> getBlockList(); //금지 태그 리스트 불러오기
	void addBlocktag(String tagname); //금지할 해시태그 추가하기 
	void cancleblock(List<String> checkArr); //금지 해시태그 활성화하기
	List<Like_Siren> getChargeList(); //신고된 게시물 리스트 불러오기
	List<Like_Siren> getPersonList(int bseq); //해당 게시물 신고자 리스트
}
