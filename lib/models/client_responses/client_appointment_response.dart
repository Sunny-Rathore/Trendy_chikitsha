class ClientAppointmentResponse {
  String? status;
  String? msg;
  List<AppointmentResponse>? response;

  ClientAppointmentResponse({this.status, this.msg, this.response});

  ClientAppointmentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['response'] != null) {
      response = <AppointmentResponse>[];
      json['response'].forEach((v) {
        response!.add(new AppointmentResponse.fromJson(v));
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

class AppointmentResponse {
  String? healerProfile;
  String? healerName;
  String? therapyName;
  String? date;
  String? slot;
  String? address;
  String? healerEmail;
  String? healerMobile;
  String? status;

  AppointmentResponse(
      {this.healerProfile,
        this.healerName,
        this.therapyName,
        this.date,
        this.slot,
        this.address,
        this.healerEmail,
        this.healerMobile,
        this.status});

  AppointmentResponse.fromJson(Map<String, dynamic> json) {
    healerProfile = json['healer_profile'];
    healerName = json['healer_name'];
    therapyName = json['therapy_name'];
    date = json['date'];
    slot = json['slot'];
    address = json['address'];
    healerEmail = json['healer_email'];
    healerMobile = json['healer_mobile'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['healer_profile'] = this.healerProfile;
    data['healer_name'] = this.healerName;
    data['therapy_name'] = this.therapyName;
    data['date'] = this.date;
    data['slot'] = this.slot;
    data['address'] = this.address;
    data['healer_email'] = this.healerEmail;
    data['healer_mobile'] = this.healerMobile;
    data['status'] = this.status;
    return data;
  }
}
