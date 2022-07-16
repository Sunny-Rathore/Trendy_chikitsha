class HealerAppointmentResponse {
  String? status;
  String? msg;
  List<HealerAppointmentListResponse>? response;

  HealerAppointmentResponse({this.status, this.msg, this.response});

  HealerAppointmentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['response'] != null) {
      response = <HealerAppointmentListResponse>[];
      json['response'].forEach((v) {
        response!.add(new HealerAppointmentListResponse.fromJson(v));
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

class HealerAppointmentListResponse {
  String? clProfile;
  String? clientName;
  String? therapyName;
  String? date;
  String? slot;
  String? address;
  String? clientEmail;
  String? clientMobile;
  String? status;

  HealerAppointmentListResponse(
      {this.clProfile,
        this.clientName,
        this.therapyName,
        this.date,
        this.slot,
        this.address,
        this.clientEmail,
        this.clientMobile,
        this.status});

  HealerAppointmentListResponse.fromJson(Map<String, dynamic> json) {
    clProfile = json['cl_profile'];
    clientName = json['client_name'];
    therapyName = json['therapy_name'];
    date = json['date'];
    slot = json['slot'];
    address = json['address'];
    clientEmail = json['client_email'];
    clientMobile = json['client_mobile'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cl_profile'] = this.clProfile;
    data['client_name'] = this.clientName;
    data['therapy_name'] = this.therapyName;
    data['date'] = this.date;
    data['slot'] = this.slot;
    data['address'] = this.address;
    data['client_email'] = this.clientEmail;
    data['client_mobile'] = this.clientMobile;
    data['status'] = this.status;
    return data;
  }
}
