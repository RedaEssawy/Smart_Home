class Topics {
  // 1- this topic for motor : the data that will be sent is (boolean )true or false from app to the hardware
  static const String motorTankroomTopic = 'home/tankRoom/motor';

  // 2- this topic for tank valve : the data that will be sent is (boolean )true or false from app to the hardware
  static const String tankValveTankroomTopic = 'home/tankRoom/tankValve';

  // 3- this topic for main valve : the data that will be sent is (boolean )true or false from app to the hardware
  static const String mainValveTankroomTopic = 'home/tankRoom/mainValve';

  // 4- this topic for cado valve : the data that will be sent is (boolean )true or false from app to the hardware
  static const String cadoValveTopic = 'home/tankRoom/cadoValve';

  // 5- this topic for tank level : the data that will be sent is double from hardware to the app
  static const String tankLevelTankroomTopic = 'home/tankRoom/tankLevel';

  // 6- this topic for the main flowrate sensor : the data that will be sent is double from hardware to the app
  static const String mainFlowrateTankroomTopic = 'home/tankRoom/mainFlowrate';

  // 7- this topic for the second flowrate sensor : the data that will be sent is double from hardware to the app
  static const String secondFlowrateTankroomTopic =
      'home/tankRoom/secondFlowrate';

  // 8- this topic for the first PIR sensor : the data that will be sent is double from hardware to the app
  static const String firstPIRSensorTopic = 'home/lekageRoom/firstPIRSensor';

  // 9- this topic for the second PIR sensor : the data that will be sent is double from hardware to the app
  static const String secondPIRSensorTopic = 'home/lekageRoom/secondPIRSensor';

  // 10- this topic for the pressure sensor : the data that will be sent is double from hardware to the app
  static const String pressureSensorTopic = 'home/pressureValue';
}
