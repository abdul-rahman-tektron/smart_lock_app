class ApiUrls {
  ApiUrls._();

  ///Base
  static const baseHttp = "https://";
  // static const baseHost = "teksmartsolutions.com/TekAccess_API";
  static const baseHost = "teksmartsolutions.com/SmartLockerAPI";

  static const baseUrl = "$baseHttp$baseHost";

  ///Common
  static const pathLogin = "/api/Auth/login"; // POST
  static const pathPackageList = "/Stats/list"; // POST
  static const pathPackageCount = "/Stats/count"; // POST
  static const pathForgotPassword = "/api/forgot-password"; // POST
  static const pathOTPVerify = "/api/verify-otp"; // POST
  static const pathResetPassword = "/api/reset-password"; // POST
  static const pathChangePassword = "/api/change-password"; // POST
  static const String pathEditProfile = "/api/EditProfile/";
  static const String pathGetProfile = "/api/GetProfile/";
  static const String pathHelpSupport = "/api/HelpSupport";
}