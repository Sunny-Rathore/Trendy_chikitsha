class SubmitProfessionTypeResponse {
  String? status;
  String? msg;
  Response? response;

  SubmitProfessionTypeResponse({this.status, this.msg, this.response});

  SubmitProfessionTypeResponse.fromJson(Map<String, dynamic> json) {
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
  String? profession;
  List<String>? professionIssue;
  String? cLinks;

  Response({this.profession, this.professionIssue, this.cLinks});

  Response.fromJson(Map<String, dynamic> json) {
    profession = json['profession'];
    professionIssue = json['profession_issue'].cast<String>();
    cLinks = json['c_links'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profession'] = profession;
    data['profession_issue'] = professionIssue;
    data['c_links'] = cLinks;
    return data;
  }
}
