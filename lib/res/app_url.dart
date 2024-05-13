// ignore_for_file: non_constant_identifier_names

class AppUrl {
  static const LOGO_URL = 'https://serviceportal.systemforce.net/images/bg_img.png';

  static var baseUrl = 'https://serviceportal.systemforce.net/api/';

  static var userName = 'cyberc';
  static var appPw = 'Abcd@1234';
  // core apis

  static var login = '${baseUrl}auth/login';

  // dp s

  static var customerdp = '${baseUrl}get-companys-all/'; // customer dp ~ company
  static var sitedp = '${baseUrl}api_dropsites_forcompany/';
  static var contractdp = '${baseUrl}api_asset_contracts_forsites/';
  static var orderbydp = '${baseUrl}auth/login'; // this may be hard coded dp
  static var engineerdp = '${baseUrl}api_empnames/';

  // get search field service entries info in dashboard
  static var search_field_sevice_entries = '${baseUrl}searchrslt';

  // for load pdf
  static var fetchpdf = '${baseUrl}load-pdf-api/';

  // for load data in view
  static var fetchdata = '${baseUrl}api_svcform_action/View/';

  // for type of hours dp
  static var typeofhoursdp = '${baseUrl}get-work-type';

  // for machine type dp in add new asset part
  static var machinetypedp = '${baseUrl}api_getdet_modal';

  // for check already has asset code
  static var checkasset = '${baseUrl}apitst/';

  //  for save new asset code
  static var saveassetcode = '${baseUrl}api_modal_save';

  // for to be paid in type dp
  static var tobepaidindp = '${baseUrl}get-paid-days';

  // for product type dp
  static var producttypedp = '${baseUrl}get-product-type/';

  // get labour hours
  static var labourhour = '${baseUrl}onchange-typeofhours/?typeofhour=';

  // get labour hours
  static var getassetforcontract = '${baseUrl}api_assets_forcontract/';

  // get items
  static var itemsdp = '${baseUrl}get-items/';

  // get serials
  static var serialchips = '${baseUrl}get-serial?item_code=';

  // get serial info
  static var serialinfo = '${baseUrl}get-serial-info/';

  // get serial info
  static var reqnoo = '${baseUrl}api_svcformid/';

  // submit all data & edit
  static var submitalldata = '${baseUrl}api_svcform_store';

  // email sent
  static var sendemail = '${baseUrl}send-email-api/';

  // delete service forms
  static var deleteform = '${baseUrl}api_svcform_store';

  // get signature details
  static var fetchsignaturedata = '${baseUrl}api_svcform_action/Signature/';

  // for network service

  static const int receiveTimeout = 60000;

  static const int connectionTimeout = 60000;
}
