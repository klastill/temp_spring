package com.myweb.persistence.files;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.myweb.domain.FilesVO;

@Repository
public class FilesDAO implements FilesDAORule {
	private static Logger logger = LoggerFactory.getLogger(FilesDAO.class);
	private final String NS = "FilesMapper.";
	
	@Inject
	private SqlSession sql;

	@Override
	public int insert(FilesVO fvo) {
		return sql.insert(NS+"reg", fvo);
	}

	@Override
	public List<FilesVO> selectList(int mno) {
		return sql.selectList(NS+"list", mno);
	}

	@Override
	public int delete(int mno) {
		return sql.delete(NS+"del", mno);
	}

	@Override
	public int delete(String uuid) {
		return sql.delete(NS+"d", uuid);
	}
	//by 동현 ,2021/07/16
	@Override
	public FilesVO selectOne(int mno) {
		return sql.selectOne(NS+"detail", mno);
	}

}
