// To parse this JSON data, do
//
//     final assetCodeDpModel = assetCodeDpModelFromJson(jsonString);

import 'dart:convert';

AssetCodeDpModel assetCodeDpModelFromJson(String str) => AssetCodeDpModel.fromJson(json.decode(str));

String assetCodeDpModelToJson(AssetCodeDpModel data) => json.encode(data.toJson());

class AssetCodeDpModel {
    final List<DatumAssetCode> data;
    final String message;
    final bool success;

    AssetCodeDpModel({
        required this.data,
        required this.message,
        required this.success,
    });

    factory AssetCodeDpModel.fromJson(Map<String, dynamic> json) => AssetCodeDpModel(
        data: List<DatumAssetCode>.from(json["data"].map((x) => DatumAssetCode.fromJson(x))),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "success": success,
    };
}

class DatumAssetCode {
    final String dropId;
    final String dropValue;

    DatumAssetCode({
        required this.dropId,
        required this.dropValue,
    });

    factory DatumAssetCode.fromJson(Map<String, dynamic> json) => DatumAssetCode(
        dropId: json["drop_id"],
        dropValue: json["drop_value"],
    );

    Map<String, dynamic> toJson() => {
        "drop_id": dropId,
        "drop_value": dropValue,
    };
}
