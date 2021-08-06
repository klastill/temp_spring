package com.myweb.domain;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class BookVO {
	private String isbn; // 실제 서비스에서는 필수적일
	private int price; // 필요
	private String title; // 필요
	private String author; // 필요
	private String link; // 필요
	private String description; // 필요
	private String coverImg; // 필요
	private int reviewRank;
	private int bestRank; // option 베스트셀러 리스트에서 사용 (index로 대체가능) 
	private int mile;
	
	public BookVO() {}
	public BookVO(String isbn, int price, String title, String author, String link, String description,
			String coverImg, int reviewRank, int mile) {
		this.isbn = isbn;
		this.price = price;
		this.title = title;
		this.author = author;
		this.link = link;
		this.description = description;
		this.coverImg = coverImg;
		this.reviewRank = reviewRank;
		this.mile = mile;
	}
	public BookVO(String isbn, int price, String title, String author, String link, String description,
			String coverImg, int reviewRank, int mile, int bestRank) {
		this.isbn = isbn;
		this.price = price;
		this.title = title;
		this.author = author;
		this.link = link;
		this.description = description;
		this.coverImg = coverImg;
		this.reviewRank = reviewRank;
		this.mile = mile;
		this.bestRank = bestRank;
	}
	
	public BookVO(String isbn, String title, String link, String coverImg) {
		this.isbn = isbn;
		this.title = title;
		this.link = link;
		this.coverImg = coverImg;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCoverImg() {
		return coverImg;
	}
	public void setCoverImg(String coverImg) {
		this.coverImg = coverImg;
	}
	public int getReviewRank() {
		return reviewRank;
	}
	public void setReviewRank(int reviewRank) {
		this.reviewRank = reviewRank;
	}
	public int getBestRank() {
		return bestRank;
	}
	public void setBestRank(int bestRank) {
		this.bestRank = bestRank;
	}
	
	public int getMile() {
		return mile;
	}
	public void setMile(int mile) {
		this.mile = mile;
	}
	@Override
	public String toString() {
		return "BookVO [isbn=" + isbn + ", price=" + price + ", title=" + title + ", author=" + author + ", link="
				+ link + ", description=" + description + ", coverImg=" + coverImg
				+ "reviewRank=" + reviewRank + ", mileage=" + mile + "]";
	}
	
}
