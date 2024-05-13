// To parse this JSON data, do
//
//     final typeOfHoursDpModel = typeOfHoursDpModelFromJson(jsonString);

import 'dart:convert';

TypeOfHoursDpModel typeOfHoursDpModelFromJson(String str) => TypeOfHoursDpModel.fromJson(json.decode(str));

String typeOfHoursDpModelToJson(TypeOfHoursDpModel data) => json.encode(data.toJson());

class TypeOfHoursDpModel {
    final List<Datum> data;
    final String message;
    final bool success;
    final String messages;

    TypeOfHoursDpModel({
        required this.data,
        required this.message,
        required this.success,
        required this.messages,
    });

    factory TypeOfHoursDpModel.fromJson(Map<String, dynamic> json) => TypeOfHoursDpModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
    final String dropId;
    final String dropValue;

    Datum({
        required this.dropId,
        required this.dropValue,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        dropId: json["drop_id"],
        dropValue: json["drop_value"],
    );

    Map<String, dynamic> toJson() => {
        "drop_id": dropId,
        "drop_value": dropValue,
    };
}
