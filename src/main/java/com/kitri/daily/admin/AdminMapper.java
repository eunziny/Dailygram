package com.kitri.daily.admin;

import java.util.List;

import com.kitri.daily.search.Hashtag;

public interface AdminMapper {
	List<Hashtag> getBlockList();
}
