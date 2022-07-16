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
        response!.add(new TopFeaturedHealersResponse.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['healer_id'] = this.healerId;
    data['healer_name'] = this.healerName;
    data['healer_unique_id'] = this.healerUniqueId;
    data['healer_image'] = this.healerImage;
    data['therapy_name'] = this.therapyName;
    data['experience'] = this.experience;
    return data;
  }
}
