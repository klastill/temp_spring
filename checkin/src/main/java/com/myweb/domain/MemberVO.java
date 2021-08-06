package com.myweb.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@SuppressWarnings("serial")
public class MemberVO implements UserDetails {
    private int mno; 
    private String memberID; 
    private String memberPassword; 
    private String memberName; 
    private String memberGender; 
    private String memberEmail; 
    private String memberPhone; 
    private String memberBirth; 
    private int mileage; 
    private String zipcode; 
    private String roadAddress; 
    private String addressDetail; 
    private String file;
    private FilesVO fvo;
    private String auth; 
    private boolean enabled;
    private int failcnt; 
    
    
    public MemberVO() {}
    
	public MemberVO(String mid, int mile) {
		this.memberID=mid;
		this.mileage=mile;
	}
	
	
	
	public FilesVO getFvo() {
		return fvo;
	}

	public void setFvo(FilesVO fvo) {
		this.fvo = fvo;
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
	public String getMemberPassword() {
		return memberPassword;
	}
	public void setMemberPassword(String memberPassword) {
		this.memberPassword = memberPassword;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberGender() {
		return memberGender;
	}
	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getMemberPhone() {
		return memberPhone;
	}
	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}
	public String getMemberBirth() {
		return memberBirth;
	}
	public void setMemberBirth(String memberBirth) {
		this.memberBirth = memberBirth;
	}
	public int getMileage() {
		return mileage;
	}
	public void setMileage(int mileage) {
		this.mileage = mileage;
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
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	
	//security
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public int getFailcnt() {
		return failcnt;
	}
	public void setFailcnt(int failcnt) {
		this.failcnt = failcnt;
	}
	public boolean getEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	// UserDetails 인터페이스 임플리먼츠 해서 생긴 오버라이드들
	//바로 밑에 있는 얘가 핵심임(권한이 부여된 인증체계의 형식을 갖는 모든 것들을 컬렉션 타입으로 리턴)
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		ArrayList<GrantedAuthority> authList = new ArrayList<GrantedAuthority>();
		authList.add(new SimpleGrantedAuthority(auth));//SimpleGrantedAuthority간편화된 인증토큰
	    return authList;
	    //request에서 ID,pwd넣었잔아 근데 이 외의 값도 넣을수있어 근데 다른값들은 Id,pwd처럼 하나씩의토큰으로 넘어오는게아니고 단체로묶인토큰으로 넘어와
	    //getAuthorities값에는 우리가 토큰(csrf)에다가 담아서 인증형으로 감싼 객체안에 id,pwd는 인증체계로 인해 여기로넘어와 여기에 들어온 상태로 존재하면 getAuthorities를 불러 
	    //근데 우리가 auth(페이지에서 넘어온 파라미터 인증)에 담자나 그 두개를 비교해  그담에 authList(필터)로 리턴시켜줘
	}

	@Override
	public String getPassword() {
		return getMemberPassword();
	}

	@Override
	public String getUsername() {
		return getMemberID();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return this.enabled;
	}

	// 개발 완료 후 삭제해야해!!
	@Override
	public String toString() {
		return "MemberVO [mno=" + mno + ", memberID=" + memberID + ", memberPassword=" + memberPassword
				+ ", memberName=" + memberName + ", memberGender=" + memberGender + ", memberEmail=" + memberEmail
				+ ", memberPhone=" + memberPhone + ", memberBirth=" + memberBirth + ", mileage=" + mileage
				+ ", zipcode=" + zipcode + ", roadAddress=" + roadAddress + ", addressDetail=" + addressDetail
				+ ", file=" + file + ",  auth=" + auth + ", enabled=" + enabled + ", failcnt="
				+ failcnt + "]";
	} 
    
}