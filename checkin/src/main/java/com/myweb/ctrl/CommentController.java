package com.myweb.ctrl;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.myweb.domain.CommentDTO;
import com.myweb.domain.CommentVO;
import com.myweb.domain.PageVO;
import com.myweb.service.CommentServiceRule;

@RequestMapping("/comment/*")
@RestController
public class CommentController {
	private static Logger logger = LoggerFactory.getLogger(CommentController.class);
	
	@Inject
	private CommentServiceRule csv;
	
	@RequestMapping(value="/{cno}",method= {RequestMethod.PATCH,RequestMethod.PUT},
			consumes="application/json",produces=MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@PathVariable("cno")int cno, @RequestBody CommentVO cvo){
		return csv.modify(cvo) > 0 ?
				new ResponseEntity<String>("1",HttpStatus.OK) :
					new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value="/{cno}", produces=MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("cno")int cno){
		return csv.remove(cno) > 0 ? 
				new ResponseEntity<String>("1",HttpStatus.OK) :
					new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = {"/rno/{rno}/{pgIdx}/{range}/{keyword}","/rno/{rno}/{pgIdx}"},
			produces = {MediaType.APPLICATION_ATOM_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<CommentDTO> list(@PathVariable("rno")int rno,
			@PathVariable("pgIdx")int pgIdx,
			@PathVariable(value = "range", required = false)String range,
			@PathVariable(value = "keyword", required = false)String keyword){
//		List<CommentVO> list = csv.getList(pno);		
		return new ResponseEntity<CommentDTO>(csv.getList(rno, new PageVO(pgIdx,range,keyword)),
				HttpStatus.OK);
	}
	
	@PostMapping(value="/register", consumes= "application/json", 
			produces="applecation/text; charset=utf-8")
	public ResponseEntity<String> register(@RequestBody CommentVO cvo) {
		int isUp = csv.register(cvo);
		logger.info(cvo.getCmt());
		return isUp > 0 ? new ResponseEntity<String>("1" ,HttpStatus.OK)
				:new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
