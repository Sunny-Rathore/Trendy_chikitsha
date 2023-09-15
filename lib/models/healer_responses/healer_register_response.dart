class HealerRegisterReponse {
  String? status;
  String? msg;
  Response? response;

  HealerRegisterReponse({this.status, this.msg, this.response});

  HealerRegisterReponse.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['h_name'] = hName;
    data['h_email'] = hEmail;
    data['h_password'] = hPassword;
    data['h_telephone'] = hTelephone;
    data['h_age'] = hAge;
    data['h_gender'] = hGender;
    data['h_address'] = hAddress;
    data['h_pin'] = hPin;
    data['h_date'] = hDate;
    data['h_links'] = hLinks;
    data['h_position'] = hPosition;
    return data;
  }
}
