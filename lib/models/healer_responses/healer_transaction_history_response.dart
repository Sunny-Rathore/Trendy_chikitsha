class HealerTransactionHistoryResponse {
  String? status;
  String? msg;
  List<Response>? response;

  HealerTransactionHistoryResponse({this.status, this.msg, this.response});

  HealerTransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
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
  String? createDate,paid_by;

  Response(
      {this.tId, this.txnId, this.productInfo, this.amount, this.createDate, this.paid_by});

  Response.fromJson(Map<String, dynamic> json) {
    tId = json['t_id'];
    txnId = json['txn_id'];
    productInfo = json['product_info'];
    amount = json['amount'];
    createDate = json['create_date'];
    paid_by=json['paid_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['t_id'] = tId;
    data['txn_id'] = txnId;
    data['product_info'] = productInfo;
    data['amount'] = amount;
    data['create_date'] = createDate;
    data['paid_by'] = paid_by;
    return data;
  }
}
