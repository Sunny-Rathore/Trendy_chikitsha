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
        response!.add(HealerAppointmentListResponse.fromJson(v));
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

class HealerAppointmentListResponse {
  String? clProfile;
  String? clientName;
  String? therapyName;
  String? date;
  String? slot;
  String? address;
  String? clientEmail;
  String? clientMobile;
  String? status,meeting_id, book_id;

  HealerAppointmentListResponse(
      {this.clProfile,
        this.clientName,
        this.therapyName,
        this.date,
        this.slot,
        this.address,
        this.clientEmail,
        this.clientMobile,
        this.status, this.meeting_id, this.book_id});

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
    meeting_id=json['meeting_id'];
    book_id=json['book_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cl_profile'] = clProfile;
    data['client_name'] = clientName;
    data['therapy_name'] = therapyName;
    data['date'] = date;
    data['slot'] = slot;
    data['address'] = address;
    data['client_email'] = clientEmail;
    data['client_mobile'] = clientMobile;
    data['status'] = status;
    data['meeting_id']=meeting_id;
    data['book_id']=book_id;
    return data;
  }
}
