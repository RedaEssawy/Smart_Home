class EndPoints {
  static String baseUrl = 'http://192.168.1.7:8000';
  static String singIn = '/api/login/';
  static String singUp = '/api/register/';
  static String getConsumptionRateEndPoint = '/api/water-consumption/';
  static String getUserDataEndPoint(id) {
    return 'user/get-user/$id';
  }
}

class ApiKey {
  static String fullName = 'full_name';
  static String name = 'username_or_phone';
  static String phone = 'phone_number';
  static String confirmPassword = 'password2';
  static String location = 'home_address';
  static String profilePic = 'profilePic';
  static String status = 'status';
  static String errorMessage = 'ErrorMessage';
  static String email = 'email';
  static String password = 'password';
  static String token = 'token';
  static String id = 'id';
  static String message = 'message';
  static String monthlyConsumption = 'monthlyConsumption';
  static String weeklyConsumption = 'weeklyConsumption';
  static String dailyConsumption = 'dailyConsumption';
  static String last12hoursConsumption = 'last12hoursConsumption';

}
