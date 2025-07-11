import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home/controler/bulk_cubit/bulk_cubit.dart';
import 'package:smart_home/core/util/app_colors.dart';
import 'package:smart_home/core/util/assets.dart';
import 'package:smart_home/core/util/topics.dart';
import 'package:smart_home/controler/controlroom_cubit/controlroom_state.dart';
import 'package:smart_home/views/widgets/devices_card.dart';

import '../../controler/controlroom_cubit/controlroom_cubit.dart';

class ControlRoom extends StatefulWidget {
  const ControlRoom({super.key});

  @override
  State<ControlRoom> createState() => _ControlRoomState();
}

class _ControlRoomState extends State<ControlRoom> {
  bool _controllCase = true;
  // final motorStatus = TextEditingController();

  @override
  void initState() {
// final cubit = BlocProvider.of<MotorCubit>(context);
    // cubit.setMotorState(motorStatus: );
    

    ControlroomCubit.get(context)
        .client
        .subscribe(Topics.motorTankroomTopic, MqttQos.atMostOnce);
    ControlroomCubit.get(context)
        .client
        .subscribe(Topics.tankValveTankroomTopic, MqttQos.atMostOnce);
    ControlroomCubit.get(context)
        .client
        .subscribe(Topics.mainValveTankroomTopic, MqttQos.atMostOnce);

    ControlroomCubit.get(context)
        .client
        .subscribe(Topics.cadoValveTopic, MqttQos.atMostOnce);

    ControlroomCubit.get(context).client.updates!.listen((event) {
      // ignore: use_build_context_synchronously
      ControlroomCubit.get(context).getDataAndTopic(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final buttonController = TextEditingController();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      //to make the appBar take the same features of the body
      extendBodyBehindAppBar: true,

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      //   // title: Padding(
      //   //   padding: const EdgeInsets.only(bottom: 11.0),
      //   //   child: Text(
      //   //     'Control Room',
      //   //     style: Theme.of(context).textTheme.headlineLarge!.copyWith(
      //   //           color: Theme.of(context).primaryColor,
      //   //         ),
      //   //   ),
      //   // ),
      //   // leading: BackButton(onPressed: () {
      //   //   Navigator.push(
      //   //     context,
      //   //     MaterialPageRoute(
      //   //         builder: (context) =>
      //   //             NavBottomPage()), // Replace with your page
      //   //   );
      //   // }),
      // ),

      body: Container(
        padding: EdgeInsets.all(20),
        width: size.width,
        height: size.height * .9,
        child: BlocBuilder<ControlroomCubit, ControlroomState>(
          builder: (BuildContext context, state) {
            final isLandscap =
                MediaQuery.of(context).orientation == Orientation.landscape;
            return LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            //ClipRRect: to make the image rounded corners to make it look like a circle
                            borderRadius:
                                BorderRadius.circular(size.width * 0.1),
                            child: Image.asset(
                              'assets/images/control.jpeg',
                              fit: BoxFit.fitWidth,
                              height: size.height * 0.15,
                              width: size.width * 0.9,
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.02,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(StadiumBorder(
                                  side: BorderSide(color: AppColors.green))),
                            ),
                            onPressed: () {
                              setState(() {
                                _controllCase = !_controllCase;
                              });
                            },
                            // statesController: buttonController

                            child: Text(
                              'Automatic Control',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.02,
                          ),
                          _controllCase
                              ? Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                  padding: EdgeInsets.all(
                                      constraints.maxWidth * 0.001),
                                      // child: Column(
                                      //   children: [

                                      //     // IconButton(onPressed: onPressed, icon:Icons.engineering) 
                                      //   // LableWithTextField(title: 'Motor', controller: motorController,  prefixIcon: Icons.engineering  , hintText: "Motor",),
                                      // ]),

                                  child: GridView.count(
                                      mainAxisSpacing:
                                          constraints.maxHeight * 0.01,
                                      padding: EdgeInsets.all(
                                          constraints.maxWidth * 0.01),
                                      crossAxisCount: isLandscap ? 4 : 2,
                                      children: [
                                        DevicesCard(
                                          deviceName: 'Main Valve',
                                          deviceImage:
                                              Assets.tankValveImage,
                                          deviceState:
                                              ControlroomCubit.get(context)
                                                  .mainValve,
                                          onChange: (value) {
                                            ControlroomCubit.get(context)
                                                .publish(
                                                    Topics
                                                        .mainValveTankroomTopic,
                                                    value.toString());
                                          },
                                        ),
                                        DevicesCard(
                                            deviceState:
                                                ControlroomCubit.get(
                                                        context)
                                                    .tankValve,
                                            onChange: (value) {
                                              ControlroomCubit.get(context)
                                                  .publish(
                                                      Topics
                                                          .tankValveTankroomTopic,
                                                      value.toString());
                                            },
                                            deviceName: 'Tank Valve',
                                            deviceImage:
                                                Assets.tankValveImage),
                                        DevicesCard(
                                            deviceState:
                                                ControlroomCubit.get(
                                                        context)
                                                    .cado,
                                            onChange: (value) {
                                              ControlroomCubit.get(context)
                                                  .publish(
                                                      Topics.cadoValveTopic,
                                                      value.toString());
                                            },
                                            deviceName: 'Services Valve',
                                            deviceImage:
                                                Assets.tankValveImage),
                                        BlocConsumer<BulkCubit,
                                            BulkState>(
                                          listener: (context, state) {},
                                          builder: (context, state) {
                                            return DevicesCard(
                                              deviceName: 'Motor',
                                              deviceImage:
                                                  Assets.motorImage,
                                              deviceState:
                                                  ControlroomCubit.get(
                                                          context)
                                                      .motor,
                                              onChange: (value) {
                                                state is BulkSuccess
                                                    ? context.read<BulkCubit>().bulkRepo.setMotor(value: value.toString())  : false;
                                                // ControlroomCubit.get(
                                                //         context)
                                                //     .publish(
                                                //         Topics
                                                //             .motorTankroomTopic,
                                                //         value.toString()
                                                        // );
                                              },
                                            );
                                          },
                                        ),
                                      ]),
                                )
                              : SizedBox(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight * .7,
                                  child: Image(
                                    image: Image.asset(
                                      'assets/images/automatic-control.png',
                                    ).image,
                                    fit: BoxFit.contain,
                                  ))
                        ],
                      ),
                    ));
          },
        ),
      ),
    );
  }
}
