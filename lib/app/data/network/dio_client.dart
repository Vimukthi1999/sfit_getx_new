import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../res/app_url.dart';
import '../../../res/widgets/show_app_dialog.dart';
import 'exceptions.dart';

class DioClient {
  final Dio _dio = Dio();
  final box = GetStorage();

  static final DioClient _singalton = DioClient._internel();

  factory DioClient() {
    return _singalton;
  }

  DioClient._internel() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add the access uid to the request header
          var uid = await box.read('uid');
          options.headers['Authorization'] = "Bearer $uid";
          return handler.next(options);
        },
        onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401) {
            // If a 401 response is received, refresh the access uid
            String newAccessToken = await refreshToken();

            // Update the request header with the new access uid
            e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            log('Update the request header with the new access uid - retry request');
            // Repeat the request with the updated header
            return handler.resolve(await _dio.fetch(e.requestOptions));
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<String> refreshToken() async {
    // Perform a request to the refresh uid endpoint and return the new access uid.

    String newUid = '';

    var old = await box.read('uid');
    print(old);
    // _dio.options.headers["Authorization"] = "Bearer $old";

    // Options options = Options(
    //   headers: {'Accept': 'application/json'},
    //   sendTimeout: Duration(seconds: AppUrl.connectionTimeout),
    //   receiveTimeout: Duration(seconds: AppUrl.receiveTimeout),
    // );

    // var res = await _dio.post('https://serviceportal.systemforce.net/api/auth/refresh', options: options);

    final response = await http.post(Uri.parse("https://serviceportal.systemforce.net/api/auth/refresh"), headers: {'Authorization': 'Bearer $old', 'Accept': 'application/json'});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      newUid = data["access_token"];
      await box.write('uid', newUid);
      // await SharedPref.setValue('token', newToken);

      print('nnnnnnnnnnnnnnnnnnnn-------- $newUid');
    } else {
      print(response.statusCode.toString() + 'bbbb');
    }

    // print(res);

    // var newtoekn = res.data['access_uid'];
    // await box.write('uid', newtoekn);

    return newUid;
  }

  Future<dynamic> get(
    String uri, [
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  ]) async {
    var uid = await box.read('uid');
    _dio.options.headers["Authorization"] = "Bearer $uid";

    try {
      Options options = Options(
        headers: {
          'Accept': 'application/json',
          // 'Content-Type': 'application/json',
        },
        sendTimeout: Duration(seconds: AppUrl.connectionTimeout),
        receiveTimeout: Duration(seconds: AppUrl.receiveTimeout),
      );

      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      log('run client get - @ DioClient');
      return response.data;
    } on DioError catch (e) {
      final errorMsg = DioExceptions.fromDioError(e);
      showAppDialog("Not Successful", errorMsg.message.toString());
    }
  }

  Future<dynamic> getforPDF(
    String uri, [
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  ]) async {
    var uid = await box.read('uid');
    _dio.options.headers["Authorization"] = "Bearer $uid";

    try {
      Options options = Options(headers: {
        'Accept': 'application/json',
        // 'Content-Type': 'application/json',
      }, sendTimeout: Duration(seconds: AppUrl.connectionTimeout), receiveTimeout: Duration(seconds: AppUrl.receiveTimeout), responseType: ResponseType.bytes);

      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      log('run client get - @ DioClient');
      return response.data;
    } on DioError catch (e) {
      final errorMsg = DioExceptions.fromDioError(e);
      showAppDialog("Not Successful", errorMsg.message.toString());
    }
  }

  // post

  // without uid
  Future<dynamic> withOutTokenPost(
    String uri,
    Map<String, dynamic> queryParameters, [
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  ]) async {
    try {
      Options options = Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        sendTimeout: Duration(seconds: AppUrl.connectionTimeout),
        receiveTimeout: Duration(seconds: AppUrl.receiveTimeout),
      );

      final response = await _dio.post(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      log('run client with out uid post - @ DioClient');
      return response.data;
    } on DioError catch (e) {
      final errorMsg = DioExceptions.fromDioError(e);
      showAppDialog("Not Successful", errorMsg.message.toString());
    }
  }

  // with uid

  Future<dynamic> post(
    String uri,
    Map<String, dynamic> queryParameters, [
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  ]) async {
    var uid = await box.read('uid');
    _dio.options.headers["Authorization"] = "Bearer $uid";
    try {
      Options options = Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        sendTimeout: Duration(seconds: AppUrl.connectionTimeout),
        receiveTimeout: Duration(seconds: AppUrl.receiveTimeout),
      );

      final response = await _dio.post(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      log('run client post - @ DioClient');
      return response.data;
    } on DioError catch (e) {
      final errorMsg = DioExceptions.fromDioError(e);
      showAppDialog("Not Successful", errorMsg.message.toString());
    }
  }

  // with images

  Future<dynamic> signPost(
    String uri,
    String type,
    Map<String, dynamic> queryParameters, [
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  ]) async {
    await refreshToken();
    var uid = await box.read('uid');
    _dio.options.headers["Authorization"] = "Bearer $uid";

    try {
      Options options = Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        },
        sendTimeout: Duration(seconds: AppUrl.connectionTimeout),
        receiveTimeout: Duration(seconds: AppUrl.receiveTimeout),
      );

      // FormData formData = FormData.fromMap(queryParameters);
      var response;
      switch (type) {
        case 'E':
          FormData formData = FormData.fromMap({});
          formData.fields.addAll(queryParameters.entries.map((e) => MapEntry(e.key, e.value.toString())));
          response = await _dio.post(
            uri,
            options: options,
            data: formData,
          );
          break;

        case 'C':
          FormData formDataClie = FormData.fromMap({});
          formDataClie.fields.addAll(queryParameters.entries.map((e) => MapEntry(e.key, e.value.toString())));

          response = await _dio.post(
            uri,
            options: options,
            data: formDataClie,
          );
          break;
        default:
      }

      // final response = await _dio.post(
      //   uri,
      //   options: options,
      //   data: formData,
      // );

      log('run client from data post - @ DioClient');
      return response.data;
    } on DioError catch (e) {
      final errorMsg = DioExceptions.fromDioError(e);
      showAppDialog("Not Successful", errorMsg.message.toString());
    }
  }

  Future<dynamic> cussignPost(
    String uri,
    Map<String, dynamic> queryParameters, [
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  ]) async {
    var uid = await box.read('uid');
    _dio.options.headers["Authorization"] = "Bearer $uid";

    try {
      Options options = Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        },
        sendTimeout: Duration(seconds: AppUrl.connectionTimeout),
        receiveTimeout: Duration(seconds: AppUrl.receiveTimeout),
      );

      // FormData formData = FormData.fromMap(queryParameters);
      FormData formData = FormData.fromMap({});
      formData.fields.addAll(queryParameters.entries.map((e) => MapEntry(e.key, e.value.toString())));

      final response = await _dio.post(
        uri,
        options: options,
        data: formData,
      );

      log('run client from data post - @ DioClient');
      return response.data;
    } on DioError catch (e) {
      final errorMsg = DioExceptions.fromDioError(e);
      showAppDialog("Not Successful", errorMsg.message.toString());
    }
  }

  // update

  Future<dynamic> update(
    String uri,
    Map<String, dynamic> queryParameters, [
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  ]) async {
    var uid = await box.read('uid');
    _dio.options.headers["Authorization"] = "Bearer $uid";

    try {
      Options options = Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        sendTimeout: Duration(seconds: AppUrl.connectionTimeout),
        receiveTimeout: Duration(seconds: AppUrl.receiveTimeout),
      );

      final response = await _dio.put(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      log('run client update - @ DioClient');
      return response.data;
    } on DioError catch (e) {
      final errorMsg = DioExceptions.fromDioError(e);
      showAppDialog("Not Successful", errorMsg.message.toString());
    }
  }

  // delete

  Future<dynamic> delete(
    String uri,
    Map<String, dynamic> queryParameters, [
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  ]) async {
    FormData formData = FormData.fromMap(queryParameters);
    var t = await box.read('uid');
    _dio.options.headers["Authorization"] = "Bearer $t";

    try {
      Options options = Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        sendTimeout: Duration(seconds: AppUrl.connectionTimeout),
        receiveTimeout: Duration(seconds: AppUrl.receiveTimeout),
      );

      final response = await _dio.delete(
        uri,
        queryParameters: queryParameters,
        // data: formData,
        options: options,
        cancelToken: cancelToken,
      );
      log('run client delete - @ DioClient');
      return response.data;
    } on DioError catch (e) {
      final errorMsg = DioExceptions.fromDioError(e);
      showAppDialog("Not Successful", errorMsg.message.toString());
    }
  }
}