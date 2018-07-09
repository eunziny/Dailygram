package com.kitri.daily.member;

import java.util.ArrayList;
import java.util.Map;

public interface MemService {
	Member getMember(String id);
	void delete(String id);
	ArrayList<Integer> profileCount(String id);
	void editMem(Member m);
	void insertMem(Member m);
	String getPw(Map<String, Object> paramMap);
	String getId(String email);
}
