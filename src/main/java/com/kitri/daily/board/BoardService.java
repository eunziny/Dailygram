package com.kitri.daily.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import com.kitri.daily.search.Hashtag;
import com.kitri.daily.alerm.Alerm;
import com.kitri.daily.friend.Relationship;
import com.kitri.daily.member.Member;
public interface BoardService {
	void uploadBoard(Board b);
	Board detailBoard(int board_seq);
	void editBoard(Board b);
	List<Board> getMyList(String id);
	String cntBoard(String id);
	List<Board> getNewsfeed(Board b);
	void insertHashtag(Hashtag h);
	Board selectByid(String id);
	@Transactional
	void deleteBoard(int board_seq) throws Exception;
	List<Comment> getComments(int bseq);
	void insertNewComment(Comment co);
	@Transactional
	void insertRepComment(Comment co) throws Exception;
	String[] getStatus(Board b); //�������� �������� & ���� ����� ���� ��������
	List<Board> publicyn(Board b); //�Խù� ���δ�(y,n)
	List<Board> publicy(Board board); //���� �Խù���(y)
	Like getType(Like like);
	void delType(Like like);
	void addLike(Like like);
	void addSiren(Like like);
	Member friend (String writer);
	void updateComment(Comment co);
	@Transactional
	void deleteComment(Comment co) throws Exception;
	ArrayList<Integer> FriendprofileCount(String id);
	String checkRelation(Relationship relation);
	List<Comment> getNewsComm(HashMap<String, List<Integer>> hm);
	List<Member> getProfileImg(HashMap<String, List<String>> hm2);
	void addlikealerm(Alerm alerm);
	ArrayList<Integer> profileCount(String id);
}
