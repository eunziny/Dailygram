package com.kitri.daily.search;

import java.util.List;

import com.kitri.daily.board.Board;

public interface SearchService {
	List<Look> getLook(int row); //
	String[] getLookCnt(String id); //처음 요청이 오자마자 친구와,좋아요 수를 가져온다.
	String getFriLookCnt(String id); //좋아요 0 친구 1명이상일 때 수를 가져온다.
	List<Look> getFriLookDown(Look lo);  //친구 1명이상이면서 게시물 100개 이하일때
	List<Look> getFriLookUp(Look lo);   // 친구 1명 이상이면서 게시물 100개 이상일 때
	List<Look> getLikeLook(Look lo);    //  친구 0 좋아요 1개 이상일 때 게시물들을 가져온다.
	List<Look> getFrLiLook(Look lo);    //  친구,좋아요 1개 이상씩일때 게시물을 가져온다.
}
