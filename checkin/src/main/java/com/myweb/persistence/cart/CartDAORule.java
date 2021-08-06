package com.myweb.persistence.cart;

import java.util.List;

import com.myweb.domain.cart.CartVO;

public interface CartDAORule {
	public int insert(CartVO cartvo);
	public List<CartVO> selectList(String mid);
	public int delete(int cartno);
	public int deleteAll(String mid);
	public int updateQty(int cartno, int mileage, int i);
	public List<CartVO> isIn(String isbn, String memberID);
	public int countCart(String mid);
}
