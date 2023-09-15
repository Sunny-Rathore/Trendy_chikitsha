class HealerChangePassResponse {
  String? status;
  String? msg;
  Response? response;

  HealerChangePassResponse({this.status, this.msg, this.response});

  HealerChangePassResponse.fromJson(Map<String, dynamic> json) {
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
  String? hPassword;

  Response({this.hPassword});

  Response.fromJson(Map<String, dynamic> json) {
    hPassword = json['h_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['h_password'] = hPassword;
    return data;
  }
}
