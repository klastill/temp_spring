package com.myweb.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.myweb.domain.CommentDTO;
import com.myweb.domain.CommentVO;
import com.myweb.domain.PageVO;
import com.myweb.persistence.CommentDAORule;

@Service
public class CommentService implements CommentServiceRule {
	private static Logger logger = LoggerFactory.getLogger(CommentService.class);
	
	@Inject
	private CommentDAORule cdao;

	@Override
	public int register(CommentVO cvo) {
		return cdao.insert(cvo);
	}

	@Override
	public int modify(CommentVO cvo) {
		return cdao.update(cvo);
	}

	@Override
	public int remove(int cno) {
		return cdao.delete(cno);
	}

	@Override
	public int removeAll(int rno) {
		return cdao.deleteAll(rno);
	}

	@Override
	public CommentDTO getList(int rno, PageVO pgvo) {
		int totalCount=cdao.selectOne(rno);
		List<CommentVO> list = cdao.selectList(rno,pgvo);
		return new CommentDTO(totalCount,list);
	}
}
