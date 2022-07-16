class RegisterClientResponse {
  String? status;
  String? msg;
  Response? response;

  RegisterClientResponse({this.status, this.msg, this.response});

  RegisterClientResponse.fromJson(Map<String, dynamic> json) {
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
  String? clName;
  String? clEmail;
  String? clPassword;
  String? clTelephone;
  String? clAge;
  String? clGender;
  String? clAddress;
  String? clPin;
  String? clDate;
  String? clLinks;
  int? clApprove;

  Response(
      {this.clName,
        this.clEmail,
        this.clPassword,
        this.clTelephone,
        this.clAge,
        this.clGender,
        this.clAddress,
        this.clPin,
        this.clDate,
        this.clLinks,
        this.clApprove});

  Response.fromJson(Map<String, dynamic> json) {
    clName = json['cl_name'];
    clEmail = json['cl_email'];
    clPassword = json['cl_password'];
    clTelephone = json['cl_telephone'];
    clAge = json['cl_age'];
    clGender = json['cl_gender'];
    clAddress = json['cl_address'];
    clPin = json['cl_pin'];
    clDate = json['cl_date'];
    clLinks = json['cl_links'];
    clApprove = json['cl_approve'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cl_name'] = this.clName;
    data['cl_email'] = this.clEmail;
    data['cl_password'] = this.clPassword;
    data['cl_telephone'] = this.clTelephone;
    data['cl_age'] = this.clAge;
    data['cl_gender'] = this.clGender;
    data['cl_address'] = this.clAddress;
    data['cl_pin'] = this.clPin;
    data['cl_date'] = this.clDate;
    data['cl_links'] = this.clLinks;
    data['cl_approve'] = this.clApprove;
    return data;
  }
}
