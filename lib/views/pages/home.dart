import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home/controler/consumption_cubit/consumption_cubit.dart';
import 'package:smart_home/core/api/dio_consumer.dart';
import 'package:smart_home/core/util/topics.dart';
import 'package:smart_home/repositories/consumption_repository.dart';
import 'package:smart_home/views/widgets/home_carousel.dart';
import 'package:smart_home/views/widgets/pressure_chart.dart';
import 'package:smart_home/controler/home_cubit/home_cubit.dart';


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
    // final size = MediaQuery.of(context).size;
    final isLandscap =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color.fromRGBO(218, 237, 209, 0.867),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LayoutBuilder(builder: (context, constraints)=>
          !isLandscap ? 

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              
              SizedBox(
                height: constraints.maxHeight * 0.3,
                width: constraints.maxWidth * 0.9,
                child: HomeCarousel()),
              
               SizedBox(height: constraints.maxHeight * 0.02),
              // Expanded(
              //   child: GridView.count(
              //     shrinkWrap: true,
              //     padding: EdgeInsets.all( size.width * 0.02),
              //     crossAxisSpacing: size.width * 0.02,
              //     mainAxisSpacing: size.height * 0.002,
              //     crossAxisCount: isLandscap ? 4 : 2,
              //     children: [
              //       WaterBox(
              //         pageImage: Assets.tankImage,
              //         pageName: 'Tank Page',
              //         activeDevice: 'false',
              //         deviceName: 'Active Filling',
              //         destinationPage: TankRoom(),
              //       ),
              //       WaterBox(
              //         pageImage: Assets.flowrateImage,
              //         pageName: 'Flowrate Page',
              //         activeDevice: 'false',
              //         deviceName: 'Active Flowrate',
              //         destinationPage: FlowrateRoom(),
              //       ),
              //       WaterBox(
              //         pageImage: Assets.valveImage,
              //         pageName: 'Control Page',
              //         activeDevice: 'false',
              //         deviceName: 'Anusual Usage',
              //         destinationPage: ControlRoom(),
              //       ),
              //       WaterBox(
              //         pageImage: Assets.waterLekageImage,
              //         pageName: 'Lekage Page',
              //         activeDevice: 'false',
              //         deviceName: 'Is there lekage ',
              //         destinationPage: LekageRoom(),
              //       )
              //     ],
              //   ),
              // ),
              BlocConsumer<ConsumptionCubit, ConsumptionState>(
                listener: (context, state) {

                },
                builder: (context, state) {
                  return SizedBox(
                              height: constraints.maxHeight * 0.4,
                              width: constraints.maxWidth * 0.9,
                              child: PressureChart(
                                consumptionValue: ConsumptionCubit(ConsumptionRepository(
                                  api: DioConsumer(dio: Dio()),
                                )).consumptionData,
                              ),
                            );
                },
              )
            ],
          ): 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               SizedBox(
                height: constraints.maxHeight ,
                width: constraints.maxWidth * 0.45,
                child: HomeCarousel()),

               
                
                  BlocConsumer<ConsumptionCubit, ConsumptionState>(
                    listener: (context, state) {
                    },
                    builder: (context, state) {
                      return SizedBox(
                                      height: constraints.maxHeight ,
                                      width: constraints.maxWidth * 0.45,
                                      child: PressureChart(
                                        consumptionValue: ConsumptionCubit(ConsumptionRepository(
                                          api: DioConsumer(dio: Dio()),
                                        )).consumptionData,
                                      ),
                                    );
                    },
                  )]
                
              // )
             
            
          )
        ),
      ),
    ));
  }
}


