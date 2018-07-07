package com.kitri.daily.admin;

import java.sql.Date;

import com.kitri.daily.board.Board;

public class Like_Siren {
	private int board_seq;
	private String sender;
	private String type;
	private int sirencnt;
	private Date date;
	private String writer;
	private Board board;
	private String profile_img;
	public Like_Siren() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Like_Siren(int board_seq, String sender, String type, int sirencnt, Date date, String writer, Board board) {
		super();
		this.board_seq = board_seq;
		this.sender = sender;
		this.type = type;
		this.sirencnt = sirencnt;
		this.date = date;
		this.writer = writer;
		this.board = board;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getSirencnt() {
		return sirencnt;
	}

	public void setSirencnt(int sirencnt) {
		this.sirencnt = sirencnt;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public Board getBoard() {
		return board;
	}

	public void setBoard(Board board) {
		this.board = board;
	}
	
	
	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

	@Override
	public String toString() {
		return "Like_Siren [board_seq=" + board_seq + ", sender=" + sender + ", type=" + type + ", sirencnt=" + sirencnt
				+ ", date=" + date + ", writer=" + writer + ", board=" + board + "]";
	}
	
}