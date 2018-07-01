package com.kitri.daily.search;

import java.sql.Date;

import com.kitri.daily.board.Board;
import com.kitri.daily.member.Member;

public class Search {
	private int borad_seq;
	private String img;
	private Date posted;
	private String tagname;
	private String id;
	private String profile_img;
	
	private Board board;
	private Member member;
	private Hashtag hashtag;
	public Search() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public Search(int borad_seq, String img, Date posted, String tagname, String id, String profile_img, Board board,
			Member member, Hashtag hashtag) {
		super();
		this.borad_seq = borad_seq;
		this.img = img;
		this.posted = posted;
		this.tagname = tagname;
		this.id = id;
		this.profile_img = profile_img;
		this.board = board;
		this.member = member;
		this.hashtag = hashtag;
	}


	public int getBorad_seq() {
		return borad_seq;
	}
	public void setBorad_seq(int borad_seq) {
		this.borad_seq = borad_seq;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public Date getPosted() {
		return posted;
	}
	public void setPosted(Date posted) {
		this.posted = posted;
	}
	public String getTagname() {
		return tagname;
	}
	public void setTagname(String tagname) {
		this.tagname = tagname;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public Board getBoard() {
		return board;
	}
	public void setBoard(Board board) {
		this.board = board;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public Hashtag getHashtag() {
		return hashtag;
	}
	public void setHashtag(Hashtag hashtag) {
		this.hashtag = hashtag;
	}
	@Override
	public String toString() {
		return "Search [borad_seq=" + borad_seq + ", img=" + img + ", posted=" + posted + ", tagname=" + tagname
				+ ", id=" + id + ", profile_img=" + profile_img + ", board=" + board + ", member=" + member
				+ ", hashtag=" + hashtag + "]";
	}
	
	
	
	
}
