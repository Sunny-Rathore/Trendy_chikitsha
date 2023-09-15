class ComplainListResponse {
  String? status;
  String? msg;
  List<Response>? response;

  ComplainListResponse({this.status, this.msg, this.response});

  ComplainListResponse.fromJson(Map<String, dynamic> json) {
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
  String? status;
  String? ticketId;
  String? comment;
  String? date;

  Response({this.status, this.ticketId, this.comment, this.date});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    ticketId = json['ticket_id'];
    comment = json['comment'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['ticket_id'] = ticketId;
    data['comment'] = comment;
    data['date'] = date;
    return data;
  }
}
