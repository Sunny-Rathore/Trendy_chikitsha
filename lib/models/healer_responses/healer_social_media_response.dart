class SubmitSocialMediaResponse {
  String? status;
  String? msg;
  Response? response;

  SubmitSocialMediaResponse({this.status, this.msg, this.response});

  SubmitSocialMediaResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    response = json['response'] != null
        ? Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (response != null) {
      data['response'] = response!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['h_facebook_link'] = hFacebookLink;
    data['h_twitter_link'] = hTwitterLink;
    data['h_instagram_link'] = hInstagramLink;
    data['h_pinterest_link'] = hPinterestLink;
    data['h_linkedin_link'] = hLinkedinLink;
    data['h_youtube_link'] = hYoutubeLink;
    return data;
  }
}
