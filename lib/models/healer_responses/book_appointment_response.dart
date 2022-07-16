class BookAppointmentResponse {
  String? status;
  String? msg;
  Response? response;

  BookAppointmentResponse({this.status, this.msg, this.response});

  BookAppointmentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  String? bookingNumber;
  String? healerId;
  String? clientId;
  String? date;
  String? slotId;
  String? priceId;
  String? createDate;
  int? bookStatus;
  String? appointType;

  Response(
      {this.bookingNumber,
        this.healerId,
        this.clientId,
        this.date,
        this.slotId,
        this.priceId,
        this.createDate,
        this.bookStatus,
        this.appointType});

  Response.fromJson(Map<String, dynamic> json) {
    bookingNumber = json['booking_number'];
    healerId = json['healer_id'];
    clientId = json['client_id'];
    date = json['date'];
    slotId = json['slot_id'];
    priceId = json['price_id'];
    createDate = json['create_date'];
    bookStatus = json['book_status'];
    appointType = json['appoint_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_number'] = this.bookingNumber;
    data['healer_id'] = this.healerId;
    data['client_id'] = this.clientId;
    data['date'] = this.date;
    data['slot_id'] = this.slotId;
    data['price_id'] = this.priceId;
    data['create_date'] = this.createDate;
    data['book_status'] = this.bookStatus;
    data['appoint_type'] = this.appointType;
    return data;
  }
}
