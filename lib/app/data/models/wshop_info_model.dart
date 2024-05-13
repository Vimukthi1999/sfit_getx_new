// To parse this JSON data, do
//
//     final wShopInfoModel = wShopInfoModelFromJson(jsonString);

import 'dart:convert';

WShopInfoModel wShopInfoModelFromJson(String str) => WShopInfoModel.fromJson(json.decode(str));

String wShopInfoModelToJson(WShopInfoModel data) => json.encode(data.toJson());

class WShopInfoModel {
    final List<WshopInfo> wshopInfo;

    WShopInfoModel({
        required this.wshopInfo,
    });

    factory WShopInfoModel.fromJson(Map<String, dynamic> json) => WShopInfoModel(
        wshopInfo: List<WshopInfo>.from(json["wshop_info"].map((x) => WshopInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "wshop_info": List<dynamic>.from(wshopInfo.map((x) => x.toJson())),
    };
}

class WshopInfo {
    final String itemDes;
    final String item;
    final String usrDesc;
    final String sp;
    final String uom;
    final String quantity;
    final String purpose;
    final String serialNo;

    WshopInfo({
        required this.itemDes,
        required this.item,
        required this.usrDesc,
        required this.sp,
        required this.uom,
        required this.quantity,
        required this.purpose,
        required this.serialNo,
    });

    factory WshopInfo.fromJson(Map<String, dynamic> json) => WshopInfo(
        itemDes: json["item_des"],
        item: json["item"],
        usrDesc: json["usr_desc"],
        sp: json["sp"],
        uom: json["uom"],
        quantity: json["quantity"],
        purpose: json["purpose"],
        serialNo: json["serial_no"],
    );

    Map<String, dynamic> toJson() => {
        "item_des": itemDes,
        "item": item,
        "usr_desc": usrDesc,
        "sp": sp,
        "uom": uom,
        "quantity": quantity,
        "purpose": purpose,
        "serial_no": serialNo,
    };
}
