import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home/core/pages/nav_bottom_page.dart';

import 'package:smart_home/core/util/topics.dart';

import 'package:smart_home/core/widgets/water_guage.dart';

import 'package:smart_home/controler/tankroom_cubit/tankroom_cubit.dart';
import 'package:smart_home/controler/tankroom_cubit/tankroom_state.dart';

class TankRoom extends StatefulWidget {
  const TankRoom({super.key});

  @override
  State<TankRoom> createState() => _TankRoomState();
}

class _TankRoomState extends State<TankRoom> {
  bool isWaterLevelLow = false;
  @override
  void initState() {
    // to subscribe to the topics and get the data that belongs to motor
    TankroomCubit.get(context)
        .client
        .subscribe(Topics.motorTankroomTopic, MqttQos.atMostOnce);
    //to subscribe to the topics and get the data that belongs to tank valve
    TankroomCubit.get(context)
        .client
        .subscribe(Topics.tankValveTankroomTopic, MqttQos.atMostOnce);
    // to subscribe to the topics and get the data that belongs to main valve
    TankroomCubit.get(context)
        .client
        .subscribe(Topics.mainValveTankroomTopic, MqttQos.atMostOnce);
    // to subscribe to the topics and get the data that belongs to tank level
    TankroomCubit.get(context)
        .client
        .subscribe(Topics.tankLevelTankroomTopic, MqttQos.atMostOnce);
    // to subscribe to the topics and get the data that belongs to main flowrate
    TankroomCubit.get(context)
        .client
        .subscribe(Topics.mainFlowrateTankroomTopic, MqttQos.atMostOnce);

    TankroomCubit.get(context).client.updates!.listen((event) {
      // ignore: use_build_context_synchronously
      TankroomCubit.get(context).getDataAndTopic(event);
      _checkWaterLevel();
    });
    super.initState();
  }

  void _checkWaterLevel() {
    setState(() {
      isWaterLevelLow = TankroomCubit.get(context).tankLevel < 10;
    });
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
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text('Tank Status'),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NavBottomPage()), // Replace with your page
            );
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            // image: DecorationImage(
            //     // colorFilter: ColorFilter.linearToSrgbGamma(),
            //     image: AssetImage(Assets.tankRoomImage),
            //     fit: BoxFit.fill),
            ),
        child: BlocBuilder<TankroomCubit, TankroomState>(
          builder: (BuildContext context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TankGuage(
                  tankLevel: TankroomCubit.get(context).tankLevel,
                  flowrateState: TankroomCubit.get(context).flowrate,
                ),
                SizedBox(
                  height: 30,
                ),
                if (isWaterLevelLow) _buildLowLevelAlert()

                // Container(
                //     width: double.infinity,
                //     height: 600,
                //     decoration: BoxDecoration(
                //         color: const Color.fromARGB(123, 233, 239, 241),
                //         borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(50),
                //             topRight: Radius.circular(50))),

                // GridView.count(
                //     padding: EdgeInsets.only(top: 5),
                //     crossAxisCount: 2,
                //     children: [
                //       DevicesCard(
                //         deviceName: 'Motor',
                //         deviceImage: Assets.motorImage,
                //         deviceState: TankroomCubit.get(context).motor,
                //         onChange: (value) {
                //           TankroomCubit.get(context).publish(
                //               Topics.motorTankroomTopic, value.toString());
                //         },
                //       ),
                //       DevicesCard(
                //           //to change the state of the button of the tankValve
                //           deviceState: TankroomCubit.get(context).tankValve,
                //           onChange: (value) {
                //             //to publish on the topic when the putton pressed send event to the broker
                //             TankroomCubit.get(context).publish(
                //                 Topics.tankValveTankroomTopic,
                //                 value.toString());
                //             debugPrint('how i can help you ');
                //           },
                //           deviceName: 'Tank Valve',
                //           deviceImage: Assets.tankValveImage),
                //       DevicesCard(
                //           deviceState: TankroomCubit.get(context).mainValve,
                //           onChange: (value) {
                //             TankroomCubit.get(context).publish(
                //                 Topics.mainValveTankroomTopic,
                //                 value.toString());
                //           },
                //           deviceName: 'Main Valve',
                //           deviceImage: Assets.tankValveImage),
                //       TextCard(
                //           deviceName: 'Tank Level',
                //           deviceImage: Assets.tankLevelImage,
                //           stringValue: TankroomCubit.get(context).tankLevel)
                //     ]),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget _buildLowLevelAlert() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: Colors.red),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Warning: Water level is critically low!',
              style: TextStyle(
                color: Colors.red[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
