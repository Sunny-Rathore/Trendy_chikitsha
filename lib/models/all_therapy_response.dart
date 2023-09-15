class AllTherapyResponse {
  String? status;
  String? msg;
  List<TherapyList>? response;

  AllTherapyResponse({this.status, this.msg, this.response});

  AllTherapyResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['response'] != null) {
      response = <TherapyList>[];
      json['response'].forEach((v) {
        response!.add(TherapyList.fromJson(v));
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

class TherapyList {
  String? therapyId;
  String? therapy_name,therapy_image;

  TherapyList({this.therapyId, this.therapy_name});

  TherapyList.fromJson(Map<String, dynamic> json) {
    therapyId = json['therapy_id'];
    therapy_name = json['therapy_name'];
    therapy_image=json['therapy_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['therapy_id'] = therapyId;
    data['therapy_name'] = therapy_name;
    data['therapy_image'] = therapy_image;
    return data;
  }
}
