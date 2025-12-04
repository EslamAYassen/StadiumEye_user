class Endpoints {
  static const baseUrl = "https://stadiumeye-backend-b6fq.onrender.com/api/v1";
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

  // personal info
  static const myProfile = "/users/me";

  // update personal info
  //TODO: add this part after seif finish it in the backend
  // static const updateMyProfile = "/users/me";

  // delete personal info
  //TODO: add this part after seif finish it in the backend
  // static const deleteMyProfile = "/users/me";
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
