class AppUrl {
  static String baseUrl = 'https://dream11.tennisworldxi.com/api';
  //////////////////////// End POints ////////////////////////////
  static String loginEndPoint = '$baseUrl/auth/login';
  static String signUpEndPoint = '$baseUrl/auth/signup';

  static String socialLoginEndPoint = '$baseUrl/facebook/login';
  static String emailVerificationEndPoint = '$baseUrl/send-otp';
  static String otpeVrificationEndPoint = '$baseUrl/verify-otp';
  static String addNewPasswordEndPoint = '$baseUrl/forgot-password';
  static String updateUserEndPoint = '$baseUrl/user';
}
