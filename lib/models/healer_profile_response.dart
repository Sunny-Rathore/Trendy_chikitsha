class HealerProfileResponse {
  String? status;
  String? msg;
  String? healerId,response;
  String? healerName;
  String? healerProfile;
  String? therapyName;
  String? experience;
  List<Slots>? slots;

  HealerProfileResponse(
      {this.status,
        this.msg,
        this.healerId,
        this.healerName,
        this.healerProfile,
        this.therapyName,
        this.experience,
        this.slots});

  HealerProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    healerId = json['healer_id'];
    healerName = json['healer_name'];
    healerProfile = json['healer_profile'];
    therapyName = json['therapy_name'];
    experience = json['experience'];
    response=json['response'];
    slots = <Slots>[];
    json['slots'].forEach((v) {
      slots!.add(Slots.fromJson(v));
    });

    /*
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }
*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['healer_id'] = healerId;
    data['healer_name'] = healerName;
    data['healer_profile'] = healerProfile;
    data['therapy_name'] = therapyName;
    data['response']=response;
    data['experience'] = experience;
    data['slots'] = slots!.map((v) => v.toJson()).toList();

    /* if (this.slots != null) {
      data['slots'] = this.slots!.map((v) => v.toJson()).toList();
    }
   */ return data;
  }
}

class Slots {
  String? slot, slotId;

  Slots({this.slot, this.slotId});

  Slots.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    slotId=json['slot_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slot'] = slot;
    data['slot_id'] = slotId;

    return data;
  }
}
