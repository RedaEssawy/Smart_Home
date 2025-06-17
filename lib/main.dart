import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_home/core/pages/nav_bottom_page.dart';
import 'package:smart_home/core/util/app_router.dart';
import 'package:smart_home/core/util/app_routes.dart';
import 'package:smart_home/features/control_room/cubit/controlroom_cubit.dart';
import 'package:smart_home/features/flowrate_room/cubit/flowrateroom_cubit.dart';
import 'package:smart_home/features/home/cubit/home_cubit.dart';

import 'package:smart_home/features/lekage_room/cubit/lekageroom_cubit.dart';

import 'package:smart_home/features/tank_room/cubit/tankroom_cubit.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  // final MqttServerClient client =
  //     MqttServerClient.withPort('broker.hivemq.com', 'clientIdentifier', 1883);
  // MqttClientPayloadBuilder p = MqttClientPayloadBuilder();

  // client.connect().then((value) => {
  //       if (value!.state == client.connectionStatus!.state)
  //         {
  //           client.subscribe('test/flutter', MqttQos.atMostOnce),
  //           p.addString('hello from flutter'),
  //           client.publishMessage(
  //               'test/flutter', MqttQos.atMostOnce, p.payload!),
  //           client.updates!.listen((event) {
  //             MqttPublishMessage pm = event[0].payload as MqttPublishMessage;
  //             String msg =
  //                 MqttPublishPayload.bytesToStringAsString(pm.payload.message);
  //             print(msg);
  //           })
  //         }
  //     });

  // runApp(MyApp(client: client));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MqttClientPayloadBuilder p = MqttClientPayloadBuilder();
  final MqttServerClient client =
      //    MqttServerClient.withPort('broker.emqx.io', 'clientIdentifier', 1883);
      MqttServerClient.withPort('test.mosquitto.org', 'clientIdentifier', 1883);
  bool clientState = false;

  // String data = '';
  @override
  void initState() {
    client.connect().then((value) {
      if (value!.state == MqttConnectionState.connected) {
        clientState = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ControlroomCubit>(
          create: (BuildContext context) => ControlroomCubit(client),
        ),
        BlocProvider<TankroomCubit>(
          create: (BuildContext context) => TankroomCubit(client),
        ),
        BlocProvider<LekageroomCubit>(
          create: (BuildContext context) => LekageroomCubit(client),
        ),
        BlocProvider<FlowrateroomCubit>(
          create: (BuildContext context) => FlowrateroomCubit(client),
        ),
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(client),
        ),
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.loginRoute,
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor,
            ),
            dividerTheme:
                DividerThemeData(indent: 20, endIndent: 20, thickness: 1.5),
            primaryColor: Colors.deepOrange,
            primarySwatch: Colors.deepOrange),
        home: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
          ) {
            // ignore: unrelated_type_equality_checks
            final bool connected = connectivity != ConnectivityResult.none;
            return connected
                ? clientState
                    ? const NavBottomPage()
                    : const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                : const Scaffold(
                    body: Center(
                      child: Text('you are offline'),
                    ),
                  );
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'There are no bottons to push :)',
              ),
              Text(
                'Just turn off your internet.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
