package com.kitri.daily.board;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class Board {
	private int row;
	private int board_seq;
	private String writer;
	private String content;
	private Date posted;
	private String img;
	private String public_yn;
	private int likecnt;
	private String sender;
	private String type;
	private MultipartFile file;
	

	public Board() {}
	public Board(String writer) {
		super();
		this.writer = writer;
	}
	public Board(String writer, String sender) {
		super();
		this.writer = writer;
		this.sender = sender;
	}
	public Board(int board_seq, String writer, String content, Date posted, String img, String public_yn) {
		super();
		this.board_seq = board_seq;
		this.writer = writer;
		this.content = content;
		this.posted = posted;
		this.img = img;
		this.public_yn = public_yn;
	}
	public Board(int board_seq, String writer, String content, Date posted, String img, String public_yn, int likecnt) {
		super();
		this.board_seq = board_seq;
		this.writer = writer;
		this.content = content;
		this.posted = posted;
		this.img = img;
		this.public_yn = public_yn;
		this.likecnt = likecnt;
	}
	
	public Board(int row, int board_seq, String writer, String content, Date posted, String img, String public_yn,
			int likecnt, String sender, String type) {
		super();
		this.row = row;
		this.board_seq = board_seq;
		this.writer = writer;
		this.content = content;
		this.posted = posted;
		this.img = img;
		this.public_yn = public_yn;
		this.likecnt = likecnt;
		this.sender = sender;
		this.type = type;
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
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getPublic_yn() {
		return public_yn;
	}
	public void setPublic_yn(String public_yn) {
		this.public_yn = public_yn;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	@Override
	public String toString() {
		return "Board [row=" + row + ", board_seq=" + board_seq + ", writer=" + writer + ", content=" + content
				+ ", posted=" + posted + ", img=" + img + ", public_yn=" + public_yn + ", likecnt=" + likecnt
				+ ", sender=" + sender + ", type=" + type + ", file=" + file + "]";
	}
	public int getLikecnt() {
		return likecnt;
	}
	public void setLikecnt(int likecnt) {
		this.likecnt = likecnt;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public int getRow() {
		return row;
	}
	public void setRow(int row) {
		this.row = row;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}