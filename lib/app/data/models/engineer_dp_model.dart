// To parse this JSON data, do
//
//     final engineerDpModel = engineerDpModelFromJson(jsonString);

import 'dart:convert';

EngineerDpModel engineerDpModelFromJson(String str) => EngineerDpModel.fromJson(json.decode(str));

String engineerDpModelToJson(EngineerDpModel data) => json.encode(data.toJson());

class EngineerDpModel {
    final List<DatumEngineer> data;
    final String message;
    final bool success;
    // final String messages;

    EngineerDpModel({
        required this.data,
        required this.message,
        required this.success,
        // required this.messages,
    });

    factory EngineerDpModel.fromJson(Map<String, dynamic> json) => EngineerDpModel(
        data: List<DatumEngineer>.from(json["data"].map((x) => DatumEngineer.fromJson(x))),
        message: json["message"],
        success: json["success"],
        // messages: json["messages"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "success": success,
        // "messages": messages,
    };
}

class DatumEngineer {
    final String dropId;
    final String dropValue;

    DatumEngineer({
        required this.dropId,
        required this.dropValue,
    });

    factory DatumEngineer.fromJson(Map<String, dynamic> json) => DatumEngineer(
        dropId: json["drop_id"],
        dropValue: json["drop_value"],
    );

    Map<String, dynamic> toJson() => {
        "drop_id": dropId,
        "drop_value": dropValue,
    };
}
