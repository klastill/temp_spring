package com.myweb.ctrl;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.checkerframework.checker.units.qual.m;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.domain.MemberVO;
import com.myweb.domain.PageVO;
import com.myweb.domain.subscribe.SubscribeVO;
import com.myweb.handler.PagingHandler;
import com.myweb.orm.FileProcessor;
import com.myweb.service.member.MemberServiceRule;
import com.myweb.service.subscribe.SubscribeServiceRule;

@RequestMapping("/member/*")
@Controller
public class MemberController {
	private static Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Inject
	private MemberServiceRule msv;

	// by 동환 추가
	@Inject
	private FileProcessor fp;

	@Inject
	private BCryptPasswordEncoder bcpEncoder;

	// by 동현 추가
	@Inject
	private SubscribeServiceRule ssv;

	// 구독리스트 by 동현

	@GetMapping("/followingList")
	public String followingList(@RequestParam("memberID") String memberID, Model model, PageVO pgvo) {
		MemberVO mvo = msv.detail(memberID);
		int mno = mvo.getMno();
		model.addAttribute("s_list", ssv.getListSend(mno));
		return "/member/followingList";
	}

	@GetMapping("/followerList")
	public String followerList(@RequestParam("memberID") String memberID, Model model, PageVO pgvo) {
		MemberVO mvo = msv.detail(memberID);
		int mno = mvo.getMno();
		model.addAttribute("s_list", ssv.getListReceived(mno));
		return "/member/followerList";
	}

	// 구독상태인지 확인 by 동현
	@ResponseBody
	@PostMapping("/isSubscribe")
	public String isSubscribe(@RequestParam("smID") String smID, @RequestParam("rmID") String rmID) {
		MemberVO smvo = msv.detail(smID);
		MemberVO rmvo = msv.detail(rmID);
		int smno = smvo.getMno();
		int rmno = rmvo.getMno();
		if (smno == rmno) {
			return "3";
		}
		SubscribeVO svo = new SubscribeVO(smno, rmno);
		SubscribeVO svo2 = ssv.checkSubscribe(svo);
		if (svo2 == null || svo2.equals(null)) {
			logger.info(">>>  check null");
			return "1";
		} else if (svo2.getStatus() == 0) {
			logger.info(">>>  check status0");
			return "1";
		} else if (svo2.getStatus() == 1) {
			logger.info(">>>  check status1");
			return "2";
		} else {
			return "0";
		}
	}

	// 구독하기 by 동현
	@ResponseBody
	@PostMapping("/subscribe")
	public String subscribe(@RequestParam("smID") String smID, @RequestParam("rmID") String rmID) {
		MemberVO smvo = msv.detail(smID);
		MemberVO rmvo = msv.detail(rmID);
		int smno = smvo.getMno();
		int rmno = rmvo.getMno();
		if (smno == rmno) {
			return "3";
		}
		SubscribeVO svo = new SubscribeVO(smno, rmno);
		SubscribeVO svo2 = ssv.checkSubscribe(svo);
		if (svo2 == null || svo2.equals(null)) {
			ssv.register(svo);
			return "1";
		} else if (svo2.getStatus() == 0) {
			ssv.changeSubscribe(svo, 1);
			return "1";
		} else if (svo2.getStatus() == 1) {
			ssv.changeSubscribe(svo, 0);
			return "2";
		} else {
			return "0";
		}
	}

	@PostMapping("/modify")
   public String modify(MemberVO mvo, @RequestParam("mno") int mno,RedirectAttributes reAttr,
		   @RequestParam(name="files", required = false)MultipartFile[] files) {
	   mvo.setMemberPassword(bcpEncoder.encode(mvo.getPassword())); 
	  int isUp = msv.modify(mvo);
	  

	  if(files[0].getSize() > 0) {
//		int mno = mvo.getMno();
		isUp = fp.upload_file(files, mno);
	}
	  	reAttr.addFlashAttribute("result", isUp > 0 ? "Modify Success" : "Modify Fail");            
	  	return isUp > 0 ? "redirect:/" : "redirect:/member/detail";
   }

	@ResponseBody
	@PostMapping("/delfile")
	public String del_file(@RequestParam("mno") int mno) {
		int isUp = fp.deletFile(mno);
		return isUp > 0 ? "1": "0";
	}
	@GetMapping("/modify")
	public void modify(@RequestParam("memberID") String memberID, @RequestParam("mno") int mno, Model model) {
		model.addAttribute("mvo", msv.detail(memberID));
		model.addAttribute("fvo", msv.getProfile(mno));
	}

	@GetMapping("/detail")
	public void detail(@RequestParam("memberID") String memberID, @RequestParam("mno") int mno, Model model) {
		model.addAttribute("mvo", msv.detail(memberID));
		model.addAttribute("fvo", msv.getProfile(mno));
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("mno") int mno, RedirectAttributes reAttr) {
		System.out.println(">>>>>>>>>mno"+mno);
		logger.info(">>>>>>>,mno"+mno);
		int isUp = msv.remove(mno);
		logger.info(">>>>>>>isup"+isUp);
		System.out.println(">>>>>>>isup"+mno);
		reAttr.addFlashAttribute("result", isUp > 0 ? "Removing Member Success" : "Removing Member Fail");
		return "redirect:/member/list";
	}
	@PostMapping("able")
	public String changeEnabeld(@RequestParam("mno") int mno, RedirectAttributes reAttr) {
		int isUp = msv.changeEnabeld(mno);
		reAttr.addFlashAttribute("result", isUp > 0 ? "Change Member Success" : "Change Member Fail");
		return "redirect:/member/list";
	}

	@GetMapping("/list")
	public void list(Model model, PageVO pgvo) {
		model.addAttribute("m_list", msv.getList(pgvo));
		int totalCount = msv.getTotalCount(pgvo);
		model.addAttribute("pghdl", new PagingHandler(totalCount, pgvo));
	}

	@GetMapping("/membersearch")
	public void search(Model model, PageVO pgvo) {
		model.addAttribute("ms_list", msv.getSearchedList(pgvo));
		int totalCount = msv.getTotalCount(pgvo);
		model.addAttribute("pghdl", new PagingHandler(totalCount, pgvo));
	}

	@PostMapping("/login")
	public String login(RedirectAttributes reAttr, HttpServletRequest req) {
//      MemberVO info = msv.login(mvo);
//      if(info != null) {
//         ses.setAttribute("ses", info);
//         ses.setMaxInactiveInterval(10*60); // 10 min         
//      }
//      reAttr.addFlashAttribute("result", ses.getAttribute("ses") != null ? 
//            "Login Success" : "Login Fail");
//      return ses.getAttribute("ses") != null ? "redirect:/" : "redirect:/member/login";
		reAttr.addFlashAttribute("memberID", req.getAttribute("memberID"));
		reAttr.addFlashAttribute("err_msg", req.getAttribute("err_msg"));
		return "redirect:/";
	}

	@GetMapping("/login")
	public void login() {

	}

	@ResponseBody
	@PostMapping("/checkID")
	public String memberIDCheck(@RequestParam("memberID") String memberID) {
		int isExist = msv.checkID(memberID);
		return isExist > 0 ? "1" : "0";
	}

	@PostMapping("/register")
	public String register(MemberVO mvo, RedirectAttributes reAttr,
			@RequestParam(name = "files", required = false) MultipartFile[] files) {
		mvo.setMemberPassword(bcpEncoder.encode(mvo.getPassword())); // 패스워드 암호화시키는거(레지스터 할때 VO 객체 던지면 VO객체에서 pwd만 꺼내서
																		// 암호화 시킨뒤 다시 넣는거 그리고 db로 던짐)
		int isUp = msv.register(mvo);
		if (files[0].getSize() > 0) {
			int mno = msv.getCurrMno();
			isUp = fp.upload_file(files, mno);
		}
		reAttr.addFlashAttribute("result", isUp > 0 ? "Register Success" : "Register Fail");
		return isUp > 0 ? "redirect:/" : "redirect:/member/register";
	}

	@GetMapping("/register")
	public void register() {
		logger.info("/WEB-INF/views/member/register.jsp - GET");
	}

	@ResponseBody
	@PostMapping("/nowMileage")
	public String nowMileage(@RequestParam("memberID") String memberID) {
		int i = msv.nowMileage(memberID);
		return Integer.toString(i);
	}
}