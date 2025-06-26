import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home/controler/consumption_cubit/consumption_cubit.dart';
import 'package:smart_home/core/util/assets.dart';
import 'package:smart_home/core/util/topics.dart';
import 'package:smart_home/views/widgets/form_text_with_its_value.dart';

import 'package:smart_home/views/widgets/text_card.dart';
import 'package:smart_home/controler/flowrateroom_cubit/flowrateroom_cubit.dart';
import 'package:smart_home/controler/flowrateroom_cubit/flowrateroom_state.dart';

class FlowrateRoom extends StatefulWidget {
  const FlowrateRoom({super.key});

  @override
  State<FlowrateRoom> createState() => _FlowrateRoomState();
}

class _FlowrateRoomState extends State<FlowrateRoom> {
  @override
  void initState() {
    FlowrateroomCubit.get(context)
        .client
        .subscribe(Topics.mainFlowrateTankroomTopic, MqttQos.atMostOnce);

    FlowrateroomCubit.get(context)
        .client
        .subscribe(Topics.secondFlowrateTankroomTopic, MqttQos.atMostOnce);
    FlowrateroomCubit.get(context).client.updates!.listen((event) {
      // ignore: use_build_context_synchronously
      FlowrateroomCubit.get(context).getDataAndTopic(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //to make the appBar take the same features of the body
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Flowrate Room',
            style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: LayoutBuilder(
          builder: (context, constraints) =>
              SingleChildScrollView(
                child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    
                    width: constraints.maxWidth * 0.9,
                    height: constraints.maxHeight * 0.3,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(123, 233, 239, 241),
                        borderRadius: BorderRadius.circular(15)),
                    child: GridView.count(
                      // if shrinkWrap is true, you can't scroll
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10),
                      crossAxisCount: 2,
                      children: [
                        BlocBuilder<FlowrateroomCubit, FlowrateroomState>(
                          
                          builder: (context, state) {
                            return TextCard(
                                deviceName: 'Main Flowrate sensor',
                                deviceImage: Assets.pressureValueImage,
                                stringValue: FlowrateroomCubit.get(context)
                                    .mainFlowrateSensor);
                          },
                        ),
                        TextCard(
                            deviceName: 'Second Flowrate sensor',
                            deviceImage: Assets.pressureValueImage,
                            stringValue: FlowrateroomCubit.get(context)
                                .secondFlowrateSensor),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  BlocConsumer<ConsumptionCubit, ConsumptionState>(
                    listener: (context, state) {
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          FormTextWithItsValue(
                              stateOrValue: state is GetConsumptionRateSccess? '${state.consumptionModel.last12hoursConsumption} M^3' : '0 M^3',
                              title: 'Last 12 hr consumption',
                              iconOfLeading: Icons.water_drop_outlined,
                              context: context),
                          SizedBox(height: 20),
                          FormTextWithItsValue(
                              stateOrValue: state is GetConsumptionRateSccess? '${state.consumptionModel.dailyConsumption} M^3' : '0 M^3',
                              title: 'Daily consumption',
                              iconOfLeading: Icons.water_drop_outlined,
                              context: context),
                          SizedBox(height: 20),
                          FormTextWithItsValue(
                              stateOrValue: state is GetConsumptionRateSccess? '${state.consumptionModel.weeklyConsumption} M^3' : '0 M^3',
                              title: 'Weekly consumption',
                              iconOfLeading: Icons.water_drop_outlined,
                              context: context),
                          SizedBox(height: 20),
                          FormTextWithItsValue(
                              stateOrValue: state is GetConsumptionRateSccess? '${state.consumptionModel.monthlyConsumption} M^3' : '0 M^3',
                              title: 'Monthly consumption',
                              iconOfLeading: Icons.water_drop_outlined,
                              context: context),
                        ],
                      );
                    },
                  ),
                ]),
              )),
    );
  }
}
