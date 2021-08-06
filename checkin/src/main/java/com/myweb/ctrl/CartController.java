package com.myweb.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.print.attribute.standard.Media;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.domain.MemberVO;
import com.myweb.domain.cart.CartVO;
import com.myweb.domain.order.OrderVO;
import com.myweb.service.cart.CartServiceRule;
import com.myweb.service.member.MemberServiceRule;

/*import oracle.jdbc.proxy.annotation.GetProxy;*/

@RequestMapping("/cart/*")
@Controller
public class CartController {
	private static Logger logger = LoggerFactory.getLogger(CartController.class);
	
	@Inject
	private CartServiceRule casv;
	
	@Inject
	private MemberServiceRule msv;
	
	@GetMapping("/orderFinish")
	public void finish() {
	}
	@GetMapping("/list")
	public void list() {
	}
	@GetMapping("/complete")
	public void confirm() {
	}
	@GetMapping("/quickorder")
	public void quick() {
	}
	@GetMapping("/orderCom")
	public void quickCom() {
	}
	
	@ResponseBody
	@PostMapping("/count")
	public String cartCounting(@RequestParam("memberID") String mid) {
		int i=casv.countlist(mid);
		return Integer.toString(i);
	}
	
	@PostMapping("/order")
	public String quickOrder(CartVO cvo, Model model) {
		MemberVO mvo=msv.detail(cvo.getMemberID());
		model.addAttribute("mvo",mvo);
		model.addAttribute("cvo",cvo);
		logger.info(cvo.getBname());
		return "/cart/quickorder";
	}

	@PostMapping("/cartorder")
	public String order(@RequestParam("price") String price,Model model,
			@RequestParam("mid") String memberID) {
		model.addAttribute("price",price);
		MemberVO mvo=msv.detail(memberID);
		model.addAttribute("mvo",mvo);
		return "/cart/orderConfirm";
	}
	
	@PostMapping(value="/complete",  produces="application/text; charset=utf-8")
	public String complete(OrderVO ovo,HttpSession ses) {
		logger.info(ovo.getRoadAddress());
		int isCom=casv.removeAll(ovo);
		MemberVO mvo=msv.detail(ovo.getMemberid());
		ses.setAttribute("ses", mvo);
		return "redirect:/cart/orderFinish";
	}
	@PostMapping(value="/orderCom",  produces="application/text; charset=utf-8")
	public String ordercomplete(HttpSession ses,OrderVO ovo,CartVO cvo,@RequestParam("mileage1") int mile,@RequestParam("price1") String price) {
		logger.info(ovo.getRoadAddress());
		cvo.setMileage(mile);
		double price2 = Double.parseDouble(price);
		cvo.setPrice((int)Math.round(price2));
		ovo.setPrice(price);
		int isCom=casv.quickOrder(ovo,cvo);
		MemberVO mvo=msv.detail(ovo.getMemberid());
		ses.setAttribute("ses", mvo);
		return "redirect:/cart/orderFinish";
	}
	
	@ResponseBody
	@PostMapping(value="/mod",produces = MediaType.TEXT_PLAIN_VALUE)
	public String modify(@RequestParam("cartno") int cartno, @RequestParam("mileage") int mileage,@RequestParam("qty") int qty) {
		int ismod=casv.updateQty(cartno, mileage, qty);
		return ismod>0?"1":"0";
	}
	
	@ResponseBody
	@DeleteMapping(value="/{cartno}",produces = MediaType.TEXT_PLAIN_VALUE)
	public String remove(@PathVariable("cartno") int cartno) {
		int isdel=casv.remove(cartno);
		return isdel>0?"1":"0";
	}
	
	@ResponseBody
	@PostMapping("/list")
	public List<CartVO> list(@RequestParam("memberID") String mid,HttpSession ses) {
//		String mid=(String)ses.get;
		logger.info(mid);
		List<CartVO> list=casv.getList(mid);
		return list;
	}
	
//	@PostMapping("/register")
	@ResponseBody
	@PostMapping("/{isbn}")
	public String register(@RequestParam("member_id") String memberID, @RequestParam("book_name") String bname, 
			@RequestParam("book_price") int price, @RequestParam("quantity") int qty, @RequestParam("book_isbn") String isbn, 
			@RequestParam("book_cover") String cover,@RequestParam("book_mile")int mile, RedirectAttributes reAttr) {
		List<CartVO> list=casv.isIn(isbn, memberID);
		if (list.size() > 0) {
			int cartno = list.get(0).getCartno();
			int cartqty = list.get(0).getQty();
			int ismod=casv.updateQty(cartno, mile, qty);
			reAttr.addFlashAttribute("result",ismod>0?"Qty up":"Qty Fail");
			return ismod>0?"1":"0";
		} else {
			CartVO cartvo = new CartVO(memberID, bname, price, qty, isbn, cover,mile);
			int isUp=casv.register(cartvo);
			reAttr.addFlashAttribute("result",isUp>0?"Cart In":"Cart Fail");
			return isUp>0?"1":"0";
		}
	}
}
