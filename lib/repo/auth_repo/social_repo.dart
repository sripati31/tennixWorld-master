import 'package:TennixWorldXI/data/app_urls/app_urls.dart';
import 'package:TennixWorldXI/data/network/network_api.dart';

import '../../model_new/social_login_model.dart';

class SocialRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<SocialModel> socialAuthenticationApi(
    dynamic data,
  ) async {
    try {
      dynamic response = await _apiService.postApiResponse(
        AppUrl.socialLoginEndPoint,
        data,
        false,
        null,
      );
      return SocialModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
