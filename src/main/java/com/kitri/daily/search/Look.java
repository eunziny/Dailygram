package com.kitri.daily.search;

public class Look {
	private int row;
	private int board_seq;
	private String img;
	public Look() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Look(int row, int board_seq, String img) {
		super();
		this.row = row;
		this.board_seq = board_seq;
		this.img = img;
	}
	public int getRow() {
		return row;
	}
	public void setRow(int row) {
		this.row = row;
	}
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	@Override
	public String toString() {
		return "Look [row=" + row + ", board_seq=" + board_seq + ", img=" + img + "]";
	}

	
}
