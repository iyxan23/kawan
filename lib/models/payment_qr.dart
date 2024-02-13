// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PaymentQr paymentQrFromJson(String str) => PaymentQr.fromJson(json.decode(str));

String paymentQrToJson(PaymentQr data) => json.encode(data.toJson());

class PaymentQr {
    final String description;
    final int amount;

    PaymentQr({
        required this.description,
        required this.amount,
    });

    factory PaymentQr.fromJson(Map<String, dynamic> json) => PaymentQr(
        description: json["description"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "amount": amount,
    };
}