package com.myweb.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.myweb.domain.CommentVO;
import com.myweb.domain.PageVO;

@Repository
public class CommentDAO implements CommentDAORule {
	private final String NS="CommentMapper.";
	
	@Inject
	private SqlSession sql;

	@Override
	public int insert(CommentVO cvo) {
		return sql.insert(NS+"reg",cvo);
	}

	@Override
	public int update(CommentVO cvo) {
		return sql.update(NS+"mod",cvo);
	}

	@Override
	public int delete(int cno) {
		return sql.delete(NS+"del", cno);
	}

	@Override
	public int deleteAll(int rno) {
		return sql.delete(NS+"delAll", rno);
	}

	@Override
	public int selectOne(int rno) {
		return sql.selectOne(NS+"tc", rno);
	}

	@Override
	public List<CommentVO> selectList(int rno, PageVO pgvo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rno", (Integer)rno);
		map.put("pageIndex", (Integer)pgvo.getPageIndex());
		map.put("keyword", (String)pgvo.getKeyword());
		map.put("range", (String)pgvo.getRange());
		RowBounds rowbounds = new RowBounds((pgvo.getPageIndex()-1)*10, 10);	
		return sql.selectList(NS+"list",map,rowbounds);
	}
	
}
