class HealerProfileFetchData {
  String? status;
  String? response;
  String? healerId;
  String? healerName;
  String? healerProfile;
  String? healerEmail;
  String? healerTelephone;
  String? dateOfBirth;
  String? gender;
  String? address;
  String? pinCode;
  String? about;
  String? keywords;
  String? videoLink, healer_age;
  List<Expertise>? expertise;
  List<Pricing>? pricing;
  int? expire_status;

  HealerProfileFetchData(
      {this.status,
        this.response,
        this.healerId,
        this.healerName,
        this.healerProfile,
        this.healerEmail,
        this.healerTelephone,
        this.dateOfBirth,
        this.gender,
        this.address,
        this.pinCode,
        this.about,
        this.keywords,
        this.videoLink,
        this.expertise,
        this.pricing, this.healer_age,this.expire_status});

  HealerProfileFetchData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    healerId = json['healer_id'];
    healerName = json['healer_name'];
    healerProfile = json['healer_profile'];
    healerEmail = json['healer_email'];
    healerTelephone = json['healer_telephone'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    address = json['address'];
    pinCode = json['pin_code'];
    about = json['about'];
    keywords = json['keywords'];
    videoLink = json['video_link'];
healer_age= json['healer_age'];
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
    expire_status = json['expire_status'];

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
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['address'] = address;
    data['pin_code'] = pinCode;
    data['about'] = about;
    data['keywords'] = keywords;
    data['video_link'] = videoLink;
    data['healer_age'] = healer_age;
    if (expertise != null) {
      data['expertise'] = expertise!.map((v) => v.toJson()).toList();
    }
    if (pricing != null) {
      data['pricing'] = pricing!.map((v) => v.toJson()).toList();
    }
    data['expire_status'] = expire_status;

    return data;
  }
}

class Expertise {
  String? count;
  String? therapyName1;
  String? issues1;
  String? expertise_id;
  String? experienceYear1;
  String? experienceMonth1;
  String? therapyCertificate1;

  Expertise(
      {this.count,
        this.therapyName1,
        this.issues1,
        this.experienceYear1,
        this.experienceMonth1,
        this.therapyCertificate1, this.expertise_id});

  Expertise.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    therapyName1 = json['therapy_name1'];
    issues1 = json['issues1'];
    experienceYear1 = json['experience_year1'];
    experienceMonth1 = json['experience_month1'];
    therapyCertificate1 = json['therapy_certificate1'];
    expertise_id=json['expertise_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['therapy_name1'] = therapyName1;
    data['issues1'] = issues1;
    data['experience_year1'] = experienceYear1;
    data['experience_month1'] = experienceMonth1;
    data['therapy_certificate1'] = therapyCertificate1;
    data['expertise_id'] = expertise_id;
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
