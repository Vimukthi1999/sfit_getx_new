// To parse this JSON data, do
//
//     final contractDpModel = contractDpModelFromJson(jsonString);

import 'dart:convert';

ContractDpModel contractDpModelFromJson(String str) => ContractDpModel.fromJson(json.decode(str));

String contractDpModelToJson(ContractDpModel data) => json.encode(data.toJson());

class ContractDpModel {
  final List<DatumContract> data;
  final String message;
  final bool success;
  // final String messages;

  ContractDpModel({
    required this.data,
    required this.message,
    required this.success,
    // required this.messages,
  });

  factory ContractDpModel.fromJson(Map<String, dynamic> json) => ContractDpModel(
        data: List<DatumContract>.from(json["data"].map((x) => DatumContract.fromJson(x))),
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

class DatumContract {
  final String dropId;
  final String dropValue;

  DatumContract({
    required this.dropId,
    required this.dropValue,
  });

  factory DatumContract.fromJson(Map<String, dynamic> json) => DatumContract(
        dropId: json["drop_id"],
        dropValue: json["drop_value"],
      );

  Map<String, dynamic> toJson() => {
        "drop_id": dropId,
        "drop_value": dropValue,
      };
}
