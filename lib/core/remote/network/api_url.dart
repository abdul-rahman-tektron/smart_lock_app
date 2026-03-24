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
}