package com.myweb.domain.cart;

public class CartVO {
	private int cartno;
	private String memberID;
	private String bname;
	private int price;
	private int qty;
	private String regdate;
	private String isbn;
	private String cover;
	private int mileage;
	
	public CartVO(String memberID, String bname, int price, int qty, String isbn, String cover) {
		this.memberID = memberID;
		this.bname = bname;
		this.price = price;
		this.qty = qty;
		this.isbn = isbn;
		this.cover = cover;
	}

	public CartVO() {
	}

	
	public CartVO(String memberID2, String bname2, int price2, int qty2, String isbn2, String cover2, int mile2) {
		this.memberID = memberID2;
		this.bname = bname2;
		this.price = price2;
		this.qty = qty2;
		this.isbn = isbn2;
		this.cover = cover2;
		this.mileage=mile2;
	}

	public int getMileage() {
		return mileage;
	}

	public void setMileage(int mile) {
		this.mileage = mile;
	}

	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public int getCartno() {
		return cartno;
	}
	public void setCartno(int cartno) {
		this.cartno = cartno;
	}
	public String getMemberID() {
		return memberID;
	}
	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}
