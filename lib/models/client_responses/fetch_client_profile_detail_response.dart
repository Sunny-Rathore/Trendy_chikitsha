class FetchClientProfileDetails {
  String? status;
  String? msg;
  List<Response>? response;

  FetchClientProfileDetails({this.status, this.msg, this.response});

  FetchClientProfileDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  String? clId;
  String? clLinks;
  String? clName;
  String? clEmail;
  String? clAge;
  String? clGender;
String? clDob;
  String? clTelephone;
  String? clAddress;
  String? clPin;

  Response(
      {this.clId,
        this.clLinks,
        this.clName,
        this.clEmail,
        this.clAge,
        this.clGender,
        this.clDob,
        this.clTelephone,
        this.clAddress,
        this.clPin});

  Response.fromJson(Map<String, dynamic> json) {
    clId = json['cl_id'];
    clLinks = json['cl_links'];
    clName = json['cl_name'];
    clEmail = json['cl_email'];
    clAge = json['cl_age'];
    clGender = json['cl_gender'];
    clDob = json['cl_dob'];
    clTelephone = json['cl_telephone'];
    clAddress = json['cl_address'];
    clPin = json['cl_pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cl_id'] = clId;
    data['cl_links'] = clLinks;
    data['cl_name'] = clName;
    data['cl_email'] = clEmail;
    data['cl_age'] = clAge;
    data['cl_gender'] = clGender;
    data['cl_dob'] = clDob;
    data['cl_telephone'] = clTelephone;
    data['cl_address'] = clAddress;
    data['cl_pin'] = clPin;
    return data;
  }
}
