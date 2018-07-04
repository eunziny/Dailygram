package com.kitri.daily.search;

public class Hashtag {
	private int board_seq;
	private String tagname;
	private String block_yn;
	
	public Hashtag() {}

	public Hashtag(int board_seq, String tagname, String block_yn) {
		super();
		this.board_seq = board_seq;
		this.tagname = tagname;
		this.block_yn = block_yn;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getTagname() {
		return tagname;
	}

	public void setTagname(String tagname) {
		this.tagname = tagname;
	}

	public String getBlock_yn() {
		return block_yn;
	}

	public void setBlock_yn(String block_yn) {
		this.block_yn = block_yn;
	}

	@Override
	public String toString() {
		return "Hashtag [board_seq=" + board_seq + ", tagname=" + tagname + ", block_yn=" + block_yn + "]";
	}
}
