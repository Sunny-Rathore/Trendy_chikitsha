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
  String? videoLink;
  List<Expertise>? expertise;
  List<Pricing>? pricing;

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
        this.pricing});

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
    if (json['expertise'] != null) {
      expertise = <Expertise>[];
      json['expertise'].forEach((v) {
        expertise!.add(new Expertise.fromJson(v));
      });
    }
    if (json['pricing'] != null) {
      pricing = <Pricing>[];
      json['pricing'].forEach((v) {
        pricing!.add(new Pricing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['healer_id'] = this.healerId;
    data['healer_name'] = this.healerName;
    data['healer_profile'] = this.healerProfile;
    data['healer_email'] = this.healerEmail;
    data['healer_telephone'] = this.healerTelephone;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['pin_code'] = this.pinCode;
    data['about'] = this.about;
    data['keywords'] = this.keywords;
    data['video_link'] = this.videoLink;
    if (this.expertise != null) {
      data['expertise'] = this.expertise!.map((v) => v.toJson()).toList();
    }
    if (this.pricing != null) {
      data['pricing'] = this.pricing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Expertise {
  String? count;
  String? therapyName1;
  String? issues1;
  String? experienceYear1;
  String? experienceMonth1;
  String? therapyCertificate1;

  Expertise(
      {this.count,
        this.therapyName1,
        this.issues1,
        this.experienceYear1,
        this.experienceMonth1,
        this.therapyCertificate1});

  Expertise.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    therapyName1 = json['therapy_name1'];
    issues1 = json['issues1'];
    experienceYear1 = json['experience_year1'];
    experienceMonth1 = json['experience_month1'];
    therapyCertificate1 = json['therapy_certificate1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['therapy_name1'] = this.therapyName1;
    data['issues1'] = this.issues1;
    data['experience_year1'] = this.experienceYear1;
    data['experience_month1'] = this.experienceMonth1;
    data['therapy_certificate1'] = this.therapyCertificate1;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['th_id'] = this.thId;
    data['therapy_name'] = this.therapyName;
    data['custom_price'] = this.customPrice;
    return data;
  }
}
