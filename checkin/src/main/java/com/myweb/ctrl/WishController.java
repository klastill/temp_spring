package com.myweb.ctrl;

import java.util.List;

import javax.inject.Inject;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.domain.wish.WishVO;
import com.myweb.service.wish.WishServiceRule;


@RequestMapping("/wish/*")
@Controller
public class WishController {
	private static Logger logger = LoggerFactory.getLogger(WishController.class);

	@Inject
	private WishServiceRule wsv;
	

	
//	@ResponseBody
//	@PostMapping("/register")
//	public String wishAdd(WishVO wvo, RedirectAttributes reAttr) {
//		int isUp = wsv.register(wvo);
//		reAttr.addFlashAttribute("result", isUp > 0 ? "Register Success" : "Register Fail");
//		return isUp > 0 ? "1" : "0";
//	}
	@ResponseBody
	@PostMapping("/register")
	public String wishAdd(@RequestParam("mno") int mno, 
			@RequestParam("bname") String bname, 
			@RequestParam("book_cover") String cover, 
			@RequestParam("book_price") int price, 
			@RequestParam("book_isbn") String isbn,
			@RequestParam("book_author") String author,
			@RequestParam("book_description") String description,
			RedirectAttributes reAttr) {
		WishVO wvo = new WishVO(mno, bname, cover, price, isbn, author, description);
		int isUp = wsv.register(wvo);
		reAttr.addFlashAttribute("result", isUp > 0 ? "Register Success" : "Register Fail");
		return isUp > 0 ? "1" : "0";
	}
	
	@ResponseBody
	@DeleteMapping(value="/{mno}/{isbn}",produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("mno")int mno, @PathVariable("isbn")String isbn) {
		return wsv.remove(mno, isbn) > 0?
				new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@PostMapping("/wishList")
	public List<WishVO> wishlist(@RequestParam("mno")int mno) {
		List<WishVO> wishlist = wsv.getList(mno);
		return wishlist;
	}
	
	@GetMapping("/wishList")
	public String wishlist(@RequestParam("mno")int mno, HttpSession ses,Model model,RedirectAttributes reAttr) {
		model.addAttribute("model_mno", mno);
		logger.info("wishMno"+mno);
		return "/wish/wishList";
	}
	
	@ResponseBody
	@PostMapping("/count")
	public String wishCounting(@RequestParam("mno") String mno) {
		int i=wsv.countWish(mno);
		return Integer.toString(i);
	}
}
