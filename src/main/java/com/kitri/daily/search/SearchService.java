package com.kitri.daily.search;

import java.util.List;

public interface SearchService {
	List<Look> getLook(int row); //
	String[] getLookCnt(String id); //ó�� ��û�� ���ڸ��� ģ����,���ƿ� ���� �����´�.
	String getFriLookCnt(String id); //���ƿ� 0 ģ�� 1���̻��� �� ���� �����´�.
	List<Look> getFriLookDown(Look lo);  //ģ�� 1���̻��̸鼭 �Խù� 100�� �����϶�
	List<Look> getFriLookUp(Look lo);   // ģ�� 1�� �̻��̸鼭 �Խù� 100�� �̻��� ��
	List<Look> getLikeLook(Look lo);    //  ģ�� 0 ���ƿ� 1�� �̻��� �� �Խù����� �����´�.
	List<Look> getFrLiLook(Look lo);    //  ģ��,���ƿ� 1�� �̻��϶� �Խù��� �����´�.
	List<Search> getSearchByUser(String tagname); //id�� ����� �˻� 
	List<Search> getSearchByTag(Search sc); //�ؽ��±׷� �Խù� �˻�
	List<Search> getAutoSearch(String term); //�ڵ��ϼ� ����Ʈ
	List<Search> getSearchInfiTag(int row); //�±� �˻���� ���ѽ�ũ��
}
