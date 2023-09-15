class BookAppointmentResponse {
  String? status;
  String? msg;
  Response? response;

  BookAppointmentResponse({this.status, this.msg, this.response});

  BookAppointmentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    response = json['response'] != null
        ? Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (response != null) {
      data['response'] = response!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_number'] = bookingNumber;
    data['healer_id'] = healerId;
    data['client_id'] = clientId;
    data['date'] = date;
    data['slot_id'] = slotId;
    data['price_id'] = priceId;
    data['create_date'] = createDate;
    data['book_status'] = bookStatus;
    data['appoint_type'] = appointType;
    return data;
  }
}
