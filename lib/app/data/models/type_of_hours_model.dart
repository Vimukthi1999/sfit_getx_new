// To parse this JSON data, do
//
//     final typeofHoursDpModel = typeofHoursDpModelFromJson(jsonString);

import 'dart:convert';

TypeofHoursDpModel typeofHoursDpModelFromJson(String str) => TypeofHoursDpModel.fromJson(json.decode(str));

String typeofHoursDpModelToJson(TypeofHoursDpModel data) => json.encode(data.toJson());

class TypeofHoursDpModel {
    final List<DatumTypeofHours> data;
    final String message;
    final bool success;
    final String messages;

    TypeofHoursDpModel({
        required this.data,
        required this.message,
        required this.success,
        required this.messages,
    });

    factory TypeofHoursDpModel.fromJson(Map<String, dynamic> json) => TypeofHoursDpModel(
        data: List<DatumTypeofHours>.from(json["data"].map((x) => DatumTypeofHours.fromJson(x))),
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

class DatumTypeofHours {
    final String dropId;
    final String dropValue;

    DatumTypeofHours({
        required this.dropId,
        required this.dropValue,
    });

    factory DatumTypeofHours.fromJson(Map<String, dynamic> json) => DatumTypeofHours(
        dropId: json["drop_id"],
        dropValue: json["drop_value"],
    );

    Map<String, dynamic> toJson() => {
        "drop_id": dropId,
        "drop_value": dropValue,
    };
}
