package com.myweb.persistence.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mchange.v2.cfg.PropertiesConfigSource.Parse;
import com.myweb.domain.cart.CartVO;
import com.myweb.domain.order.OrderDTO;
import com.myweb.domain.order.OrderVO;

@Repository
public class OrderDAO implements OrderDAORule {
	private static Logger logger = LoggerFactory.getLogger(OrderDAO.class);
	private final String NS="OrderMapper.";
	
	@Inject
	private SqlSession sql;

	@Override
	public int insert(OrderVO ovo) {
		return sql.insert(NS+"reg", ovo);
	}

	@Override
	public List<OrderDTO> selectList(String mid) {
		return sql.selectList(NS+"odlist", mid);
	}

	@Override
	public OrderVO selectOne(int idx) {
		return sql.selectOne(NS+"detail",idx);
	}

	@Override
	public int remove(int idx) {
		return sql.delete(NS+"del",idx);
	}

	@Override
	public int selectOne() {
		return sql.selectOne(NS+"idx");
	}

	@Override
	public int addInfo(int ono, String price,CartVO cvo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderno", (Integer)ono);
		map.put("isbn", (String)cvo.getIsbn());
		map.put("qty", (Integer)cvo.getQty());
		map.put("bname", (String)cvo.getBname());
		map.put("price", (String)price);
		map.put("cover", (String)cvo.getCover());		
		map.put("mileage", (Integer)cvo.getMileage());
		return sql.insert(NS+"add",map);
	}

	@Override
	public List<OrderDTO> selectList(int ono) {
		return sql.selectList(NS+"oddetail",(Integer)ono);
	}
}
