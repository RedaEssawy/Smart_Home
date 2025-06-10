//here write logic
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:smart_home/core/util/topics.dart';
import 'package:smart_home/features/lekage_room/cubit/lekageroom_state.dart';

class LekageroomCubit extends Cubit<LekageroomState> {
  final MqttClientPayloadBuilder _p = MqttClientPayloadBuilder();
  late MqttServerClient client;
  LekageroomCubit(this.client) : super(IntilState());
  static LekageroomCubit get(BuildContext context) => BlocProvider.of(context);

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

  bool firstPIRSensor = false;
  bool secondPIRSensor = false;
  bool tankValve = false;
  bool mainValve = false;

  bool flowrate = false;
  bool cado = false;
  void routeData(String topic, String data) {
    if (topic == Topics.firstPIRSensorTopic) {
      //trim() to remove spaces from data that comes from mqtt
      firstPIRSensor = bool.parse(data.trim());
      emit(GtDtaState());
    } else if (topic == Topics.secondPIRSensorTopic) {
      secondPIRSensor = bool.parse(data.trim());
      emit(GtDtaState());
    } else if (topic == Topics.tankValveTankroomTopic) {
      tankValve = bool.parse(data);
      emit(GtDtaState());
    } else if (topic == Topics.mainValveTankroomTopic) {
      mainValve = bool.parse(data);
      emit(GtDtaState());
    } else if (topic == Topics.cadoValveTopic) {
      cado = bool.parse(data);
      emit(GtDtaState());
    }
  }
}
