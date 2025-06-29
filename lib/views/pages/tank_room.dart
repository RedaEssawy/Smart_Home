import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home/controler/controlroom_cubit/controlroom_cubit.dart';
import 'package:smart_home/controler/flowrateroom_cubit/flowrateroom_cubit.dart';
import 'package:smart_home/controler/tank_and_flow_cubit/tank_and_flow_cubit.dart';

import 'package:smart_home/core/util/topics.dart';
import 'package:smart_home/views/widgets/form_text_with_its_value.dart';

import 'package:smart_home/views/widgets/water_guage.dart';

import 'package:smart_home/controler/tankroom_cubit/tankroom_cubit.dart';
import 'package:smart_home/controler/tankroom_cubit/tankroom_state.dart';

class TankRoom extends StatefulWidget {
  const TankRoom({super.key});

  @override
  State<TankRoom> createState() => _TankRoomState();
}

class _TankRoomState extends State<TankRoom> {
  
  final flowrateController = TextEditingController();
  bool isWaterLevelLow = false;
  @override
/*************  ✨ Windsurf Command ⭐  *************/
  /// This function is called when the widget is inserted into the tree.
  ///
  /// It subscribes to the topics and listens to the updates of the topics.
  /// When there is an update it calls [TankroomCubit.getDataAndTopic] to
  /// get the data and its topic. And then it calls [_checkWaterLevel] to
  /// check if the water level is low.
///*******  e513c45d-c9c4-496b-a70a-e631539507ca  *******/
  void initState() {
    final cubit = BlocProvider.of<TankAndFlowCubit>(context);
    cubit.getTankAndFlow();
   
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
      isWaterLevelLow = context.read<TankAndFlowCubit>().tankAndFlowModels[2].value < 10;
    });
  }

 
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        //to make the appBar take the same features of the body
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text('Tank Status'),
          ),
          // leading: BackButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) =>
          //               NavBottomPage()), // Replace with your page
          //     );
          //   },
          // ),
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
              return LayoutBuilder(builder: (context, constraints) => SingleChildScrollView(
                child: BlocConsumer<TankAndFlowCubit, TankAndFlowState>(
                  listener: (context, state) {
                  },
                  builder: (context, state) {
                    return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TankGuage(
                                      tankLevel: state is TankAndFlowSuccess ? state.tankAndFlowModels.firstWhere((item)=> item.metricType =='tank_level').value : 0.0,
                                      flowrateState: TankroomCubit.get(context).flowrate,
                                    ),
                                    SizedBox(
                                      height:constraints.maxHeight * 0.01,
                                    ),
                                    if (isWaterLevelLow) _buildLowLevelAlert(),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.01,
                                    ),
                                    
                                    FormTextWithItsValue(
                                        stateOrValue: FlowrateroomCubit.get(context).secondFlowrateSensor ==0.0 ? 'No' : 'Yes',
                                        title: 'Tank filling?',
                                        iconOfLeading: Icons.water_drop,
                                        context: context),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.01,
                                    ),
                                    FormTextWithItsValue(
                                        stateOrValue:
                                            ControlroomCubit.get(context).motor.toString() == 'false' ? 'No' : 'Yes',
                                        title: 'Motor on ?',
                                        iconOfLeading: Icons.electrical_services,
                                        context: context),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.01,
                                    ),
                                    FormTextWithItsValue(
                                        stateOrValue:
                                            ControlroomCubit.get(context).mainValve.toString()== 'false' ? 'No' : 'Yes',
                                        title: 'Main Valve on ?',
                                        iconOfLeading: Icons.water_drop,
                                        context: context),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.01,
                                    ),
                                    FormTextWithItsValue(
                                        stateOrValue:
                                            ControlroomCubit.get(context).tankValve.toString() == 'false' ? 'No' : 'Yes',
                                        title: 'Secondary Valve on ?',
                                        iconOfLeading: Icons.water_drop,
                                        context: context),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.01,
                                    ),
                                    FormTextWithItsValue(
                                        stateOrValue:
                                            ControlroomCubit.get(context).cado.toString() == 'false' ? 'No' : 'Yes',
                                        title: 'Services valve on ?',
                                        iconOfLeading: Icons.water_drop,
                                        context: context),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.05,)
                                
                                    // FormTextWithItsValue(stateOrValue: TankroomCubit.get(context).flowrate.toString(), title: 'Flowrate', iconOfLeading: Icons.water_drop, context: context),
                                    // FormTextWithItsValue(stateOrValue: TankroomCubit.get(context).motor.toString(), title: 'Motor', iconOfLeading: Icons.water_drop, context: context),
                                
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
          )
            
          ),
        );
            }
    )
    )));
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
