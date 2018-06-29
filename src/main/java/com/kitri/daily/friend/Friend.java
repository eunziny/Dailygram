package com.kitri.daily.friend;

public class Friend {
	private String id;
	private String profile_img;
	private String intro;
	private String tag1;
	private String tag2;
	private String tag3;
	private String tag4;
	private String tag5;
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

	public Friend(String id, String profile_img, String intro, String tag1, String tag2, String tag3, String tag4,
			String tag5) {
		super();
		this.id = id;
		this.profile_img = profile_img;
		this.intro = intro;
		this.tag1 = tag1;
		this.tag2 = tag2;
		this.tag3 = tag3;
		this.tag4 = tag4;
		this.tag5 = tag5;
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

	public String getTag1() {
		return tag1;
	}

	public void setTag1(String tag1) {
		this.tag1 = tag1;
	}

	public String getTag2() {
		return tag2;
	}

	public void setTag2(String tag2) {
		this.tag2 = tag2;
	}

	public String getTag3() {
		return tag3;
	}

	public void setTag3(String tag3) {
		this.tag3 = tag3;
	}

	public String getTag4() {
		return tag4;
	}

	public void setTag4(String tag4) {
		this.tag4 = tag4;
	}

	public String getTag5() {
		return tag5;
	}

	public void setTag5(String tag5) {
		this.tag5 = tag5;
	}

	@Override
	public String toString() {
		return "Friend [id=" + id + ", profile_img=" + profile_img + ", intro=" + intro + "]";
	}
}
