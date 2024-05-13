// To parse this JSON data, do
//
//     final toBePaidInDpModel = toBePaidInDpModelFromJson(jsonString);

import 'dart:convert';

ToBePaidInDpModel toBePaidInDpModelFromJson(String str) => ToBePaidInDpModel.fromJson(json.decode(str));

String toBePaidInDpModelToJson(ToBePaidInDpModel data) => json.encode(data.toJson());

class ToBePaidInDpModel {
    final List<DatumToBePaidIn> data;
    final String message;
    final bool success;
    final String messages;

    ToBePaidInDpModel({
        required this.data,
        required this.message,
        required this.success,
        required this.messages,
    });

    factory ToBePaidInDpModel.fromJson(Map<String, dynamic> json) => ToBePaidInDpModel(
        data: List<DatumToBePaidIn>.from(json["data"].map((x) => DatumToBePaidIn.fromJson(x))),
        message: json["message"],
        success: json["success"],
        messages: json["messages"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "success": success,
        "messages": messages,
    };
}

class DatumToBePaidIn {
    final String dropId;
    final String dropValue;

    DatumToBePaidIn({
        required this.dropId,
        required this.dropValue,
    });

    factory DatumToBePaidIn.fromJson(Map<String, dynamic> json) => DatumToBePaidIn(
        dropId: json["drop_id"],
        dropValue: json["drop_value"],
    );

    Map<String, dynamic> toJson() => {
        "drop_id": dropId,
        "drop_value": dropValue,
    };
}
