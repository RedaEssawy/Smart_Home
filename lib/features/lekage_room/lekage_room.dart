import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home/core/util/assets.dart';
import 'package:smart_home/core/util/topics.dart';
import 'package:smart_home/core/widgets/devices_card.dart';
import 'package:smart_home/features/home/home.dart';
import 'package:smart_home/features/lekage_room/cubit/lekageroom_cubit.dart';
import 'package:smart_home/features/lekage_room/cubit/lekageroom_state.dart';

class LekageRoom extends StatefulWidget {
  const LekageRoom({super.key});

  @override
  State<LekageRoom> createState() => _LekageRoomState();
}

class _LekageRoomState extends State<LekageRoom> {
  @override
  void initState() {
    LekageroomCubit.get(context)
        .client
        .subscribe(Topics.firstPIRSensorTopic, MqttQos.atMostOnce);

    LekageroomCubit.get(context)
        .client
        .subscribe(Topics.secondPIRSensorTopic, MqttQos.atMostOnce);
    LekageroomCubit.get(context)
        .client
        .subscribe(Topics.tankValveTankroomTopic, MqttQos.atMostOnce);
    LekageroomCubit.get(context)
        .client
        .subscribe(Topics.mainValveTankroomTopic, MqttQos.atMostOnce);

    LekageroomCubit.get(context)
        .client
        .subscribe(Topics.mainFlowrateTankroomTopic, MqttQos.atMostOnce);

    LekageroomCubit.get(context).client.updates!.listen((event) {
      // ignore: use_build_context_synchronously
      LekageroomCubit.get(context).getDataAndTopic(event);
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
            'Lekage Room',
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
        child: BlocBuilder<LekageroomCubit, LekageroomState>(
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
                  child: Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      crossAxisCount: 2,
                      children: [
                        DevicesCard(
                          deviceName: 'First API Sensor',
                          deviceImage: Assets.activeSensorImage,
                          deviceState:
                              LekageroomCubit.get(context).firstPIRSensor,
                          onChange: (value) {
                            LekageroomCubit.get(context).publish(
                                Topics.firstPIRSensorTopic, value.toString());
                          },
                        ),
                        DevicesCard(
                          deviceName: 'Second API Sensor',
                          deviceImage: Assets.activeSensorImage,
                          deviceState:
                              LekageroomCubit.get(context).secondPIRSensor,
                          onChange: (value) {
                            LekageroomCubit.get(context).publish(
                                Topics.secondPIRSensorTopic, value.toString());
                          },
                        ),
                        DevicesCard(
                            deviceState: LekageroomCubit.get(context).tankValve,
                            onChange: (value) {
                              LekageroomCubit.get(context).publish(
                                  Topics.tankValveTankroomTopic,
                                  value.toString());
                            },
                            deviceName: 'Tank Valve',
                            deviceImage: Assets.tankValveImage),
                        DevicesCard(
                            deviceState: LekageroomCubit.get(context).mainValve,
                            onChange: (value) {
                              LekageroomCubit.get(context).publish(
                                  Topics.mainValveTankroomTopic,
                                  value.toString());
                            },
                            deviceName: 'Main Valve',
                            deviceImage: Assets.tankValveImage)
                      ],
                    ),
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
