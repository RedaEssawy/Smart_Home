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

/*************  ✨ Windsurf Command ⭐  *************/
  /// Handle new data from MQTT broker.
  ///
  /// This function is called whenever we receive a new message from the MQTT
  /// broker. It extracts the topic and the data from the message and calls
  /// [routeData] to handle it.
  ///
  /// [event] is a list of [MqttReceivedMessage<MqttMessage>] and contains the
  /// message received from the MQTT broker.
///*******  d34da660-77c6-47ee-bb93-848f018aa523  *******/
  void getDataAndTopic(List<MqttReceivedMessage<MqttMessage>> event) {
    final MqttPublishMessage message = event[0].payload as MqttPublishMessage;
    final data =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);

    routeData(event[0].topic, data);
  }

  List<SaleData> consumptionValue = [
    SaleData(x: 1, y: 35),
    SaleData(x: 2, y: 25),
    SaleData(x: 3, y: 45),
    SaleData(x: 4, y: 35),
    SaleData(x: 5, y: 35),
    SaleData(x: 6, y: 25),
    SaleData(x: 7, y: 45),
    SaleData(x: 8, y: 35)
  ];

  double pressure = 0;

  void routeData(String topic, String data) {
    if (topic == Topics.pressureSensorTopic) {
      if (consumptionValue.length <= 10) {
        consumptionValue
            .add(SaleData(x: consumptionValue.length + 1, y: double.parse(data)));
      } else {
        consumptionValue.removeAt(0);
        consumptionValue
            .add(SaleData(x: consumptionValue.length + 1, y: double.parse(data)));
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
