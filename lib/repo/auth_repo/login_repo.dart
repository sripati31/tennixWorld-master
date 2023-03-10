import 'package:TennixWorldXI/data/app_urls/app_urls.dart';
import 'package:TennixWorldXI/data/network/network_api.dart';

class LoginRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<dynamic> loginApi(
    dynamic data,
  ) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrl.loginEndPoint,
        data,
        false,
        null,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
