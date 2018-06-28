package com.kitri.daily.friend;

public class Friend {
	private String id;
	private String profile_img;
	private String intro;
	
	public Friend() {}

	
	public Friend(String id, String intro) {
		super();
		this.id = id;
		this.intro = intro;
	}

	public Friend(String id, String profile_img, String intro) {
		super();
		this.id = id;
		this.profile_img = profile_img;
		this.intro = intro;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	@Override
	public String toString() {
		return "Friend [id=" + id + ", profile_img=" + profile_img + ", intro=" + intro + "]";
	}
}
