package com.kitri.daily.member;

import java.util.ArrayList;

public interface MemberMapper {
	Member getMember(String id);
	void delMember(String id);
	ArrayList<Integer> selectProfileCount(String id);
}
