//here write logic
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:smart_home/core/util/topics.dart';
import 'package:smart_home/features/flowrate_room/cubit/flowrateroom_state.dart';

class FlowrateroomCubit extends Cubit<FlowrateroomState> {
  final MqttClientPayloadBuilder _p = MqttClientPayloadBuilder();
  late MqttServerClient client;
  FlowrateroomCubit(this.client) : super(FlowInitialState());
  static FlowrateroomCubit get(BuildContext context) =>
      BlocProvider.of(context);

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

  double mainFlowrateSensor = 0;
  double secondFlowrateSensor = 0;

  void routeData(String topic, String data) {
    if (topic == Topics.mainFlowrateTankroomTopic) {
      mainFlowrateSensor = double.parse(data);
      emit(FlowGetDataState());
    } else if (topic == Topics.secondFlowrateTankroomTopic) {
      secondFlowrateSensor = double.parse(data);
      emit(FlowGetDataState());
    }
  }
}
