package com.kitri.daily.board;

import java.util.ArrayList;
import java.util.List;
import com.kitri.daily.search.Hashtag;
import com.kitri.daily.friend.Relationship;
import com.kitri.daily.member.Member;
public interface BoardMapper {
	void insert(Board b);
	Board select(int board_seq);
	void update(Board b);
	List<Board> myList(String id);
	List<Board> newsfeed(String id);
	void insertTag(Hashtag h);
	Board selectById(String id);
	void delHashtag(int board_seq);
	void delComment(int board_seq);
	void dellikeSiren(int board_seq);
	void delBoard(int board_seq);
	List<Comment> selectComments(int board_seq);
	void insertNewComment(Comment co);
	void insertRepComment(Comment co);
	void updateStep(Comment co);
	void updateReply(Comment co);
	/*List<Board> list(Board board);*/
	String[] getStatus(Board b);
	List<Board> publicyn(Board board); //게시물 전부다(y,n)
	List<Board> publicy(Board board); //공개 게시물만(y)
	Like myType(Like like);
	void delType(Like like);
	void addLike (Like like);
	void addSiren (Like like);
	Member friend (String writer);
	void updateComment(Comment co);
	void deleteComment(Comment co);
	void updateDownReply(Comment co);
	void updateDownStep(Comment co);
	ArrayList<Integer> selectFriendProfileCount(String id);
	String selectcheckRelation(Relationship relation);
}
