package com.kitri.daily.board;

import java.sql.Date;

public class Like {
	private int board_seq;
	private String sender;
	private String type;
	private Date date;
	
	public Like() {}
	
	public Like(int board_seq, String sender) {
		super();
		this.board_seq = board_seq;
		this.sender = sender;
	}

	public Like(int board_seq, String sender, String type, Date date) {
		super();
		this.board_seq = board_seq;
		this.sender = sender;
		this.type = type;
		this.date = date;
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
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "like_siren [board_seq=" + board_seq + ", sender=" + sender + ", type=" + type + ", date=" + date + "]";
	}
	
}
