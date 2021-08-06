package com.myweb.service.order;

import java.util.List;

import com.myweb.domain.order.OrderDTO;
import com.myweb.domain.order.OrderVO;

public interface OrderServiceRule {
	public int register(OrderVO ovo);
	public List<OrderDTO> selectList(String mid);
	public OrderVO selectOne(int ono);
	public int remove(int ono);
	public List<OrderDTO> selectList(int ono);
}