package com.kitri.daily.board;

public class Comment {
	private int board_seq;
	private int com_seq;
	private int ref;
	private int lev;
	private int step;
	private int pseq;
	private int reply;
	private String content;
	private String writer;
	public Comment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Comment(int board_seq, int com_seq, int ref, int lev, int step, int pseq, int reply, String content,
			String writer) {
		super();
		this.board_seq = board_seq;
		this.com_seq = com_seq;
		this.ref = ref;
		this.lev = lev;
		this.step = step;
		this.pseq = pseq;
		this.reply = reply;
		this.content = content;
		this.writer = writer;
	}
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public int getCom_seq() {
		return com_seq;
	}
	public void setCom_seq(int com_seq) {
		this.com_seq = com_seq;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getLev() {
		return lev;
	}
	public void setLev(int lev) {
		this.lev = lev;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getPseq() {
		return pseq;
	}
	public void setPseq(int pseq) {
		this.pseq = pseq;
	}
	public int getReply() {
		return reply;
	}
	public void setReply(int reply) {
		this.reply = reply;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	@Override
	public String toString() {
		return "Comment [board_seq=" + board_seq + ", com_seq=" + com_seq + ", ref=" + ref + ", lev=" + lev + ", step="
				+ step + ", pseq=" + pseq + ", reply=" + reply + ", content=" + content + ", writer=" + writer + "]";
	}
	
}
