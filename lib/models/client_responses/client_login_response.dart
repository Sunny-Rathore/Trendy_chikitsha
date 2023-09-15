class LoginClientResponse {
  String? status;
  String? msg;
  String? response;
  ClientData? clientData;

  LoginClientResponse({this.status, this.msg, this.response, this.clientData});

  LoginClientResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    response = json['response'];
    clientData = json['client_data'] != null
        ? ClientData.fromJson(json['client_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['response'] = response;
    if (clientData != null) {
      data['client_data'] = clientData!.toJson();
    }
    return data;
  }
}

class ClientData {
  String? clId;
  String? clLinks;
  String? clName;
  String? clEmail;
  String? clPassword;
  String? clProfile;
  String? clAge;
  String? clGender;
  String? clDob;
  String? clTelephone;
  String? clAddress;
  String? clPin;
  String? clApprove;
  String? clDate;
  String? reset;
  String? issueId;
  String? type;

  ClientData(
      {this.clId,
        this.clLinks,
        this.clName,
        this.clEmail,
        this.clPassword,
        this.clProfile,
        this.clAge,
        this.clGender,
        this.clDob,
        this.clTelephone,
        this.clAddress,
        this.clPin,
        this.clApprove,
        this.clDate,
        this.reset,
        this.issueId,
        this.type});

  ClientData.fromJson(Map<String, dynamic> json) {
    clId = json['cl_id'];
    clLinks = json['cl_links'];
    clName = json['cl_name'];
    clEmail = json['cl_email'];
    clPassword = json['cl_password'];
    clProfile = json['cl_profile'];
    clAge = json['cl_age'];
    clGender = json['cl_gender'];
    clDob = json['cl_dob'];
    clTelephone = json['cl_telephone'];
    clAddress = json['cl_address'];
    clPin = json['cl_pin'];
    clApprove = json['cl_approve'];
    clDate = json['cl_date'];
    reset = json['reset'];
    issueId = json['issue_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cl_id'] = clId;
    data['cl_links'] = clLinks;
    data['cl_name'] = clName;
    data['cl_email'] = clEmail;
    data['cl_password'] = clPassword;
    data['cl_profile'] = clProfile;
    data['cl_age'] = clAge;
    data['cl_gender'] = clGender;
    data['cl_dob'] = clDob;
    data['cl_telephone'] = clTelephone;
    data['cl_address'] = clAddress;
    data['cl_pin'] = clPin;
    data['cl_approve'] = clApprove;
    data['cl_date'] = clDate;
    data['reset'] = reset;
    data['issue_id'] = issueId;
    data['type'] = type;
    return data;
  }
}
