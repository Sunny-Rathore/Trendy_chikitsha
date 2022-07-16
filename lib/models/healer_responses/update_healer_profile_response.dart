class UpdateHealerResponse {
  String? status;
  String? msg;
  String? response;

  UpdateHealerResponse({this.status, this.msg, this.response});

  UpdateHealerResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['response'] = this.response;
    return data;
  }
}
