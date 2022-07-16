class HealerChangePassResponse {
  String? status;
  String? msg;
  Response? response;

  HealerChangePassResponse({this.status, this.msg, this.response});

  HealerChangePassResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  String? hPassword;

  Response({this.hPassword});

  Response.fromJson(Map<String, dynamic> json) {
    hPassword = json['h_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h_password'] = this.hPassword;
    return data;
  }
}
