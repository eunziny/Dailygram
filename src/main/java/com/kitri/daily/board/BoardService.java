package com.kitri.daily.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import com.kitri.daily.search.Hashtag;
import com.kitri.daily.friend.Relationship;
import com.kitri.daily.member.Member;
public interface BoardService {
	void uploadBoard(Board b);
	Board detailBoard(int board_seq);
	void editBoard(Board b);
	List<Board> getMyList(String id);
	List<Board> getNewsfeed(Board b);
	void insertHashtag(Hashtag h);
	Board selectByid(String id);
	@Transactional
	void deleteBoard(int board_seq) throws Exception;
	List<Comment> getComments(int bseq);
	void insertNewComment(Comment co);
	@Transactional
	void insertRepComment(Comment co) throws Exception;
	/*List<Board> getList(Board board);*/
	String[] getStatus(Board b); //상대계정의 공개여부 & 나와 상대의 관계 가져오기
	List<Board> publicyn(Board b); //게시물 전부다(y,n)
	List<Board> publicy(Board board); //공개 게시물만(y)
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
}
