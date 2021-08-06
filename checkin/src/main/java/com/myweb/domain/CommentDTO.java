package com.myweb.domain;

import java.util.List;

public class CommentDTO {
	private int totalCount;
	private List<CommentVO> cmtlist;
	
	
	public CommentDTO() {}
	public CommentDTO(int totalCount, List<CommentVO> cmtlist) {
		this.totalCount = totalCount;
		this.cmtlist = cmtlist;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public List<CommentVO> getCmtlist() {
		return cmtlist;
	}
	public void setCmtlist(List<CommentVO> cmtlist) {
		this.cmtlist = cmtlist;
	}
}
