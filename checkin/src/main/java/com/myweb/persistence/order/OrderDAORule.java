package com.myweb.persistence.order;

import java.util.List;

import com.myweb.domain.cart.CartVO;
import com.myweb.domain.order.OrderDTO;
import com.myweb.domain.order.OrderVO;

public interface OrderDAORule {
	public int insert(OrderVO ovo);
	public List<OrderDTO> selectList(String mid);
	public OrderVO selectOne(int idx);
	public int remove(int idx);
	public int selectOne();
	public int addInfo(int orderno, String price, CartVO cvo);
	public List<OrderDTO> selectList(int ono);
}
