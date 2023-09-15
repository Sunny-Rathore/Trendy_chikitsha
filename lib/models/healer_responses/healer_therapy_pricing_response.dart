class HealerTherapyPricingResponse {
  String? status;
  String? msg;
  List<Response>? response;

  HealerTherapyPricingResponse({this.status, this.msg, this.response});

  HealerTherapyPricingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  String? thId;
  String? healerId;
  String? therapyName;
  String? customPrice;

  Response({this.thId, this.healerId, this.therapyName, this.customPrice});

  Response.fromJson(Map<String, dynamic> json) {
    thId = json['th_id'];
    healerId = json['healer_id'];
    therapyName = json['therapy_name'];
    customPrice = json['custom_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['th_id'] = thId;
    data['healer_id'] = healerId;
    data['therapy_name'] = therapyName;
    data['custom_price'] = customPrice;
    return data;
  }
}
