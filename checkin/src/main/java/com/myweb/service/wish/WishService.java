package com.myweb.service.wish;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.myweb.domain.wish.WishVO;
import com.myweb.persistence.wish.WishDAORule;

@Service
public class WishService implements WishServiceRule {
	private static Logger logger = LoggerFactory.getLogger(WishService.class);

	@Inject
	private WishDAORule wdao;
	
	@Override
	public int register(WishVO wvo) {
		return wdao.insert(wvo);
	}

	@Override
	public int remove(int mno, String isbn) {
		return wdao.delete(mno, isbn);
	}

	@Override
	public List<WishVO> getList(int mno) {
		return wdao.selectList(mno);
	}

	@Override
	public int countWish(String mno) {
		return wdao.countWish(mno);
	}

}
