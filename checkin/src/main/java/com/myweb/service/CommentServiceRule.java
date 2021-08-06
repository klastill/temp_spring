package com.myweb.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.myweb.domain.CommentDTO;
import com.myweb.domain.CommentVO;
import com.myweb.domain.PageVO;

public interface CommentServiceRule {
	public int register(CommentVO cvo);
	public int modify(CommentVO cvo);
	public int remove(int cno);
	public int removeAll(int rno);
	public CommentDTO getList(int rno,PageVO pgvo);
}
