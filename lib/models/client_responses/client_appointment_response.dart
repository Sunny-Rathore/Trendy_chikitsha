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
        response!.add(AppointmentResponse.fromJson(v));
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

class AppointmentResponse {
  String? healerProfile;
  String? healerName;
  String? therapyName;
  String? date;
  String? slot;
  String? address;
  String? healerEmail;
  String? healerMobile;
  String? meeting_id;
  String? status,book_id, amount ;

  AppointmentResponse(
      {this.healerProfile,
        this.healerName,
        this.therapyName,
        this.date,
        this.slot,
        this.address,
        this.healerEmail,
        this.healerMobile,
        this.status, this.book_id, this.meeting_id, this.amount});

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
    book_id=json['book_id'];
    meeting_id=json['meeting_id'];
    amount=json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['healer_profile'] = healerProfile;
    data['healer_name'] = healerName;
    data['therapy_name'] = therapyName;
    data['date'] = date;
    data['slot'] = slot;
    data['address'] = address;
    data['healer_email'] = healerEmail;
    data['healer_mobile'] = healerMobile;
    data['status'] = status;
    data['book_id']=book_id;
    data['meeting_id']=meeting_id;
    data['amount']=amount;

    return data;
  }
}
