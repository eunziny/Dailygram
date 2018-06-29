package com.kitri.daily.search;

import java.util.List;

import com.kitri.daily.board.Board;

public interface SearchService {
	List<Look> getLook(int row); //
	String[] getLookCnt(String id); //ó�� ��û�� ���ڸ��� ģ����,���ƿ� ���� �����´�.
	String getFriLookCnt(String id); //���ƿ� 0 ģ�� 1���̻��� �� ���� �����´�.
	List<Look> getFriLookDown(Look lo);  //ģ�� 1���̻��̸鼭 �Խù� 100�� �����϶�
	List<Look> getFriLookUp(Look lo);   // ģ�� 1�� �̻��̸鼭 �Խù� 100�� �̻��� ��
}
