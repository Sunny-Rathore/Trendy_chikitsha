class PricingPlanResponse {
  String? status;
  String? msg;
  Response? response;

  PricingPlanResponse({this.status, this.msg, this.response});

  PricingPlanResponse.fromJson(Map<String, dynamic> json) {
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
  int? hPosition;
  String? subscriptionPlan;

  Response({this.hPosition, this.subscriptionPlan});

  Response.fromJson(Map<String, dynamic> json) {
    hPosition = json['h_position'];
    subscriptionPlan = json['subscription_plan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h_position'] = this.hPosition;
    data['subscription_plan'] = this.subscriptionPlan;
    return data;
  }
}
