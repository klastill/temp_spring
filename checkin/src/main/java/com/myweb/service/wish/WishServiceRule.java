package com.myweb.service.wish;

import java.util.List;

import com.myweb.domain.wish.WishVO;

public interface WishServiceRule {
	public int register(WishVO wvo);
	public int remove(int mno, String isbn);
	public List<WishVO> getList(int mno);
	public int countWish(String mno);
}
