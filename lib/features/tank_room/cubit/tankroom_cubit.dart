//here write logic

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smart_home/features/tank_room/cubit/tankroom_state.dart';
import 'package:smart_home/core/util/topics.dart';

class TankroomCubit extends Cubit<TankroomState> {
  final MqttClientPayloadBuilder _p = MqttClientPayloadBuilder();
  late MqttServerClient client;
  TankroomCubit(this.client) : super(TankInitialState());
  static TankroomCubit get(BuildContext context) => BlocProvider.of(context);

  void publish(String topic, String data) {
    _p.addString(data);
    client.publishMessage(topic, MqttQos.atMostOnce,
        _p.payload!, //to make any client made subscripe on this tpic when be online send for it its value
        retain: true);
    _p.clear();
  }

  void getDataAndTopic(List<MqttReceivedMessage<MqttMessage>> event) {
    final MqttPublishMessage message = event[0].payload as MqttPublishMessage;
    final data =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);

    routeData(event[0].topic, data);
  }

  bool motor = false;
  bool tankValve = false;
  bool mainValve = false;
  double tankLevel = 0;
  bool flowrate = false;
  void routeData(String topic, String data) {
    if (topic == Topics.motorTankroomTopic) {
      motor = bool.parse(data);
      emit(TankGetDataState());
    } else if (topic == Topics.tankValveTankroomTopic) {
      tankValve = bool.parse(data);
      emit(TankGetDataState());
    } else if (topic == Topics.mainValveTankroomTopic) {
      mainValve = bool.parse(data);
      emit(TankGetDataState());
    } else if (topic == Topics.mainFlowrateTankroomTopic) {
      flowrate = bool.parse(data);
      emit(TankGetDataState());
    } else if (topic == Topics.tankLevelTankroomTopic) {
      tankLevel = double.parse(data);
      emit(TankGetDataState());
    }
  }
}
