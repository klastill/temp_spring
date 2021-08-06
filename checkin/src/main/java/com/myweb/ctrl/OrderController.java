package com.myweb.ctrl;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.domain.cart.CartVO;
import com.myweb.domain.order.OrderDTO;
import com.myweb.service.order.OrderServiceRule;

@RequestMapping("/order/*")
@Controller
public class OrderController {
	private static Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	@Inject
	private OrderServiceRule osv;

	@GetMapping("/orderList")
	public void list(Model model, @ModelAttribute("olist") ArrayList<OrderDTO> list) {
	}

	@PostMapping("/list")
	public String list(@RequestParam("memberID")String mid, RedirectAttributes reAttr) {
		reAttr.addFlashAttribute("olist",osv.selectList(mid));
		logger.info(">>> list");
		return "redirect:/order/orderList";
	}
	
	@GetMapping("/orderDetail")
	public void detail(@RequestParam("ono") int ono,Model model) {
		model.addAttribute("ovo",osv.selectOne(ono));
		logger.info(">>>"+ono);
		model.addAttribute("list", osv.selectList(ono));
	}
}
