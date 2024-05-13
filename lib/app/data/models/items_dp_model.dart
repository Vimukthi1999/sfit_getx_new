// To parse this JSON data, do
//
//     final itemDpModel = itemDpModelFromJson(jsonString);

import 'dart:convert';

ItemDpModel itemDpModelFromJson(String str) => ItemDpModel.fromJson(json.decode(str));

String itemDpModelToJson(ItemDpModel data) => json.encode(data.toJson());

class ItemDpModel {
    final List<DatumItems> data;
    final String message;
    final bool success;
    final String messages;

    ItemDpModel({
        required this.data,
        required this.message,
        required this.success,
        required this.messages,
    });

    factory ItemDpModel.fromJson(Map<String, dynamic> json) => ItemDpModel(
        data: List<DatumItems>.from(json["data"].map((x) => DatumItems.fromJson(x))),
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

class DatumItems {
    var itemCode;
    var itemDes;
    var itemId;
    var stdCostPerUnit;
    var minQty;

    DatumItems({
        required this.itemCode,
        required this.itemDes,
        required this.itemId,
        required this.stdCostPerUnit,
        required this.minQty,
    });

    factory DatumItems.fromJson(Map<String, dynamic> json) => DatumItems(
        itemCode: json["item_code"],
        itemDes: json["item_des"],
        itemId: json["item_id"],
        stdCostPerUnit: json["std_cost_per_unit"],
        minQty: json["min_qty"],
    );

    Map<String, dynamic> toJson() => {
        "item_code": itemCode,
        "item_des": itemDes,
        "item_id": itemId,
        "std_cost_per_unit": stdCostPerUnit,
        "min_qty": minQty,
    };
}
