class TopFeaturedHealers {
  String? status;
  String? msg;
  List<TopFeaturedHealersResponse>? response;

  TopFeaturedHealers({this.status, this.msg, this.response});

  TopFeaturedHealers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['response'] != null) {
      response = <TopFeaturedHealersResponse>[];
      json['response'].forEach((v) {
        response!.add(TopFeaturedHealersResponse.fromJson(v));
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

class TopFeaturedHealersResponse {
  String? healerId;
  String? healerName;
  String? healerUniqueId;
  String? healerImage;
  String? therapyName;
  String? experience;

  TopFeaturedHealersResponse(
      {this.healerId,
        this.healerName,
        this.healerUniqueId,
        this.healerImage,
        this.therapyName,
        this.experience});

  TopFeaturedHealersResponse.fromJson(Map<String, dynamic> json) {
    healerId = json['healer_id'];
    healerName = json['healer_name'];
    healerUniqueId = json['healer_unique_id'];
    healerImage = json['healer_image'];
    therapyName = json['therapy_name'];
    experience = json['experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['healer_id'] = healerId;
    data['healer_name'] = healerName;
    data['healer_unique_id'] = healerUniqueId;
    data['healer_image'] = healerImage;
    data['therapy_name'] = therapyName;
    data['experience'] = experience;
    return data;
  }
}
