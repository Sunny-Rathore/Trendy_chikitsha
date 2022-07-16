class ScheduleTimeListingResponse {
  String? status;
  String? msg;
  List<ScheduleResponse>? response;

  ScheduleTimeListingResponse({this.status, this.msg, this.response});

  ScheduleTimeListingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['response'] != null) {
      response = <ScheduleResponse>[];
      json['response'].forEach((v) {
        response!.add(new ScheduleResponse.fromJson(v));
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

class ScheduleResponse {
  String? shId;
  String? shDay;
  String? shStart;
  String? shEnd;
  String? healerId;

  ScheduleResponse({this.shId, this.shDay, this.shStart, this.shEnd, this.healerId});

  ScheduleResponse.fromJson(Map<String, dynamic> json) {
    shId = json['sh_id'];
    shDay = json['sh_day'];
    shStart = json['sh_start'];
    shEnd = json['sh_end'];
    healerId = json['healer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sh_id'] = this.shId;
    data['sh_day'] = this.shDay;
    data['sh_start'] = this.shStart;
    data['sh_end'] = this.shEnd;
    data['healer_id'] = this.healerId;
    return data;
  }
}
