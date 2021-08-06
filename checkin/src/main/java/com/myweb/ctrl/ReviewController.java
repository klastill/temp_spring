package com.myweb.ctrl;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.servlet.support.RequestContextUtils;

import com.myweb.domain.BookVO;
import com.myweb.domain.MemberVO;
import com.myweb.domain.PageVO;
import com.myweb.domain.like.LikeVO;
import com.myweb.domain.review.ReviewVO;
import com.myweb.handler.PagingHandler;
import com.myweb.service.like.LikeServiceRule;
import com.myweb.service.member.MemberServiceRule;
import com.myweb.service.review.ReviewServiceRule;

//리뷰 컨트롤러 by 동현, 2021/07/08
@RequestMapping("/review/*")
@Controller
public class ReviewController {
	private static Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Inject
	private ReviewServiceRule rsv;

	@Inject
	private MemberServiceRule msv;


	@PostMapping("/modify")
	public String modify(ReviewVO rvo, RedirectAttributes reAttr, PageVO pgvo,@RequestParam(value="url",required=false) String url) {
		if(rvo.getContent().length()>=800) {
			rvo.setContent2(rvo.getContent().substring(800, rvo.getContent().length()));
			rvo.setContent(rvo.getContent().substring(0, 800));
		}
		int isUp = rsv.modify(rvo);
		reAttr.addFlashAttribute("result", isUp > 0 ? "리뷰수정 성공" : "리뷰수정 실패");
		reAttr.addFlashAttribute("pgvo", pgvo);
		reAttr.addFlashAttribute("url",url);
		System.out.println("url>>>>>>>"+url);
		return "redirect:/review/detail?rno=" + rvo.getRno();
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("rno") int rno, PageVO pgvo, RedirectAttributes reAttr) {
		int isUp = rsv.remove(rno);
		reAttr.addFlashAttribute("result", isUp > 0 ? "리뷰삭제 성공" : "리뷰삭제 실패");
		reAttr.addFlashAttribute("pgvo", pgvo);
		return "redirect:/review/list";
	}

	@GetMapping({ "/detail", "/modify" })
	public void detail(HttpServletRequest request,Model model, @RequestParam("rno") int rno, @ModelAttribute("pgvo") PageVO pgvo,@RequestParam(value="url",required=false) String url) {
		ReviewVO rvo=rsv.detail(rno);
		int mno= rvo.getMno();
		model.addAttribute("r_list", rsv.getRelatedList(rno, mno));
		model.addAttribute("fvo", msv.getProfile(mno));
		model.addAttribute("rvo", rvo);
		model.addAttribute("url",url);
		String param;
		Map<String, ?> redirectMap = RequestContextUtils.getInputFlashMap(request); 
		if( redirectMap  != null ){
	        param =  (String)redirectMap.get("url") ;  // 오브젝트 타입이라 캐스팅해줌
	        model.addAttribute("urlBeforeMod",param);
	        System.out.println(">>>>>>>>>>>>getUrlBeforeMod"+param);
	    }
		System.out.println(">>>>>>>>>>>>get url"+url);
	}
	
	@GetMapping("/myList")
	public String myList(Model model,@RequestParam("memberID") String memberID,PageVO pgvo) {
		MemberVO mvo = msv.detail(memberID);
		int mno = mvo.getMno();
		model.addAttribute("list", rsv.getMyList(mno,pgvo));
		int totalMyCount=rsv.getTotalMyCount(mno,pgvo);
		model.addAttribute("pghdl",new PagingHandler(totalMyCount,pgvo));
		return "/review/list";
	}
	@GetMapping("/searchedList")
	public String searchedList(Model model,@RequestParam("book_isbn") String isbn,PageVO pgvo) {
		model.addAttribute("list", rsv.getSearchedList(isbn,pgvo));
		int totalMyCount=rsv.getTotalSearchedCount(isbn,pgvo);
		model.addAttribute("pghdl",new PagingHandler(totalMyCount,pgvo));
		return "/review/searchedList";
	}
	@GetMapping("/reviewSearch")
	   public String search(Model model, PageVO pgvo) {
	      model.addAttribute("list", rsv.getSearchedkeywordList(pgvo));
	      int totalMyCount=rsv.getTotalSearchedCount(pgvo);
		 model.addAttribute("pghdl",new PagingHandler(totalMyCount,pgvo));
	      return "/review/searchedList";
	   }
	
	@GetMapping("/favorList")
	public String favorList(Model model, PageVO pgvo) {
		model.addAttribute("list", rsv.getFavorList(pgvo));
		int totalCount = rsv.getTotalCount(pgvo);
		model.addAttribute("pghdl", new PagingHandler(totalCount, pgvo));
		return "/review/list";
	}
	
	@GetMapping("/list")
	public void list(Model model, PageVO pgvo) {
		model.addAttribute("list", rsv.getList(pgvo));
		int totalCount = rsv.getTotalCount(pgvo);
		model.addAttribute("pghdl", new PagingHandler(totalCount, pgvo));
	}

	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(ReviewVO rvo, RedirectAttributes reAttr,Model model) {
		if(rvo.getContent().length()>=800) {
			rvo.setContent2(rvo.getContent().substring(800, rvo.getContent().length()));
			rvo.setContent(rvo.getContent().substring(0, 800));
		}
		int isUp = rsv.register(rvo);
		msv.updateMile(rvo.getMemberID(),50);
		reAttr.addFlashAttribute("result", isUp > 0 ? "Success Register" : "Fail Register");
		return isUp > 0 ? "redirect:/review/list" : "redirect:/review/register";
	}

	// register.jsp로 이동
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register(BookVO bvo,Model model) {
		logger.info("WEB-INF/views/review/register.jsp로 이동");
		model.addAttribute("bvo",bvo);
	}
}
