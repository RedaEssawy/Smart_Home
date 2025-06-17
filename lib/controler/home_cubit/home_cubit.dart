import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smart_home/core/util/topics.dart';
import 'package:smart_home/controler/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late MqttServerClient client;
  HomeCubit(this.client) : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  void getDataAndTopic(List<MqttReceivedMessage<MqttMessage>> event) {
    final MqttPublishMessage message = event[0].payload as MqttPublishMessage;
    final data =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);

    routeData(event[0].topic, data);
  }

  List<SaleData> pressureValues = [
    // SaleData(x: 1, y: 35),
    // SaleData(x: 2, y: 25),
    // SaleData(x: 3, y: 45),
    // SaleData(x: 4, y: 35)
  ];

  double pressure = 0;

  void routeData(String topic, String data) {
    if (topic == Topics.pressureSensorTopic) {
      if (pressureValues.length <= 5) {
        pressureValues
            .add(SaleData(x: pressureValues.length + 1, y: double.parse(data)));
        
      } else {
        pressureValues.removeAt(0);
        pressureValues
            .add(SaleData(x: pressureValues.length + 1, y: double.parse(data)));
      }
      pressure = double.parse(data);
      emit(HomeGetDataState());
    }
  }
}

class SaleData {
  final double x;
  final double y;

  SaleData({required this.x, required this.y});
}
