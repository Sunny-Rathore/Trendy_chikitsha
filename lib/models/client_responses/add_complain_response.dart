class AddComplainResponse {
  String? status;
  String? msg;
  Response? response;

  AddComplainResponse({this.status, this.msg, this.response});

  AddComplainResponse.fromJson(Map<String, dynamic> json) {
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
  String? gComment;
  String? gUserid;
  String? gDate;
  String? gTicket;

  Response({this.gComment, this.gUserid, this.gDate, this.gTicket});

  Response.fromJson(Map<String, dynamic> json) {
    gComment = json['g_comment'];
    gUserid = json['g_userid'];
    gDate = json['g_date'];
    gTicket = json['g_ticket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['g_comment'] = gComment;
    data['g_userid'] = gUserid;
    data['g_date'] = gDate;
    data['g_ticket'] = gTicket;
    return data;
  }
}
