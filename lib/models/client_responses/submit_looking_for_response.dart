class SubmitLookingForResponse {
  String? status;
  String? msg;
  Response? response;

  SubmitLookingForResponse({this.status, this.msg, this.response});

  SubmitLookingForResponse.fromJson(Map<String, dynamic> json) {
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
  String? issueType;
  String? issues;
  String? cLinks;

  Response({this.issueType, this.issues, this.cLinks});

  Response.fromJson(Map<String, dynamic> json) {
    issueType = json['issue_type'];
    issues = json['issues'];
    cLinks = json['c_links'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['issue_type'] = issueType;
    data['issues'] = issues;
    data['c_links'] = cLinks;
    return data;
  }
}
