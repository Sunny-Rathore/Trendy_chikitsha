class SubmitSocialMediaResponse {
  String? status;
  String? msg;
  Response? response;

  SubmitSocialMediaResponse({this.status, this.msg, this.response});

  SubmitSocialMediaResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  String? hFacebookLink;
  String? hTwitterLink;
  String? hInstagramLink;
  String? hPinterestLink;
  String? hLinkedinLink;
  String? hYoutubeLink;

  Response(
      {this.hFacebookLink,
        this.hTwitterLink,
        this.hInstagramLink,
        this.hPinterestLink,
        this.hLinkedinLink,
        this.hYoutubeLink});

  Response.fromJson(Map<String, dynamic> json) {
    hFacebookLink = json['h_facebook_link'];
    hTwitterLink = json['h_twitter_link'];
    hInstagramLink = json['h_instagram_link'];
    hPinterestLink = json['h_pinterest_link'];
    hLinkedinLink = json['h_linkedin_link'];
    hYoutubeLink = json['h_youtube_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h_facebook_link'] = this.hFacebookLink;
    data['h_twitter_link'] = this.hTwitterLink;
    data['h_instagram_link'] = this.hInstagramLink;
    data['h_pinterest_link'] = this.hPinterestLink;
    data['h_linkedin_link'] = this.hLinkedinLink;
    data['h_youtube_link'] = this.hYoutubeLink;
    return data;
  }
}
