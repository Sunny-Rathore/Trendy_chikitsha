class TotalCountingResponse {
  String? status;
  String? msg;
  List<Response>? response;

  TotalCountingResponse({this.status, this.msg, this.response});

  TotalCountingResponse.fromJson(Map<String, dynamic> json) {
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
  int? todaysAppointments;
  int? upcomingAppointments;
  String? totalAmount;
  int? totalReviews;

  Response(
      {this.todaysAppointments,
        this.upcomingAppointments,
        this.totalAmount,
        this.totalReviews});

  Response.fromJson(Map<String, dynamic> json) {
    todaysAppointments = json['todays_appointments'];
    upcomingAppointments = json['upcoming_appointments'];
    totalAmount = json['total_amount'];
    totalReviews = json['total_reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['todays_appointments'] = todaysAppointments;
    data['upcoming_appointments'] = upcomingAppointments;
    data['total_amount'] = totalAmount;
    data['total_reviews'] = totalReviews;
    return data;
  }
}
