class HealerReviewListResponse {
  String? status;
  String? msg;
  List<Response>? response;

  HealerReviewListResponse({this.status, this.msg, this.response});

  HealerReviewListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
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

class Response {
  String? appointmentId;
  String? clientName;
  String? therapyName;
  String? review;
  String? rate;
  String? date;

  Response(
      {this.appointmentId,
        this.clientName,
        this.therapyName,
        this.review,
        this.rate,
        this.date});

  Response.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    clientName = json['client_name'];
    therapyName = json['therapy_name'];
    review = json['review'];
    rate = json['rate'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointment_id'] = appointmentId;
    data['client_name'] = clientName;
    data['therapy_name'] = therapyName;
    data['review'] = review;
    data['rate'] = rate;
    data['date'] = date;
    return data;
  }
}
