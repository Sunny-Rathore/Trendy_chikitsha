class RegisterClientResponse {
  String? status;
  String? msg;
  Response? response;

  RegisterClientResponse({this.status, this.msg, this.response});

  RegisterClientResponse.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cl_name'] = clName;
    data['cl_email'] = clEmail;
    data['cl_password'] = clPassword;
    data['cl_telephone'] = clTelephone;
    data['cl_age'] = clAge;
    data['cl_gender'] = clGender;
    data['cl_address'] = clAddress;
    data['cl_pin'] = clPin;
    data['cl_date'] = clDate;
    data['cl_links'] = clLinks;
    data['cl_approve'] = clApprove;
    return data;
  }
}
