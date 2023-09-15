class AddTimeSlotsResponse {
  String? status;
  String? msg;
  List<Response>? response;

  AddTimeSlotsResponse({this.status, this.msg, this.response});

  AddTimeSlotsResponse.fromJson(Map<String, dynamic> json) {
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
  String? healerId;
  String? shStart;
  String? shEnd;
  String? shDay;
  String? createDate;

  Response(
      {this.healerId, this.shStart, this.shEnd, this.shDay, this.createDate});

  Response.fromJson(Map<String, dynamic> json) {
    healerId = json['healer_id'];
    shStart = json['sh_start'];
    shEnd = json['sh_end'];
    shDay = json['sh_day'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['healer_id'] = healerId;
    data['sh_start'] = shStart;
    data['sh_end'] = shEnd;
    data['sh_day'] = shDay;
    data['create_date'] = createDate;
    return data;
  }
}
