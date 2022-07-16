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
        response!.add(new Response.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['healer_id'] = this.healerId;
    data['sh_start'] = this.shStart;
    data['sh_end'] = this.shEnd;
    data['sh_day'] = this.shDay;
    data['create_date'] = this.createDate;
    return data;
  }
}
