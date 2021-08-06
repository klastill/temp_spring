package com.myweb.persistence.wish;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.myweb.domain.wish.WishVO;

@Repository
public class WishDAO implements WishDAORule {
	private static Logger logger = LoggerFactory.getLogger(WishDAO.class);
	private final String NS="WishMapper.";
	
	@Inject
	private SqlSession sql;
	
	@Override
	public int insert(WishVO wvo) {
		return sql.insert(NS+"register", wvo);
	}

	@Override
	public int delete(int mno, String isbn) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mno", (Integer)mno);
		map.put("isbn", isbn);
		return sql.delete(NS+"remove", map);
	}

	@Override
	public List<WishVO> selectList(int mno) {
		return sql.selectList(NS+"wishList", mno);
	}

	@Override
	public int countWish(String mno) {
		return sql.selectOne(NS+"count", mno);
	}


}
