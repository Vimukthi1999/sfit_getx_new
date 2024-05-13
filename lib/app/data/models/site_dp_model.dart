// To parse this JSON data, do
//
//     final siteDpModel = siteDpModelFromJson(jsonString);

import 'dart:convert';

SiteDpModel siteDpModelFromJson(String str) => SiteDpModel.fromJson(json.decode(str));

String siteDpModelToJson(SiteDpModel data) => json.encode(data.toJson());

class SiteDpModel {
    final List<DatumSite> data;
    final String message;
    final bool success;
    // final String messages;

    SiteDpModel({
        required this.data,
        required this.message,
        required this.success,
        // required this.messages,
    });

    factory SiteDpModel.fromJson(Map<String, dynamic> json) => SiteDpModel(
        data: List<DatumSite>.from(json["data"].map((x) => DatumSite.fromJson(x))),
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

class DatumSite {
    final String dropId;
    final String dropValue;

    DatumSite({
        required this.dropId,
        required this.dropValue,
    });

    factory DatumSite.fromJson(Map<String, dynamic> json) => DatumSite(
        dropId: json["drop_id"],
        dropValue: json["drop_value"],
    );

    Map<String, dynamic> toJson() => {
        "drop_id": dropId,
        "drop_value": dropValue,
    };
}
