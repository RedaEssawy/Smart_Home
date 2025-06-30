import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/controler/update_consumption_rate_cubit/update_consumption_rate_cubit.dart';
import 'package:smart_home/views/widgets/lable_with_text_field.dart';

class SetConsumption extends StatefulWidget {
  const SetConsumption({super.key});

  @override
  State<SetConsumption> createState() => _SetConsumptionState();
}

class _SetConsumptionState extends State<SetConsumption> {
  final periodController = TextEditingController();
  final thresholdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Set Consumption'),
      ),
      body: BlocConsumer<UpdateConsumptionRateCubit, UpdateConsumptionRateState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    LableWithTextField(
                      title: 'Period',
                      controller: periodController,
                      prefixIcon: Icons.timer,
                      hintText: 'Enter period',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    LableWithTextField(
                      title: 'Threshold',
                      controller: thresholdController,
                      prefixIcon: Icons.timer,
                      hintText: 'Enter threshold',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onLongPress: (){               context.read<UpdateConsumptionRateCubit>().setConsumptionRate(tankLevel: thresholdController.text, period: periodController.text);},

                      onPressed: () {
                      context.read<UpdateConsumptionRateCubit>().updateConsumptionRate(tankLevel: thresholdController.text, period: periodController.text);
                    }, child: Text('Press once to update or long to set'))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
