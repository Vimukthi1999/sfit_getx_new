// To parse this JSON data, do
//
//     final assetCodeDetailsModel = assetCodeDetailsModelFromJson(jsonString);

import 'dart:convert';

AssetCodeDetailsModel assetCodeDetailsModelFromJson(String str) => AssetCodeDetailsModel.fromJson(json.decode(str));

String assetCodeDetailsModelToJson(AssetCodeDetailsModel data) => json.encode(data.toJson());

class AssetCodeDetailsModel {
    final AssetData data;
    final String message;
    final bool success;
    final Messages messages;

    AssetCodeDetailsModel({
        required this.data,
        required this.message,
        required this.success,
        required this.messages,
    });

    factory AssetCodeDetailsModel.fromJson(Map<String, dynamic> json) => AssetCodeDetailsModel(
        data: AssetData.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
        messages: Messages.fromJson(json["messages"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "success": success,
        "messages": messages.toJson(),
    };
}

class AssetData {
    final AssetDet assetDet;
    final List<ContractDet> contractDet;
    final CompanyDet companyDet;
    final SiteDet siteDet;

    AssetData({
        required this.assetDet,
        required this.contractDet,
        required this.companyDet,
        required this.siteDet,
    });

    factory AssetData.fromJson(Map<String, dynamic> json) => AssetData(
        assetDet: AssetDet.fromJson(json["asset_det"]),
        contractDet: List<ContractDet>.from(json["contract_det"].map((x) => ContractDet.fromJson(x))),
        companyDet: CompanyDet.fromJson(json["company_det"]),
        siteDet: SiteDet.fromJson(json["site_det"]),
    );

    Map<String, dynamic> toJson() => {
        "asset_det": assetDet.toJson(),
        "contract_det": List<dynamic>.from(contractDet.map((x) => x.toJson())),
        "company_det": companyDet.toJson(),
        "site_det": siteDet.toJson(),
    };
}

class AssetDet {
    var attrMactype;
    var siteId;
    final List<dynamic> svcformsForasset;
    final List<dynamic> ticketsForasset;
    var ateraUrl;

    AssetDet({
        required this.attrMactype,
        required this.siteId,
        required this.svcformsForasset,
        required this.ticketsForasset,
        required this.ateraUrl,
    });

    factory AssetDet.fromJson(Map<String, dynamic> json) => AssetDet(
        attrMactype: json["attr_mactype"],
        siteId: json["site_id"],
        svcformsForasset: List<dynamic>.from(json["svcforms_forasset"].map((x) => x)),
        ticketsForasset: List<dynamic>.from(json["tickets_forasset"].map((x) => x)),
        ateraUrl: json["atera_url"],
    );

    Map<String, dynamic> toJson() => {
        "attr_mactype": attrMactype,
        "site_id": siteId,
        "svcforms_forasset": List<dynamic>.from(svcformsForasset.map((x) => x)),
        "tickets_forasset": List<dynamic>.from(ticketsForasset.map((x) => x)),
        "atera_url": ateraUrl,
    };
}

class CompanyDet {
    var companyId;
    var companyName;
    var crDays;

    CompanyDet({
        required this.companyId,
        required this.companyName,
        required this.crDays,
    });

    factory CompanyDet.fromJson(Map<String, dynamic> json) => CompanyDet(
        companyId: json["company_id"],
        companyName: json["company_name"],
        crDays: json["cr_days"],
    );

    Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "company_name": companyName,
        "cr_days": crDays,
    };
}

class ContractDet {
    var contractId;
    var contractDescription;
    var siteId;
    var billingComp;

    ContractDet({
        required this.contractId,
        required this.contractDescription,
        required this.siteId,
        required this.billingComp,
    });

    factory ContractDet.fromJson(Map<String, dynamic> json) => ContractDet(
        contractId: json["contract_id"],
        contractDescription: json["contract_description"],
        siteId: json["site_id"],
        billingComp: json["billing_comp"],
    );

    Map<String, dynamic> toJson() => {
        "contract_id": contractId,
        "contract_description": contractDescription,
        "site_id": siteId,
        "billing_comp": billingComp,
    };
}

class SiteDet {
    var siteId;
    var siteName;
    var address;
    var city;
    var srfno;
    var postcode;
    var phoneNo;
    var siteemail;
    final dynamic nofield;

    SiteDet({
        required this.siteId,
        required this.siteName,
        required this.address,
        required this.city,
        required this.srfno,
        required this.postcode,
        required this.phoneNo,
        required this.siteemail,
        this.nofield,
    });

    factory SiteDet.fromJson(Map<String, dynamic> json) => SiteDet(
        siteId: json["site_id"],
        siteName: json["site_name"],
        address: json["address"],
        city: json["city"],
        srfno: json["srfno"],
        postcode: json["postcode"],
        phoneNo: json["phone_no"],
        siteemail: json["siteemail"],
        nofield: json["nofield"],
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "site_name": siteName,
        "address": address,
        "city": city,
        "srfno": srfno,
        "postcode": postcode,
        "phone_no": phoneNo,
        "siteemail": siteemail,
        "nofield": nofield,
    };
}

class Messages {
    var passetCode;

    Messages({
        required this.passetCode,
    });

    factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        passetCode: json["passet_code"],
    );

    Map<String, dynamic> toJson() => {
        "passet_code": passetCode,
    };
}
