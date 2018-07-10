package com.kitri.daily.member;

import java.util.ArrayList;
import java.util.Map;

public interface MemberMapper {
	Member getMember(String id);
	void delMember(String id);
	ArrayList<Integer> selectProfileCount(String id);
	void updateMem(Member m);
	void insertMem(Member m);
	String getPw(Map<String, Object> paramMap);
	String getId(String email);
}
