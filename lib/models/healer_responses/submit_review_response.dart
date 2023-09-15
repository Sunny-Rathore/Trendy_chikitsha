class SubmitReviewResponse {
  String? status;
  String? msg;
  Response? response;

  SubmitReviewResponse({this.status, this.msg, this.response});

  SubmitReviewResponse.fromJson(Map<String, dynamic> json) {
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
  String? appointmentId;
  String? therapyName;
  String? clientId;
  String? healerId;
  String? review;
  String? rate;
  String? date;

  Response(
      {this.appointmentId,
        this.therapyName,
        this.clientId,
        this.healerId,
        this.review,
        this.rate,
        this.date});

  Response.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    therapyName = json['therapy_name'];
    clientId = json['client_id'];
    healerId = json['healer_id'];
    review = json['review'];
    rate = json['rate'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointment_id'] = appointmentId;
    data['therapy_name'] = therapyName;
    data['client_id'] = clientId;
    data['healer_id'] = healerId;
    data['review'] = review;
    data['rate'] = rate;
    data['date'] = date;
    return data;
  }
}
