class HealerLoginResponse {
  String? status;
  String? msg;
  String? response;
  HealerData? healerData;

  HealerLoginResponse({this.status, this.msg, this.response, this.healerData});

  HealerLoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    response = json['response'];
    healerData = json['healer_data'] != null
        ? new HealerData.fromJson(json['healer_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['response'] = this.response;
    if (this.healerData != null) {
      data['healer_data'] = this.healerData!.toJson();
    }
    return data;
  }
}

class HealerData {
  String? hId;
  String? hName;
  String? hEmail;
  String? hPassword;
  String? hProfile;
  String? hAge;
  String? hGender;
  String? hDob;
  String? hTelephone;
  String? hAddress;
  String? hPin;
  String? hAbout;
  String? hApprove;
  String? hDate;
  String? hLinks;
  String? hFacebookLink;
  String? hTwitterLink;
  String? hInstagramLink;
  String? hPinterestLink;
  String? hLinkedinLink;
  String? hYoutubeLink;
  String? hKeywords;
  String? videoLink;
  String? reset;
  String? hPosition;
  String? hFeatured;
  String? hTopRate;
  String? subscriptionPlan;
  String? type;

  HealerData(
      {this.hId,
        this.hName,
        this.hEmail,
        this.hPassword,
        this.hProfile,
        this.hAge,
        this.hGender,
        this.hDob,
        this.hTelephone,
        this.hAddress,
        this.hPin,
        this.hAbout,
        this.hApprove,
        this.hDate,
        this.hLinks,
        this.hFacebookLink,
        this.hTwitterLink,
        this.hInstagramLink,
        this.hPinterestLink,
        this.hLinkedinLink,
        this.hYoutubeLink,
        this.hKeywords,
        this.videoLink,
        this.reset,
        this.hPosition,
        this.hFeatured,
        this.hTopRate,
        this.subscriptionPlan,
        this.type});

  HealerData.fromJson(Map<String, dynamic> json) {
    hId = json['h_id'];
    hName = json['h_name'];
    hEmail = json['h_email'];
    hPassword = json['h_password'];
    hProfile = json['h_profile'];
    hAge = json['h_age'];
    hGender = json['h_gender'];
    hDob = json['h_dob'];
    hTelephone = json['h_telephone'];
    hAddress = json['h_address'];
    hPin = json['h_pin'];
    hAbout = json['h_about'];
    hApprove = json['h_approve'];
    hDate = json['h_date'];
    hLinks = json['h_links'];
    hFacebookLink = json['h_facebook_link'];
    hTwitterLink = json['h_twitter_link'];
    hInstagramLink = json['h_instagram_link'];
    hPinterestLink = json['h_pinterest_link'];
    hLinkedinLink = json['h_linkedin_link'];
    hYoutubeLink = json['h_youtube_link'];
    hKeywords = json['h_keywords'];
    videoLink = json['video_link'];
    reset = json['reset'];
    hPosition = json['h_position'];
    hFeatured = json['h_featured'];
    hTopRate = json['h_top_rate'];
    subscriptionPlan = json['subscription_plan'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h_id'] = this.hId;
    data['h_name'] = this.hName;
    data['h_email'] = this.hEmail;
    data['h_password'] = this.hPassword;
    data['h_profile'] = this.hProfile;
    data['h_age'] = this.hAge;
    data['h_gender'] = this.hGender;
    data['h_dob'] = this.hDob;
    data['h_telephone'] = this.hTelephone;
    data['h_address'] = this.hAddress;
    data['h_pin'] = this.hPin;
    data['h_about'] = this.hAbout;
    data['h_approve'] = this.hApprove;
    data['h_date'] = this.hDate;
    data['h_links'] = this.hLinks;
    data['h_facebook_link'] = this.hFacebookLink;
    data['h_twitter_link'] = this.hTwitterLink;
    data['h_instagram_link'] = this.hInstagramLink;
    data['h_pinterest_link'] = this.hPinterestLink;
    data['h_linkedin_link'] = this.hLinkedinLink;
    data['h_youtube_link'] = this.hYoutubeLink;
    data['h_keywords'] = this.hKeywords;
    data['video_link'] = this.videoLink;
    data['reset'] = this.reset;
    data['h_position'] = this.hPosition;
    data['h_featured'] = this.hFeatured;
    data['h_top_rate'] = this.hTopRate;
    data['subscription_plan'] = this.subscriptionPlan;
    data['type'] = this.type;
    return data;
  }
}
