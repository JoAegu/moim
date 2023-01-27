package com.moim.review;

import java.util.*;

public class ReviewDTO {

	private int idx;
	private int idx_member;
	private String moimname;
	private String local;
	private String hobby;
	private String subject;
	private String content;
	private String img;
	private Date wirtedate;
	
	public ReviewDTO() {
		super();
	}

	public ReviewDTO(int idx, int idx_member, String moimname, String local, String hobby, String subject,
			String content, String img, Date wirtedate) {
		super();
		this.idx = idx;
		this.idx_member = idx_member;
		this.moimname = moimname;
		this.local = local;
		this.hobby = hobby;
		this.subject = subject;
		this.content = content;
		this.img = img;
		this.wirtedate = wirtedate;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getIdx_member() {
		return idx_member;
	}

	public void setIdx_member(int idx_member) {
		this.idx_member = idx_member;
	}

	public String getMoimname() {
		return moimname;
	}

	public void setMoimname(String moimname) {
		this.moimname = moimname;
	}

	public String getLocal() {
		return local;
	}

	public void setLocal(String local) {
		this.local = local;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public Date getWirtedate() {
		return wirtedate;
	}

	public void setWirtedate(Date wirtedate) {
		this.wirtedate = wirtedate;
	}
	
	
	
}
