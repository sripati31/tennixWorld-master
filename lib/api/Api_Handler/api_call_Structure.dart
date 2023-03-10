import 'dart:io';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../utils/toast.dart';
import '../../utils/progress_dialog.dart';
import 'api_constants.dart';
import 'api_error_response.dart';

class API_STRUCTURE {
  final String apiName;
  dynamic? body;
  final bool isWantSuccessMessage;
  final String apiRequestMethod;
  final BuildContext? context;
  String? contentType;

  API_STRUCTURE({
    this.body,
    required this.apiName,
    required this.apiRequestMethod,
    this.context,
    this.isWantSuccessMessage = false,
    this.contentType,
  });
  Future<Map<String, dynamic>> requestAPI({bool isShowLoading = false, bool isElasticServerApi = false, bool isServerApi = false, String rawBody = '', bool isEasypaisa = false}) async {
    String api = "";
    MyProgressDialog? progressDialog;
    if (context != null) {
      progressDialog = MyProgressDialog(context!);
    }
    try {
      api = ApiConstant.apiUrl + apiName;
      Map<String, String> header = {};
      if (Utils.userToken != null && Utils.userToken!.isNotEmpty) {
        header.addAll({"Authorization": "Bearer ${Utils.userToken}"});
      }
      if (contentType != null && contentType!.isNotEmpty) {
        header.addAll({"Content-Type": contentType!});
      }
      header.addAll({"deviceType": Platform.isAndroid ? 'Android' : "iOS"});
      if (isShowLoading) {
        if (!isEasypaisa) {
          progressDialog?.show();
        } else {
          progressDialog?.show("", "true");
        }
      }
      Dio dio = Dio();
      Options options = Options(
          followRedirects: false,
          headers: header,

          /// Enable for testing compelte status
          validateStatus: (int? status) {
            return (status ?? 530) < 520;
          });
      Response<dynamic> response = apiRequestMethod == API_REQUEST_METHOD.GET
          ? await dio.get(api, options: options)
          : apiRequestMethod == API_REQUEST_METHOD.POST
              ? await dio.post(api, data: body, options: options)

              /// Else for Put Method
              : apiRequestMethod == API_REQUEST_METHOD.REQUEST
                  ? await dio.post(api, data: rawBody, options: options)
                  : await dio.put(api, data: body, options: options);
      if (isShowLoading) progressDialog?.hide();
      if (apiRequestMethod == API_REQUEST_METHOD.REQUEST) {
        Map<String, dynamic> elasticSearchResult = elasticSearchResponseHandling(response);
        return elasticSearchResult;
      } else {
        Map<String, dynamic> eneralSearchResult = generalResponseHandling(response);
        return eneralSearchResult;
      }
    } on DioError catch (e) {
      Map<String, dynamic> _exception = {};
      if (isShowLoading) {
        progressDialog?.hide();
      }
      switch (e.type) {
        case DioErrorType.connectTimeout:
          CustomToast.showToast(
            message: "Connection timeout",
          );
          _exception = {API_RESPONSE.EXCEPTION: "Connection timeout"};
          break;
        case DioErrorType.sendTimeout:
          CustomToast.showToast(
            message: "Sent timeout",
          );
          _exception = {API_RESPONSE.EXCEPTION: "Sent timeout"};
          break;
        case DioErrorType.receiveTimeout:
          CustomToast.showToast(
            message: "Receive timeout",
          );
          _exception = {API_RESPONSE.EXCEPTION: "Receive timeout"};
          break;
        case DioErrorType.response:
          if (e.response?.statusCode == 404) {
            CustomToast.showToast(
              message: "Request not found",
            );
            _exception = {API_RESPONSE.EXCEPTION: "Request not found"};
          } else if ((e.response?.statusCode ?? 400) >= 401 && (e.response?.statusCode ?? 400) <= 420) {
            CustomToast.showToast(
              message: "Something went wrong",
            );
            _exception = {API_RESPONSE.EXCEPTION: "Something went wrong"};
          } else if ((e.response?.statusCode ?? 500) >= 500) {
            CustomToast.showToast(
              message: "Server error",
            );
            _exception = {API_RESPONSE.EXCEPTION: "Server error"};
          } else {
            CustomToast.showToast(
              message: "Server error",
            );
            _exception = {API_RESPONSE.EXCEPTION: "Server error"};
          }
          break;
        case DioErrorType.cancel:
          CustomToast.showToast(
            message: "Request cancelled",
          );
          _exception = {API_RESPONSE.EXCEPTION: "Cancel"};
          break;
        case DioErrorType.other:
          String error = e.error.toString().contains("SocketException") ? "Internet Connection Error" : API_EXCEPTION.UNKNOWN;
          CustomToast.showToast(
            message: error,
          );
          _exception = {API_RESPONSE.EXCEPTION: error};
          break;
      }
      return _exception;
    } on SocketException {
      if (isShowLoading) progressDialog?.hide();
      CustomToast.showToast(
        message: "Internet Connection Error",
      );
      return {API_RESPONSE.EXCEPTION: API_EXCEPTION.SOCKET};
    } on HttpException {
      if (isShowLoading) progressDialog?.hide();
      CustomToast.showToast(
        message: "Internet Connection Error",
      );
      return {API_RESPONSE.EXCEPTION: API_EXCEPTION.HTTP};
    } on FormatException {
      if (isShowLoading) progressDialog?.hide();
      CustomToast.showToast(
        message: "Server Bad response",
      );
      return {API_RESPONSE.EXCEPTION: API_EXCEPTION.FORMAT};
    } catch (error) {
      if (isShowLoading) progressDialog?.hide();
      CustomToast.showToast(
        message: error.toString().contains("SocketException") ? "Internet Connection Error" : error.toString(), //API_EXCEPTION.UNKNOWN}",
      );
      return error.toString().contains("SocketException") ? {API_RESPONSE.EXCEPTION: "Internet Connection Error"} : {API_RESPONSE.EXCEPTION: API_EXCEPTION.UNKNOWN};
    }
  }

  generalResponseHandling(response) {
    if (response.statusCode >= 200 && response.statusCode < 220) {
      if (response.data["data"]["code"] == 200) {
        if (isWantSuccessMessage) {
          CustomToast.showToast(
            message: "Request successful",
          );
        }
        return {API_RESPONSE.SUCCESS: response.data};
      } else {
        CustomToast.showToast(
          message: "${response.data["data"]["message"]}",
        );
        return {API_RESPONSE.ERROR: response.data["data"]["message"]};
      }
    } else {
      String error = API_RESPONSE.GetErrorResponse(response.statusCode) ?? "Unknown Status Response";
      CustomToast.showToast(
        message: "Something went wrong",
      );
      return {API_RESPONSE.ERROR: error};
    }
  }

  elasticSearchResponseHandling(response) {
    if (response.statusCode == 200) {
      return {API_RESPONSE.SUCCESS: response.data['responses']};
    } else {
      String error = API_RESPONSE.GetErrorResponse(response.statusCode) ?? "Unknown Status Response";
      return {API_RESPONSE.ERROR: error};
    }
  }
}

