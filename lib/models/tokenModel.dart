class TokenModel {
  String? status;
  String? msg;
  String? response;

  TokenModel({this.status, this.msg, this.response});

  TokenModel.fromJson(Map<String, dynamic> json) {
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
