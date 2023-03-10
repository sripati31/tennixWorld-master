import 'package:TennixWorldXI/data/app_urls/app_urls.dart';
import 'package:TennixWorldXI/data/network/network_api.dart';
import 'package:TennixWorldXI/model_new/signup_model.dart';

class SignupRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<SignupModel> signUpApi(
    dynamic data,
  ) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrl.loginEndPoint,
        data,
        false,
        null,
      );
      return SignupModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
