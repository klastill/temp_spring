package com.myweb.service.order;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.myweb.domain.order.OrderDTO;
import com.myweb.domain.order.OrderVO;
import com.myweb.persistence.order.OrderDAORule;

@Service
public class OrderService implements OrderServiceRule {
	private static Logger logger = LoggerFactory.getLogger(OrderService.class);

	@Inject
	private OrderDAORule odao;
	
	@Override
	public int register(OrderVO ovo) {
		return odao.insert(ovo);
	}

	@Override
	public List<OrderDTO> selectList(String mid) {
		return odao.selectList(mid);
	}

	@Override
	public OrderVO selectOne(int ono) {
		return odao.selectOne(ono);
	}

	@Override
	public int remove(int ono) {
		return odao.remove(ono);
	}

	@Override
	public List<OrderDTO> selectList(int ono) {
		return odao.selectList(ono);
	}
	
}
