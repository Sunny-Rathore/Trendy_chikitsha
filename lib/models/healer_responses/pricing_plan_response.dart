class PricingPlanResponse {
  String? status;
  String? msg;
  Response? response;

  PricingPlanResponse({this.status, this.msg, this.response});

  PricingPlanResponse.fromJson(Map<String, dynamic> json) {
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
  int? hPosition;
  String? subscriptionPlan;

  Response({this.hPosition, this.subscriptionPlan});

  Response.fromJson(Map<String, dynamic> json) {
    hPosition = json['h_position'];
    subscriptionPlan = json['subscription_plan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['h_position'] = hPosition;
    data['subscription_plan'] = subscriptionPlan;
    return data;
  }
}
