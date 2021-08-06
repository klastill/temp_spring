package com.myweb.domain.wish;


public class WishVO {
	private int wishNo;
	private int mno;
	private String bname;
	private String cover;
	private int price;
	private String isbn;
	private String author;
	private String description;
	public WishVO() {
	}
	
	
	public WishVO(int mno2, String bname2, String cover2, int price2, String isbn2, String author2, String description2) {
	this.mno= mno2;
	this.bname= bname2;
	this.cover= cover2;
	this.price= price2;
	this.isbn= isbn2;
	this.author= author2;
	this.description= description2;
	}


	public int getWishNo() {
		return wishNo;
	}
	public void setWishNo(int wishNo) {
		this.wishNo = wishNo;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}


	public String getAuthor() {
		return author;
	}


	public void setAuthor(String author) {
		this.author = author;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}
	
	
	
}
