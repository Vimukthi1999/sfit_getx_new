// To parse this JSON data, do
//
//     final sfDataModel = sfDataModelFromJson(jsonString);

import 'dart:convert';

SfDataModel sfDataModelFromJson(String str) => SfDataModel.fromJson(json.decode(str));

String sfDataModelToJson(SfDataModel data) => json.encode(data.toJson());

class SfDataModel {
  var message;
  var success;
  var messages;
  var data;

  SfDataModel({
    this.message,
    this.success,
    this.messages,
    this.data,
  });

  // SfDataModel.empty({this.message, this.success, this.messages, this.data});

  factory SfDataModel.fromJson(Map<String, dynamic> json) => SfDataModel(
        message: json["message"],
        success: json["success"],
        messages: json["messages"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "messages": messages,
        "data": data.toJson(),
      };
}

class Data {
  var action;
  var cusType;
  final List<SvcDatum> svcData;
  final List<dynamic> alasets;
  var assetLink;
  final List<dynamic> relTkts;
  var reqId;
  final List<SiteinfoFrmTkt> siteinfoFrmTkt;
  final List<ComInfoForSite> comInfoForSite;
  final List<ContractInfo> contractInfo;
  final List<dynamic> wshopInfo;
  var ticketPortalLink;
  var customerSigLink;

  Data({
    required this.action,
    required this.cusType,
    required this.svcData,
    required this.alasets,
    required this.assetLink,
    required this.relTkts,
    required this.reqId,
    required this.siteinfoFrmTkt,
    required this.comInfoForSite,
    required this.contractInfo,
    required this.wshopInfo,
    required this.ticketPortalLink,
    required this.customerSigLink,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        action: json["action"],
        cusType: json["cus_type"],
        svcData: List<SvcDatum>.from(json["svc_data"].map((x) => SvcDatum.fromJson(x))),
        alasets: List<dynamic>.from(json["alasets"].map((x) => x)),
        assetLink: json["asset_link"],
        relTkts: List<dynamic>.from(json["rel_tkts"].map((x) => x)),
        reqId: json["req_id"],
        siteinfoFrmTkt: List<SiteinfoFrmTkt>.from(json["siteinfo_frm_tkt"].map((x) => SiteinfoFrmTkt.fromJson(x))),
        comInfoForSite: List<ComInfoForSite>.from(json["com_info_for_site"].map((x) => ComInfoForSite.fromJson(x))),
        contractInfo: List<ContractInfo>.from(json["contract_info"].map((x) => ContractInfo.fromJson(x))),
        wshopInfo: List<dynamic>.from(json["wshop_info"].map((x) => x)),
        ticketPortalLink: json["ticket_portal_link"],
        customerSigLink: json["customer_sig_link"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "cus_type": cusType,
        "svc_data": List<dynamic>.from(svcData.map((x) => x.toJson())),
        "alasets": List<dynamic>.from(alasets.map((x) => x)),
        "asset_link": assetLink,
        "rel_tkts": List<dynamic>.from(relTkts.map((x) => x)),
        "req_id": reqId,
        "siteinfo_frm_tkt": List<dynamic>.from(siteinfoFrmTkt.map((x) => x.toJson())),
        "com_info_for_site": List<dynamic>.from(comInfoForSite.map((x) => x.toJson())),
        "contract_info": List<dynamic>.from(contractInfo.map((x) => x.toJson())),
        "wshop_info": List<dynamic>.from(wshopInfo.map((x) => x)),
        "ticket_portal_link": ticketPortalLink,
        "customer_sig_link": customerSigLink,
      };
}

class ComInfoForSite {
  var companyName;
  var companyId;

  ComInfoForSite({
    required this.companyName,
    required this.companyId,
  });

  factory ComInfoForSite.fromJson(Map<String, dynamic> json) => ComInfoForSite(
        companyName: json["company_name"],
        companyId: json["company_id"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "company_id": companyId,
      };
}

class ContractInfo {
  var contractId;
  var contractDescription;

  ContractInfo({
    required this.contractId,
    required this.contractDescription,
  });

  factory ContractInfo.fromJson(Map<String, dynamic> json) => ContractInfo(
        contractId: json["contract_id"],
        contractDescription: json["contract_description"],
      );

  Map<String, dynamic> toJson() => {
        "contract_id": contractId,
        "contract_description": contractDescription,
      };
}

class SiteinfoFrmTkt {
  var siteId;
  var siteName;
  var companyId;
  var address;
  var city;
  var state;
  var country;
  var phoneNo;
  var fax;
  var postcode;
  var siteemail;
  var srfno;
  var primaryUserId;
  var rowno;
  final DateTime lastSelectedOn;
  var contactPersn;
  var contactMobileNo;
  var siteFldrLink;
  final dynamic createdBy;
  var createdAt;
  var updatedBy;
  var updatedAt;
  var removeRec;

  SiteinfoFrmTkt({
    required this.siteId,
    required this.siteName,
    required this.companyId,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.phoneNo,
    required this.fax,
    required this.postcode,
    required this.siteemail,
    required this.srfno,
    required this.primaryUserId,
    required this.rowno,
    required this.lastSelectedOn,
    required this.contactPersn,
    required this.contactMobileNo,
    required this.siteFldrLink,
    this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
    required this.removeRec,
  });

  factory SiteinfoFrmTkt.fromJson(Map<String, dynamic> json) => SiteinfoFrmTkt(
        siteId: json["site_id"],
        siteName: json["site_name"],
        companyId: json["company_id"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        phoneNo: json["phone_no"],
        fax: json["fax"],
        postcode: json["postcode"],
        siteemail: json["siteemail"],
        srfno: json["srfno"],
        primaryUserId: json["primary_user_id"],
        rowno: json["rowno"],
        lastSelectedOn: DateTime.parse(json["last_selected_on"]),
        contactPersn: json["contact_persn"],
        contactMobileNo: json["contact_mobile_no"],
        siteFldrLink: json["site_fldr_link"],
        createdBy: json["created_by"],
        createdAt: json["created_at"],
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"],
        removeRec: json["remove_rec"],
      );

  Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "site_name": siteName,
        "company_id": companyId,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "phone_no": phoneNo,
        "fax": fax,
        "postcode": postcode,
        "siteemail": siteemail,
        "srfno": srfno,
        "primary_user_id": primaryUserId,
        "rowno": rowno,
        "last_selected_on": "${lastSelectedOn.year.toString().padLeft(4, '0')}-${lastSelectedOn.month.toString().padLeft(2, '0')}-${lastSelectedOn.day.toString().padLeft(2, '0')}",
        "contact_persn": contactPersn,
        "contact_mobile_no": contactMobileNo,
        "site_fldr_link": siteFldrLink,
        "created_by": createdBy,
        "created_at": createdAt,
        "updated_by": updatedBy,
        "updated_at": updatedAt,
        "remove_rec": removeRec,
      };
}

class SvcDatum {
  var serviceFormType;
  var contractId;
  var companyId;
  var siteId;
  var requestedDate;
  var delRequestedTime;
  var startDate;
  var delStartTime;
  var delEndTime;
  var delTravelTime;
  var totalTime;
  var problems;
  var recommendations;
  var agreedLabourCost;
  var agreedPartCost;
  var actionTask;
  var requisitionNo;
  var virtualCode;
  var status;
  var rowno;
  var requestedTime;
  var startTime;
  var noStarttime;
  var endTime;
  var noEndtime;
  var recordedTime;
  var travelTime;
  var typeofwork;
  var startingMileage;
  var endingMileage;
  var tollnparkingFees;
  var expenseClaimed;
  var mileageClaimed;
  var srlIntgrtd;
  var ticketId;
  var transfered;
  var tktId;
  var sfitAssetNo;
  var isSigned;
  var imgNameEng;
  var reason;
  var imgNameClient;
  final DateTime engSignDate;
  final DateTime linkExprdOn;
  var showLink;
  var custSignDate;
  var custName;
  var emlSntToClnt;
  var duedaysInvoice;
  var createdBy;
  var updatedAt;
  var createdAt;
  var updatedBy;
  var priorityLevel;
  var engineer;
  var equipmentType;
  var equipmentId;
  var warranty;
  var findings;
  var workUndertaken;
  var companyName;
  var email;
  var siteName;
  var address;
  var siteemail;
  var postcode;
  var srfno;
  var phoneNo;
  var fax;
  var contractDescription;
  var empname;
  var empid;

  SvcDatum({
    required this.serviceFormType,
    required this.contractId,
    required this.companyId,
    required this.siteId,
    required this.requestedDate,
    required this.delRequestedTime,
    required this.startDate,
    required this.delStartTime,
    required this.delEndTime,
    required this.delTravelTime,
    required this.totalTime,
    required this.problems,
    required this.recommendations,
    required this.agreedLabourCost,
    required this.agreedPartCost,
    required this.actionTask,
    required this.requisitionNo,
    required this.virtualCode,
    required this.status,
    required this.rowno,
    required this.requestedTime,
    required this.startTime,
    required this.noStarttime,
    required this.endTime,
    required this.noEndtime,
    required this.recordedTime,
    required this.travelTime,
    required this.typeofwork,
    required this.startingMileage,
    required this.endingMileage,
    required this.tollnparkingFees,
    required this.expenseClaimed,
    required this.mileageClaimed,
    required this.srlIntgrtd,
    required this.ticketId,
    required this.transfered,
    required this.tktId,
    required this.sfitAssetNo,
    required this.isSigned,
    required this.imgNameEng,
    required this.reason,
    required this.imgNameClient,
    required this.engSignDate,
    required this.linkExprdOn,
    required this.showLink,
    required this.custSignDate,
    required this.custName,
    required this.emlSntToClnt,
    required this.duedaysInvoice,
    required this.createdBy,
    required this.updatedAt,
    required this.createdAt,
    required this.updatedBy,
    required this.priorityLevel,
    required this.engineer,
    required this.equipmentType,
    required this.equipmentId,
    required this.warranty,
    required this.findings,
    required this.workUndertaken,
    required this.companyName,
    required this.email,
    required this.siteName,
    required this.address,
    required this.siteemail,
    required this.postcode,
    required this.srfno,
    required this.phoneNo,
    required this.fax,
    required this.contractDescription,
    required this.empname,
    required this.empid,
  });

  set setTyprOfWork(String value) => typeofwork = value;

  factory SvcDatum.fromJson(Map<String, dynamic> json) => SvcDatum(
        serviceFormType: json["service_form_type"],
        contractId: json["contract_id"],
        companyId: json["company_id"],
        siteId: json["site_id"],
        requestedDate: json["requested_date"],
        delRequestedTime: json["del_requested_time"],
        startDate: json["start_date"],
        delStartTime: json["del_start_time"],
        delEndTime: json["del_end_time"],
        delTravelTime: json["del_travel_time"],
        totalTime: json["total_time"],
        problems: json["problems"],
        recommendations: json["recommendations"],
        agreedLabourCost: json["agreed_labour_cost"],
        agreedPartCost: json["agreed_part_cost"],
        actionTask: json["action_task"],
        requisitionNo: json["requisition_no"],
        virtualCode: json["virtual_code"],
        status: json["status"],
        rowno: json["rowno"],
        requestedTime: json["requested_time"],
        startTime: json["start_time"],
        noStarttime: json["no_starttime"],
        endTime: json["end_time"],
        noEndtime: json["no_endtime"],
        recordedTime: json["recorded_time"],
        travelTime: json["travel_time"],
        typeofwork: json["typeofwork"],
        startingMileage: json["starting_mileage"],
        endingMileage: json["ending_mileage"],
        tollnparkingFees: json["tollnparking_fees"],
        expenseClaimed: json["expense_claimed"],
        mileageClaimed: json["mileage_claimed"],
        srlIntgrtd: json["srl_intgrtd"],
        ticketId: json["ticket_id"],
        transfered: json["transfered"],
        tktId: json["tkt_id"],
        sfitAssetNo: json["sfit_asset_no"],
        isSigned: json["is_signed"],
        imgNameEng: json["img_name_eng"],
        reason: json["reason"],
        imgNameClient: json["img_name_client"],
        engSignDate: DateTime.parse(json["eng_sign_date"]),
        linkExprdOn: DateTime.parse(json["link_exprd_on"]),
        showLink: json["show_link"],
        custSignDate: json["cust_sign_date"],
        custName: json["cust_name"],
        emlSntToClnt: json["eml_snt_to_clnt"],
        duedaysInvoice: json["duedays_invoice"],
        // duedaysInvoice: json["duedays_invoice"] + ' Days',
        createdBy: json["created_by"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        updatedBy: json["updated_by"],
        priorityLevel: json["priority_level"],
        engineer: json["engineer"],
        equipmentType: json["equipment_type"],
        equipmentId: json["equipment_id"],
        warranty: json["warranty"],
        findings: json["findings"],
        workUndertaken: json["workUndertaken"],
        companyName: json["company_name"],
        email: json["email"],
        siteName: json["site_name"],
        address: json["address"],
        siteemail: json["siteemail"],
        postcode: json["postcode"],
        srfno: json["srfno"],
        phoneNo: json["phone_no"],
        fax: json["fax"],
        contractDescription: json["contract_description"],
        empname: json["empname"],
        empid: json["empid"],
      );

  Map<String, dynamic> toJson() => {
        "service_form_type": serviceFormType,
        "contract_id": contractId,
        "company_id": companyId,
        "site_id": siteId,
        "requested_date": requestedDate,
        "del_requested_time": delRequestedTime,
        "start_date": startDate,
        "del_start_time": delStartTime,
        "del_end_time": delEndTime,
        "del_travel_time": delTravelTime,
        "total_time": totalTime,
        "problems": problems,
        "recommendations": recommendations,
        "agreed_labour_cost": agreedLabourCost,
        "agreed_part_cost": agreedPartCost,
        "action_task": actionTask,
        "requisition_no": requisitionNo,
        "virtual_code": virtualCode,
        "status": status,
        "rowno": rowno,
        "requested_time": requestedTime,
        "start_time": startTime,
        "no_starttime": noStarttime,
        "end_time": endTime,
        "no_endtime": noEndtime,
        "recorded_time": recordedTime,
        "travel_time": travelTime,
        "typeofwork": typeofwork,
        "starting_mileage": startingMileage,
        "ending_mileage": endingMileage,
        "tollnparking_fees": tollnparkingFees,
        "expense_claimed": expenseClaimed,
        "mileage_claimed": mileageClaimed,
        "srl_intgrtd": srlIntgrtd,
        "ticket_id": ticketId,
        "transfered": transfered,
        "tkt_id": tktId,
        "sfit_asset_no": sfitAssetNo,
        "is_signed": isSigned,
        "img_name_eng": imgNameEng,
        "reason": reason,
        "img_name_client": imgNameClient,
        "eng_sign_date": engSignDate.toIso8601String(),
        "link_exprd_on": linkExprdOn.toIso8601String(),
        "show_link": showLink,
        "cust_sign_date": custSignDate,
        "cust_name": custName,
        "eml_snt_to_clnt": emlSntToClnt,
        "duedays_invoice": duedaysInvoice,
        "created_by": createdBy,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "updated_by": updatedBy,
        "priority_level": priorityLevel,
        "engineer": engineer,
        "equipment_type": equipmentType,
        "equipment_id": equipmentId,
        "warranty": warranty,
        "findings": findings,
        "workUndertaken": workUndertaken,
        "company_name": companyName,
        "email": email,
        "site_name": siteName,
        "address": address,
        "siteemail": siteemail,
        "postcode": postcode,
        "srfno": srfno,
        "phone_no": phoneNo,
        "fax": fax,
        "contract_description": contractDescription,
        "empname": empname,
        "empid": empid,
      };
}
