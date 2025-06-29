class EndPoints {
  static String baseUrl = 'https://8299-197-134-78-134.ngrok-free.app';
  static String singIn = '/api/login/';
  static String singUp = '/api/register/';
  static String getConsumptionRateEndPoint = '/api/water-consumption/';
  static String getTankAndFlowEndPoint = '/api/tank-flow/';
  static String logOutEndPoint = '/api/logout/';
  static String getMotorStatusEndPoint = '/api/control-device/';
  static String getUserDataEndPoint(id) {
    return '/api/profile/$id';
  }
}

class ApiKey {
  static String topic ='topic';
  static String payload = 'payload';
  static String username = 'username';
   static String phone = 'phone_number';
  static String email = 'email';

  static String fullName = 'full_name';
  static String location = 'home_address';
  static String password = 'password';
  static String confirmPassword = 'password2';
  
  static String name = 'username_or_phone';
 
  static String profilePic = 'profilePic';
  static String status = 'status';
  static String errorMessage = 'ErrorMessage';
  
  static String token = 'token';
  static String id ='id';
  static String message = 'user';
  static String monthlyConsumption = 'monthlyConsumption';
  static String weeklyConsumption = 'weeklyConsumption';
  static String dailyConsumption = 'dailyConsumption';
  static String last12hoursConsumption = 'last12hoursConsumption';

}
