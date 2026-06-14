class Endpoints {
  static const baseUrl = "http://91.108.112.27:3030/api/v1";
}

class AuthEndpoints extends Endpoints {
  static const login = "/users/auth/login";
  static const register = "/users/auth/register";
  static const logout = "/users/auth/logout";

  // forgot password
  static const forgotPassword = "/users/auth/forgot-password";
  static const resetPassword = "/users/auth/reset-password";
  static const verifyResetCode = "/users/auth/verify-reset-code";

  // verify email
  static const verifyEmail = "/users/auth/verify-account";
}

class UserEndpoints extends Endpoints {
  static const _me = "/users/me";
  // personal info
  static const myProfile = _me;

  // update personal info
  static const updateMyProfile = _me;

  // delete personal info
  static const deleteMyProfile = _me;
}

class ReportEndpoints extends Endpoints {
  // get my reports
  static const myReports = "/tickets/my";

  // create report
  static const createReport = "/tickets";
}

class StadiumEndpoints extends Endpoints {
  static const stadiums = "/stadiums";
}

class LocationEndpoints extends Endpoints {
  static const countries = "/countries";
  static const cities = "/cities";
}
