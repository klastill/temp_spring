package com.myweb.persistence.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.myweb.domain.cart.CartVO;

@Repository
public class CartDAO implements CartDAORule {
	private static Logger logger = LoggerFactory.getLogger(CartDAO.class);
	private final String NS="CartMapper.";
	
	@Inject
	private SqlSession sql;

	@Override
	public int insert(CartVO cartvo) {
		return sql.insert(NS+"add", cartvo);
	}

	@Override
	public List<CartVO> selectList(String mid) {
		return sql.selectList(NS+"list", mid);
	}
	@Override
	public List<CartVO> isIn(String isbn, String memberID) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("isbn", isbn);
		map.put("memberID", memberID);
		return sql.selectList(NS+"isin", map);
		
	}
	@Override
	public int delete(int cartno) {
		return sql.delete(NS+"del", cartno);
	}

	@Override
	public int deleteAll(String mid) {
		return sql.delete(NS+"delAll", mid);
	}

	@Override
	public int updateQty(int cartno, int mileage, int i) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("cartno", cartno);
		map.put("mileage", mileage);
		map.put("qty", i);
		return sql.update(NS+"upqty",map);
	}

	@Override
	public int countCart(String mid) {
		return sql.selectOne(NS+"count", mid);
	}
}
