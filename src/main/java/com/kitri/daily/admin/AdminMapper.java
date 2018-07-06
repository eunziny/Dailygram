package com.kitri.daily.admin;

import java.util.List;

import com.kitri.daily.search.Hashtag;

public interface AdminMapper {
	List<Hashtag> getBlockList();
	void addBlock(String tagname);
	void cancleBlock(List<String> checkArr);
}
