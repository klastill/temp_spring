package com.myweb.service.cart;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.myweb.domain.cart.CartVO;
import com.myweb.domain.order.OrderVO;

public interface CartServiceRule {
	public int register(CartVO cartvo);
	public List<CartVO> getList(String mid);
	public List<CartVO> isIn(String isbn, String memberID);
	public int remove(int cartno);
	public int removeAll(OrderVO ovo);
	public int updateQty(int cartno, int mileage, int i);
	public int quickOrder(OrderVO ovo, CartVO cvo);
	public int countlist(String mid);
}
