package com.kitri.daily.friend;

import java.sql.Date;

public class Relationship {
	private String sender;
	private String receiver;
	private String stauts;
	private Date date;
	
	public Relationship() {}
	
	public Relationship(String sender, String receiver) {
		super();
		this.sender = sender;
		this.receiver = receiver;
	}

	public Relationship(String sender, String receiver, String stauts, Date date) {
		super();
		this.sender = sender;
		this.receiver = receiver;
		this.stauts = stauts;
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

	public String getStauts() {
		return stauts;
	}
	public void setStauts(String stauts) {
		this.stauts = stauts;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "Subscribe [user_id=" + sender + ", id=" + receiver + ", stauts=" + stauts + ", date=" + date + "]";
	}
}
