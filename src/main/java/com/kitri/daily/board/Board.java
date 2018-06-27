package com.kitri.daily.board;

import java.sql.Date;

public class Board {
	private int board_seq;
	private String writer;
	private String content;
	private Date posted;
	private String img1;
	private String img2;
	private String img3;
	private String img4;
	private String img5;
	
	public Board() {
	
	}
	
	public Board(int board_seq, String writer, String content, Date posted, String img1, String img2, String img3,
			String img4, String img5) {
		super();
		this.board_seq = board_seq;
		this.writer = writer;
		this.content = content;
		this.posted = posted;
		this.img1 = img1;
		this.img2 = img2;
		this.img3 = img3;
		this.img4 = img4;
		this.img5 = img5;
	}

	
	public Board(int board_seq, String writer, Date posted, String img1) {
		super();
		this.board_seq = board_seq;
		this.writer = writer;
		this.posted = posted;
		this.img1 = img1;
	}

	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getPosted() {
		return posted;
	}
	public void setPosted(Date posted) {
		this.posted = posted;
	}
	public String getImg1() {
		return img1;
	}
	public void setImg1(String img1) {
		this.img1 = img1;
	}
	public String getImg2() {
		return img2;
	}
	public void setImg2(String img2) {
		this.img2 = img2;
	}
	public String getImg3() {
		return img3;
	}
	public void setImg3(String img3) {
		this.img3 = img3;
	}
	public String getImg4() {
		return img4;
	}
	public void setImg4(String img4) {
		this.img4 = img4;
	}
	public String getImg5() {
		return img5;
	}
	public void setImg5(String img5) {
		this.img5 = img5;
	}
	@Override
	public String toString() {
		return "Board [board_seq=" + board_seq + ", writer=" + writer + ", content=" + content + ", posted=" + posted
				+ ", img1=" + img1 + ", img2=" + img2 + ", img3=" + img3 + ", img4=" + img4 + ", img5=" + img5 + "]";
	}
	
}
