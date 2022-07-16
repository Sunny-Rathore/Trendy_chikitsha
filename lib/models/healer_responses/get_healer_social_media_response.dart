class GetHealerSocialMediaResponse {
  String? status;
  String? msg;
  List<Response>? response;

  GetHealerSocialMediaResponse({this.status, this.msg, this.response});

  GetHealerSocialMediaResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
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
