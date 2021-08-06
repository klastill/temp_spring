package com.myweb.ctrl;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.myweb.api.BookListApi;
import com.myweb.domain.BookVO;
import com.myweb.service.review.ReviewServiceRule;

@Controller
public class BookController {
	private static Logger logger = LoggerFactory.getLogger(BookController.class);
	
	@RequestMapping(value="/book/{pageName}")
	public String getPopupPage(@PathVariable("pageName") String pageName) {
		return "/book/"+pageName;
	}


	@Inject
	private ReviewServiceRule rsv;
	@RequestMapping("/book/bookInfo")
	@GetMapping("/bookInfo")
	public void bnlist(Model model, @RequestParam("book_isbn") String isbn) {
		model.addAttribute("bnlist", rsv.getBnameRecommendList(isbn));
		System.out.println("isbn");
	}
	
	@ResponseBody
	@PostMapping("/book/wrreview")
	public void register(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("utf-8");
		String kw = req.getParameter("keyword");
		BookListApi bla = new BookListApi();
		JsonArray slpage = bla.searchedArray(kw, 1);
		JSONObject sllistSet = new JSONObject();
		sllistSet.put("searchedList", slpage);
		String sljsonData = sllistSet.toJSONString();
		PrintWriter slout = resp.getWriter();
		slout.print(sljsonData);
	}
}
