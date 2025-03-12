// To parse this JSON data, do
//
//     final payNowRespons = payNowResponsFromJson(jsonString);

import 'dart:convert';

PayNowRespons payNowResponsFromJson(String str) => PayNowRespons.fromJson(json.decode(str));

String payNowResponsToJson(PayNowRespons data) => json.encode(data.toJson());

class PayNowRespons {
    bool status;
    String url;
    String orderId;
    String requestId;

    PayNowRespons({
        required this.status,
        required this.url,
        required this.orderId,
        required this.requestId,
    });

    factory PayNowRespons.fromJson(Map<String, dynamic> json) => PayNowRespons(
        status: json["status"],
        url: json["url"],
        orderId: json["order_id"],
        requestId: json["request_id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "url": url,
        "order_id": orderId,
        "request_id": requestId,
    };
}
