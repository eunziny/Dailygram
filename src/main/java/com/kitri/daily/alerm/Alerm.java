package com.kitri.daily.alerm;

import java.sql.Date;

public class Alerm {
	private Date date;
	private String sender;
	private String receiver;
	private int board_seq;
	private String type;
	
	public Alerm() {}

	public Alerm(String sender, String receiver) {
		super();
		this.sender = sender;
		this.receiver = receiver;
	}

	public Alerm(Date date, String sender, String receiver, String type) {
		super();
		this.date = date;
		this.sender = sender;
		this.receiver = receiver;
		this.type = type;
	}

	public Alerm(Date date, String sender, String receiver, int board_seq, String type) {
		super();
		this.date = date;
		this.sender = sender;
		this.receiver = receiver;
		this.board_seq = board_seq;
		this.type = type;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "Alerm [date=" + date + ", sender=" + sender + ", receiver=" + receiver + ", board_seq=" + board_seq
				+ ", type=" + type + "]";
	}
}
