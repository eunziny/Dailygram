package com.kitri.daily.admin;

import java.util.List;

import com.kitri.daily.search.Hashtag;

public interface AdminService {
	List<Hashtag> getBlockList(); //���� �±� ����Ʈ �ҷ�����
	void addBlocktag(String tagname); //������ �ؽ��±� �߰��ϱ� 
	void cancleblock(List<String> checkArr); //���� �ؽ��±� Ȱ��ȭ�ϱ�
	List<Like_Siren> getChargeList(); //�Ű�� �Խù� ����Ʈ �ҷ�����
	List<Like_Siren> getPersonList(int bseq); //�ش� �Խù� �Ű��� ����Ʈ
}
