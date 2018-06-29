package com.kitri.daily.search;

import java.util.List;

public interface SearchMapper {
	List selectByUser(String searchValue);
	List selectByTag(String searchValue);

}
