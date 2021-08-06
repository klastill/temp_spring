package com.myweb.persistence.wish;

import java.util.List;

import com.myweb.domain.wish.WishVO;

public interface WishDAORule {
	public int insert(WishVO wvo);
	public int delete(int mno, String isbn);
	public List<WishVO> selectList(int mno);
	public int countWish(String mno);
}
