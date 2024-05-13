// To parse this JSON data, do
//
//     final companyDpModel = companyDpModelFromJson(jsonString);

import 'dart:convert';

CompanyDpModel companyDpModelFromJson(String str) => CompanyDpModel.fromJson(json.decode(str));

String companyDpModelToJson(CompanyDpModel data) => json.encode(data.toJson());

class CompanyDpModel {
    final List<DatumCompany> data;
    final String message;
    final bool success;
    // final String messages;

    CompanyDpModel({
        required this.data,
        required this.message,
        required this.success,
        // required this.messages,
    });

    factory CompanyDpModel.fromJson(Map<String, dynamic> json) => CompanyDpModel(
        data: List<DatumCompany>.from(json["data"].map((x) => DatumCompany.fromJson(x))),
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

class DatumCompany {
    final String dropId;
    final String dropValue;

    DatumCompany({
        required this.dropId,
        required this.dropValue,
    });

    factory DatumCompany.fromJson(Map<String, dynamic> json) => DatumCompany(
        dropId: json["drop_id"],
        dropValue: json["drop_value"],
    );

    Map<String, dynamic> toJson() => {
        "drop_id": dropId,
        "drop_value": dropValue,
    };
}
