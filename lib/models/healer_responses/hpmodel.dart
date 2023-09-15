class UpdateHpmodel {
  String? status;
  String? response;
  String? healerId;
  String? healerName;
  String? healerProfile;
  String? healerEmail;
  String? healerTelephone;
  String? healerAge;
  String? dateOfBirth;
  String? gender;
  String? address;
  String? pinCode;
  String? about;
  String? keywords;
  String? videoLink;
  String? subscriptionPlan;
  int? expireStatus;
  List<Expertise>? expertise;
  List<Pricing>? pricing;

  UpdateHpmodel(
      {this.status,
      this.response,
      this.healerId,
      this.healerName,
      this.healerProfile,
      this.healerEmail,
      this.healerTelephone,
      this.healerAge,
      this.dateOfBirth,
      this.gender,
      this.address,
      this.pinCode,
      this.about,
      this.keywords,
      this.videoLink,
      this.subscriptionPlan,
      this.expireStatus,
      this.expertise,
      this.pricing});

  UpdateHpmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    healerId = json['healer_id'];
    healerName = json['healer_name'];
    healerProfile = json['healer_profile'];
    healerEmail = json['healer_email'];
    healerTelephone = json['healer_telephone'];
    healerAge = json['healer_age'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    address = json['address'];
    pinCode = json['pin_code'];
    about = json['about'];
    keywords = json['keywords'];
    videoLink = json['video_link'];
    subscriptionPlan = json['subscription_plan'];
    expireStatus = json['expire_status'];
    if (json['expertise'] != null) {
      expertise = <Expertise>[];
      json['expertise'].forEach((v) {
        expertise!.add(Expertise.fromJson(v));
      });
    }
    if (json['pricing'] != null) {
      pricing = <Pricing>[];
      json['pricing'].forEach((v) {
        pricing!.add(Pricing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['response'] = response;
    data['healer_id'] = healerId;
    data['healer_name'] = healerName;
    data['healer_profile'] = healerProfile;
    data['healer_email'] = healerEmail;
    data['healer_telephone'] = healerTelephone;
    data['healer_age'] = healerAge;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['address'] = address;
    data['pin_code'] = pinCode;
    data['about'] = about;
    data['keywords'] = keywords;
    data['video_link'] = videoLink;
    data['subscription_plan'] = subscriptionPlan;
    data['expire_status'] = expireStatus;
    if (expertise != null) {
      data['expertise'] = expertise!.map((v) => v.toJson()).toList();
    }
    if (pricing != null) {
      data['pricing'] = pricing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Expertise {
  String? count;
  String? expertiseId;
  String? therapyName1;
  String? issues1;
  String? experienceYear1;
  String? experienceMonth1;
  String? therapyCertificate1;

  Expertise(
      {this.count,
      this.expertiseId,
      this.therapyName1,
      this.issues1,
      this.experienceYear1,
      this.experienceMonth1,
      this.therapyCertificate1});

  Expertise.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    expertiseId = json['expertise_id'];
    therapyName1 = json['therapy_name1'];
    issues1 = json['issues1'];
    experienceYear1 = json['experience_year1'];
    experienceMonth1 = json['experience_month1'];
    therapyCertificate1 = json['therapy_certificate1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['expertise_id'] = expertiseId;
    data['therapy_name1'] = therapyName1;
    data['issues1'] = issues1;
    data['experience_year1'] = experienceYear1;
    data['experience_month1'] = experienceMonth1;
    data['therapy_certificate1'] = therapyCertificate1;
    return data;
  }
}

class Pricing {
  String? thId;
  String? therapyName;
  String? customPrice;

  Pricing({this.thId, this.therapyName, this.customPrice});

  Pricing.fromJson(Map<String, dynamic> json) {
    thId = json['th_id'];
    therapyName = json['therapy_name'];
    customPrice = json['custom_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['th_id'] = thId;
    data['therapy_name'] = therapyName;
    data['custom_price'] = customPrice;
    return data;
  }
}
