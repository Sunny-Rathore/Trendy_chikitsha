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
        response!.add(new Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['th_id'] = this.thId;
    data['healer_id'] = this.healerId;
    data['therapy_name'] = this.therapyName;
    data['custom_price'] = this.customPrice;
    return data;
  }
}
