package com.kitri.daily.member;

import java.util.ArrayList;

public interface MemService {
	Member getMember(String id);
	void delete(String id);
	ArrayList<Integer> profileCount(String id);
	void editMem(Member m);
	void insertMem(Member m);
}
