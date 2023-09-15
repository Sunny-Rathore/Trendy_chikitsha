class ClientTransactionHistoryResponse {
  String? status;
  String? msg;
  List<Response>? response;

  ClientTransactionHistoryResponse({this.status, this.msg, this.response});

  ClientTransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
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

class Response {
  String? tId;
  String? txnId;
  String? productInfo;
  String? amount;
  String? createDate,paid_to;

  Response(
      {this.tId, this.txnId, this.productInfo, this.amount, this.createDate, this.paid_to});

  Response.fromJson(Map<String, dynamic> json) {
    tId = json['t_id'];
    txnId = json['txn_id'];
    productInfo = json['product_info'];
    amount = json['amount'];
    createDate = json['create_date'];
    paid_to=json['paid_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['t_id'] = tId;
    data['txn_id'] = txnId;
    data['product_info'] = productInfo;
    data['amount'] = amount;
    data['create_date'] = createDate;
    data['paid_to'] = paid_to;
    return data;
  }
}
