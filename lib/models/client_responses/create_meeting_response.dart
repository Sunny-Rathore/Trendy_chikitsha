class CreateMeetingResponse {
  String? status;
  String? msg;
  String? response;

  CreateMeetingResponse({this.status, this.msg, this.response});

  CreateMeetingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['response'] = response;
    return data;
  }
}
