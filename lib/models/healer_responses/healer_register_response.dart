class HealerRegisterReponse {
  String? status;
  String? msg;
  Response? response;

  HealerRegisterReponse({this.status, this.msg, this.response});

  HealerRegisterReponse.fromJson(Map<String, dynamic> json) {
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
  String? hName;
  String? hEmail;
  String? hPassword;
  String? hTelephone;
  String? hAge;
  String? hGender;
  String? hAddress;
  String? hPin;
  String? hDate;
  String? hLinks;
  int? hPosition;

  Response(
      {this.hName,
        this.hEmail,
        this.hPassword,
        this.hTelephone,
        this.hAge,
        this.hGender,
        this.hAddress,
        this.hPin,
        this.hDate,
        this.hLinks,
        this.hPosition});

  Response.fromJson(Map<String, dynamic> json) {
    hName = json['h_name'];
    hEmail = json['h_email'];
    hPassword = json['h_password'];
    hTelephone = json['h_telephone'];
    hAge = json['h_age'];
    hGender = json['h_gender'];
    hAddress = json['h_address'];
    hPin = json['h_pin'];
    hDate = json['h_date'];
    hLinks = json['h_links'];
    hPosition = json['h_position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h_name'] = this.hName;
    data['h_email'] = this.hEmail;
    data['h_password'] = this.hPassword;
    data['h_telephone'] = this.hTelephone;
    data['h_age'] = this.hAge;
    data['h_gender'] = this.hGender;
    data['h_address'] = this.hAddress;
    data['h_pin'] = this.hPin;
    data['h_date'] = this.hDate;
    data['h_links'] = this.hLinks;
    data['h_position'] = this.hPosition;
    return data;
  }
}
