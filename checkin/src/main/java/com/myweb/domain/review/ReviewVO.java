package com.myweb.domain.review;

// 리뷰VO by 동현 , 2021/07/07
public class ReviewVO {
	private int rno;
	//review number
	private int mno;
	//member number
	private String memberID;
	//memberID
	private String title;
	//제목
	private String content;
	//내용
	private String regdate;
	//등록일 수정일도 필요하나?
	private int recommend;
	//추천수 별 5개~0개
	private int likey;
	//좋아요 
	private String bname;
	//book name
	private String link;
	//알라딘 링크
	private String cover;
	// 책 cover img
	private int readCount;
	// 조회수
	private String isbn;
	//책 번호
	private String content2;
	
	//기본 생성자
	public ReviewVO() {}
	
	//리뷰 등록 by 동현,2021/07/07
	public ReviewVO(int mno,String memberID, String title, String content, int recommend, String bname, String link,String cover,String isbn) {
		this.mno=mno;
		this.memberID = memberID;
		this.title = title;
		this.content = content;
		this.recommend = recommend;
		this.bname = bname;
		this.link = link;
		this.cover = cover;
		this.isbn=isbn;
	}
	//review 등록 글 긴경우 by 동현,2021/07/20
	public ReviewVO(int mno,String memberID, String title, String content,String content2, int recommend, String bname, String link,String cover,String isbn) {
		this.mno=mno;
		this.memberID = memberID;
		this.title = title;
		this.content = content;
		this.content2=content2;
		this.recommend = recommend;
		this.bname = bname;
		this.link = link;
		this.cover = cover;
		this.isbn=isbn;
	}
	//리뷰 수정 by 동현, 2021/07/07
	public ReviewVO(int rno, String title, String content,int recommend) {
		this.rno = rno;
		this.title = title;
		this.content = content;
		this.recommend=recommend;
	}
	//리뷰 수정 content2 by 동현,2021/07/20
	public ReviewVO(int rno, String title, String content,int recommend,String content2) {
		this.rno = rno;
		this.title = title;
		this.content = content;
		this.content2=content2;
		this.recommend=recommend;
	}
	//전부 가져오기 by 동현, 2021/07/07 쓰일까?

	public ReviewVO(int rno, int mno, String memberID, String title, String content, String regdate, int recommend,
			int likey, String bname, String link, String cover, int readCount, String isbn) {
		this.rno = rno;
		this.mno = mno;
		this.memberID = memberID;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
		this.recommend = recommend;
		this.likey = likey;
		this.bname = bname;
		this.link = link;
		this.cover = cover;
		this.readCount = readCount;
		this.isbn = isbn;
	}
	//전부 가져오기 by 동현, 2021/07/20 쓰일까?

		public ReviewVO(int rno, int mno, String memberID, String title, String content, String regdate, int recommend,
				int likey, String bname, String link, String cover, int readCount, String isbn,String content2) {
			this.rno = rno;
			this.mno = mno;
			this.memberID = memberID;
			this.title = title;
			this.content = content;
			this.regdate = regdate;
			this.recommend = recommend;
			this.likey = likey;
			this.bname = bname;
			this.link = link;
			this.cover = cover;
			this.readCount = readCount;
			this.isbn = isbn;
			this.content2=content2;
		}
	//uplike에서 필요한데 검토중
	public ReviewVO(int rno, int mno) {
		this.rno=rno;
		this.mno=mno;
	}

	
	
	public String getContent2() {
		return content2;
	}

	public void setContent2(String content2) {
		this.content2 = content2;
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public int getMno() {
		return mno;
	}

	public void setMno(int mno) {
		this.mno = mno;
	}

	public String getMemberID() {
		return memberID;
	}

	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getLikey() {
		return likey;
	}

	public void setLikey(int likey) {
		this.likey = likey;
	}

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	
	
	
	
}
