class UpgradePlanResponse {
  String? status;
  String? msg;
  Response? response;

  UpgradePlanResponse({this.status, this.msg, this.response});

  UpgradePlanResponse.fromJson(Map<String, dynamic> json) {
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
  String? amount;
  String? subscriptionPlan;
  String? subscriptionEnd;
  String? subscriptionDate;

  Response(
      {this.amount,
        this.subscriptionPlan,
        this.subscriptionEnd,
        this.subscriptionDate});

  Response.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    subscriptionPlan = json['subscription_plan'];
    subscriptionEnd = json['subscription_end'];
    subscriptionDate = json['subscription_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['subscription_plan'] = subscriptionPlan;
    data['subscription_end'] = subscriptionEnd;
    data['subscription_date'] = subscriptionDate;
    return data;
  }
}
