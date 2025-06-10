import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home/core/util/assets.dart';
import 'package:smart_home/core/util/topics.dart';

import 'package:smart_home/core/widgets/text_card.dart';
import 'package:smart_home/features/flowrate_room/cubit/flowrateroom_cubit.dart';
import 'package:smart_home/features/flowrate_room/cubit/flowrateroom_state.dart';
import 'package:smart_home/features/home/cubit/home_cubit.dart';

import 'package:smart_home/features/home/home.dart';

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
      extendBodyBehindAppBar: true,
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
        leading: BackButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home()), // Replace with your page
          );
        }),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              // colorFilter: ColorFilter.linearToSrgbGamma(),
              image: AssetImage(Assets.tankRoomImage),
              fit: BoxFit.fill),
        ),
        child: BlocBuilder<FlowrateroomCubit, FlowrateroomState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: double.infinity,
                  height: 700,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(123, 233, 239, 241),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: GridView.count(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    crossAxisCount: 2,
                    children: [
                      TextCard(
                          deviceName: 'Main Flowrate sensor',
                          deviceImage: Assets.flowrateValveImage,
                          stringValue: FlowrateroomCubit.get(context)
                              .mainFlowrateSensor),
                      TextCard(
                          deviceName: 'Second Flowrate sensor',
                          deviceImage: Assets.flowrateValveImage,
                          stringValue: FlowrateroomCubit.get(context)
                              .secondFlowrateSensor),
                      TextCard(
                          deviceName: 'Pressure Value',
                          deviceImage: Assets.pressureValueImage,
                          stringValue: HomeCubit.get(context).pressure)
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
