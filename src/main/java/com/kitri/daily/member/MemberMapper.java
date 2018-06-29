package com.kitri.daily.member;

public interface MemberMapper {
	Member getMember(String id);
	void delMember(String id);
}
