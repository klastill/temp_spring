package com.myweb.service.cart;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myweb.domain.cart.CartVO;
import com.myweb.domain.order.OrderVO;
import com.myweb.persistence.cart.CartDAORule;
import com.myweb.persistence.member.MemberDAORule;
import com.myweb.persistence.order.OrderDAORule;

@Service
public class CartService implements CartServiceRule {
	private static Logger logger = LoggerFactory.getLogger(CartService.class);

	@Inject
	private CartDAORule cadao;
	
	@Inject
	private OrderDAORule odao;
	
	@Inject
	private MemberDAORule mdao;
	
	@Override
	public int register(CartVO cartvo) {
		return cadao.insert(cartvo);
	}

	@Override
	public List<CartVO> getList(String mid) {
		return cadao.selectList(mid);
	}
	@Override
	public List<CartVO> isIn(String isbn, String memberID) {
		return cadao.isIn(isbn, memberID);
	}

	@Override
	public int remove(int cartno) {
		return cadao.delete(cartno);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public int removeAll(OrderVO ovo) {		//결제확인 누르면 주문내역에 정보 들어가고 장바구니에서 사라지고,주문정보들이 들어가야 함
		odao.insert(ovo);
		int orderno=odao.selectOne();	//결제번호
		List<CartVO> list = cadao.selectList(ovo.getMemberid());
		mdao.update(ovo.getMemberid(), -ovo.getMileage());
		for (CartVO cvo : list) {
			mdao.update(ovo.getMemberid(), cvo.getMileage());		//마일리지 업데이트
			odao.addInfo(orderno,Double.toString(cvo.getPrice()),cvo);	//orderinfo에 넣기
		}
		return cadao.deleteAll(ovo.getMemberid());
	}

	@Override
	public int updateQty(int cartno, int mileage, int i) {
		return cadao.updateQty(cartno, mileage, i);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public int quickOrder(OrderVO ovo, CartVO cvo) {
		odao.insert(ovo);
		int orderno=odao.selectOne();
		mdao.update(ovo.getMemberid(), -ovo.getMileage());
		mdao.update(ovo.getMemberid(), cvo.getMileage());
		return odao.addInfo(orderno,Double.toString( cvo.getPrice()), cvo);
	}

	@Override
	public int countlist(String mid) {
		return cadao.countCart(mid);
	}
}
