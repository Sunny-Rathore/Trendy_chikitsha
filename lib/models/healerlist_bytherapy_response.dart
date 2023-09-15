class HealerListByTherapy {
  String? status;
  String? msg;
  List<HealerListByTherapyResponse>? response;

  HealerListByTherapy({this.status, this.msg, this.response});

  HealerListByTherapy.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['response'] != null) {
      response = <HealerListByTherapyResponse>[];
      json['response'].forEach((v) {
        response!.add(HealerListByTherapyResponse.fromJson(v));
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

class HealerListByTherapyResponse {
  String? healerId;
  String? healerUniqueId;
  String? healerName;
  String? healerProfile;
  String? experience;

  HealerListByTherapyResponse(
      {this.healerId,
        this.healerUniqueId,
        this.healerName,
        this.healerProfile,
        this.experience});

  HealerListByTherapyResponse.fromJson(Map<String, dynamic> json) {
    healerId = json['healer_id'];
    healerUniqueId = json['healer_unique_id'];
    healerName = json['healer_name'];
    healerProfile = json['healer_profile'];
    experience = json['experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['healer_id'] = healerId;
    data['healer_unique_id'] = healerUniqueId;
    data['healer_name'] = healerName;
    data['healer_profile'] = healerProfile;
    data['experience'] = experience;
    return data;
  }
}
