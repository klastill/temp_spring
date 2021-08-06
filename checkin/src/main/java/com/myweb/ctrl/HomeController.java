package com.myweb.ctrl;

import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.myweb.domain.subscribe.SubscribeDTO;
import com.myweb.persistence.alarm.AlarmDAORule;
import com.myweb.service.review.ReviewServiceRule;
import com.myweb.service.subscribe.SubscribeServiceRule;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private ReviewServiceRule rsv;
	
	@Inject
	private SubscribeServiceRule ssv;
	
	@Inject
	private AlarmDAORule adao;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		Gson gson = new Gson();
		String bestLikeList=gson.toJson(rsv.getBestLikeList());
		Gson gson1 = new Gson();
		String bestRcmdList=gson1.toJson(rsv.getBestRecommendList());
		model.addAttribute("recommendList", bestRcmdList);
		model.addAttribute("likeList", bestLikeList);
		//팔로워 랭킹 by 동현,2021/07/18
		
		model.addAttribute("rankFlist",ssv.getRank4List());
		return "home";
	}
	
	@RequestMapping(value = "/checkAlarm", method = RequestMethod.POST)
	public String alarm(Model model, @RequestParam("mid") String memberID) {
		model.addAttribute("alarmList", adao.getAlarmList(memberID));
		return "/checkAlarm";
	}
	
	@RequestMapping(value = "/updateAlarm", method = RequestMethod.GET)
	public void updatealarm(@RequestParam("ano") int ano,@RequestParam("rno") int rno) {
		adao.updateAlarm(ano);
	}

	@ResponseBody
	@PostMapping("/alarmCount")
	public String alarmCount(@RequestParam("memberID") String memberID) {
		int cnt=adao.selectCount(memberID);
		if(cnt==0) {
			return "0";
		}else
			return cnt+"";
	}
}
