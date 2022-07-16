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
        ? new ClientData.fromJson(json['client_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['response'] = this.response;
    if (this.clientData != null) {
      data['client_data'] = this.clientData!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cl_id'] = this.clId;
    data['cl_links'] = this.clLinks;
    data['cl_name'] = this.clName;
    data['cl_email'] = this.clEmail;
    data['cl_password'] = this.clPassword;
    data['cl_profile'] = this.clProfile;
    data['cl_age'] = this.clAge;
    data['cl_gender'] = this.clGender;
    data['cl_dob'] = this.clDob;
    data['cl_telephone'] = this.clTelephone;
    data['cl_address'] = this.clAddress;
    data['cl_pin'] = this.clPin;
    data['cl_approve'] = this.clApprove;
    data['cl_date'] = this.clDate;
    data['reset'] = this.reset;
    data['issue_id'] = this.issueId;
    data['type'] = this.type;
    return data;
  }
}
