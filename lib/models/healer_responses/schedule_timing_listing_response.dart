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
        response!.add(ScheduleResponse.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sh_id'] = shId;
    data['sh_day'] = shDay;
    data['sh_start'] = shStart;
    data['sh_end'] = shEnd;
    data['healer_id'] = healerId;
    return data;
  }
}
