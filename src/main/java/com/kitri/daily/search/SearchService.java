package com.kitri.daily.search;

import java.util.List;

public interface SearchService {
	List getSearchByUser(String searchValue);
	List getSearchByTag(String searchValue);

}
