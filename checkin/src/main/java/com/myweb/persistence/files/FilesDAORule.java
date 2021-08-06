package com.myweb.persistence.files;

import java.util.List;

import com.myweb.domain.FilesVO;

public interface FilesDAORule {
	public int insert(FilesVO fvo);
	public List<FilesVO> selectList(int mno);
	public int delete(int mno);
	public int delete(String uuid);
	public FilesVO selectOne(int mno);
}
