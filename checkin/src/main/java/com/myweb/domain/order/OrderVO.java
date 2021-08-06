package com.myweb.domain.order;


public class OrderVO {
	private int orderno;
	private String memberid;
	private String memberemail;
	private String memberName;
	private String noneNo;
	private String price;
	private String regdate;
	private int mileage;
	private String phonenum;
	private String demand;
	private String zipcode;
	private String roadAddress;
	private String addressDetail;
	
	public OrderVO() {}
	
	public OrderVO(String memberid,String memberName, String email, int mileage, String phonenum, String demand, String zipcode, String roadAddress,
			String addressDetail) {
		this.memberName=memberName;
		this.memberemail=email;
		this.memberid = memberid;
		this.mileage = mileage;
		this.phonenum = phonenum;
		this.demand = demand;
		this.zipcode = zipcode;
		this.roadAddress = roadAddress;
		this.addressDetail = addressDetail;
	}

	public OrderVO(String mid, String email, String price, String phonenum, String demand, String zipcode,
			String roadAddress, String addressDetail) {
		this.memberid = mid;
		this.memberemail = email;
		this.price = price;
		this.phonenum = phonenum;
		this.demand = demand;
		this.zipcode = zipcode;
		this.roadAddress = roadAddress;
		this.addressDetail = addressDetail;
	}
	
	public int getMileage() {
		return mileage;
	}

	public void setMileage(int mileage) {
		this.mileage = mileage;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public int getOrderno() {
		return orderno;
	}

	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}

	public String getMemberid() {
		return memberid;
	}

	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}

	public String getMemberemail() {
		return memberemail;
	}

	public void setMemberemail(String memberemail) {
		this.memberemail = memberemail;
	}

	public String getNoneNo() {
		return noneNo;
	}

	public void setNoneNo(String noneNo) {
		this.noneNo = noneNo;
	}

	public String getNonNo() {
		return noneNo;
	}
	public void setNonNo(String nonNo) {
		this.noneNo = nonNo;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getPhonenum() {
		return phonenum;
	}
	public void setPhonenum(String phonenum) {
		this.phonenum = phonenum;
	}
	public String getDemand() {
		return demand;
	}
	public void setDemand(String demand) {
		this.demand = demand;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getRoadAddress() {
		return roadAddress;
	}
	public void setRoadAddress(String roadAddress) {
		this.roadAddress = roadAddress;
	}
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
}
