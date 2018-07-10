package com.kitri.daily.friend;

import java.sql.Date;

public class Relationship {
	private String sender;
	private String receiver;
	private String status;
	private Date date;
	
	public Relationship() {}
	
	public Relationship(String sender, String receiver) {
		super();
		this.sender = sender;
		this.receiver = receiver;
	}

	public Relationship(String sender, String receiver, String status, Date date) {
		super();
		this.sender = sender;
		this.receiver = receiver;
		this.status = status;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@Override
	public String toString() {
		return "Relationship [sender=" + sender + ", receiver=" + receiver + ", status=" + status + ", date=" + date
				+ "]";
	}
}
