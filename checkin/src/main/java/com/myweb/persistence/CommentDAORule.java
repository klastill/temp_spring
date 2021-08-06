package com.myweb.persistence;

import java.util.List;

import com.myweb.domain.CommentVO;
import com.myweb.domain.PageVO;

public interface CommentDAORule {
	public int insert(CommentVO cvo);
	public int update(CommentVO cvo);
	public int delete(int cno);
	public int deleteAll(int rno);
	public int selectOne(int rno);
	public List<CommentVO> selectList(int rno, PageVO pgvo);
}
