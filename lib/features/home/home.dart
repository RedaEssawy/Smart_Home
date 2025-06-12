import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home/core/util/assets.dart';
import 'package:smart_home/core/util/topics.dart';
import 'package:smart_home/core/widgets/pressure_chart.dart';
import 'package:smart_home/core/widgets/water_box.dart';
import 'package:smart_home/features/control_room/control_room.dart';
import 'package:smart_home/features/flowrate_room/flowrate_room.dart';
import 'package:smart_home/features/home/cubit/home_cubit.dart';
import 'package:smart_home/features/home/cubit/home_state.dart';

import 'package:smart_home/features/lekage_room/lekage_room.dart';
import 'package:smart_home/features/tank_room/tank_room.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    HomeCubit.get(context)
        .client
        .subscribe(Topics.pressureSensorTopic, MqttQos.atMostOnce);
    HomeCubit.get(context).client.updates!.listen((event) {
      // ignore: use_build_context_synchronously
      HomeCubit.get(context).getDataAndTopic(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscap =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(218, 237, 209, 0.867),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Pages',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Text(
                        'See All',
                        style: TextStyle(
                          color: Color.fromARGB(170, 234, 225, 225),
                        ),
                      ),
                    ]),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: size.width * 0.03,
                  mainAxisSpacing: size.width * 0.03,
                  crossAxisCount: isLandscap ? 4 : 2,
                  children: [
                    WaterBox(
                      pageImage: Assets.tankImage,
                      pageName: 'Tank Page',
                      activeDevice: 'false',
                      deviceName: 'Active Filling',
                      destinationPage: TankRoom(),
                    ),
                    WaterBox(
                      pageImage: Assets.flowrateImage,
                      pageName: 'Flowrate Page',
                      activeDevice: 'false',
                      deviceName: 'Active Flowrate',
                      destinationPage: FlowrateRoom(),
                    ),
                    WaterBox(
                      pageImage: Assets.valveImage,
                      pageName: 'Control Page',
                      activeDevice: 'false',
                      deviceName: 'Anusual Usage',
                      destinationPage: ControlRoom(),
                    ),
                    WaterBox(
                      pageImage: Assets.waterLekageImage,
                      pageName: 'Lekage Page',
                      activeDevice: 'false',
                      deviceName: 'Is there lekage ',
                      destinationPage: LekageRoom(),
                    )
                  ],
                ),
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (BuildContext context, state) {
                  return PressureChart(
                    pressureValues: HomeCubit.get(context).pressureValues,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
