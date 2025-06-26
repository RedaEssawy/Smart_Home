import 'package:flutter/material.dart';
import 'package:smart_home/controler/consumption_cubit/consumption_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PressureChart extends StatelessWidget {
  const PressureChart({super.key, required this.consumptionValue});

  final List<ConsumptionData> consumptionValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: SizedBox(
        height: 500,
        width: double.infinity,
        child: SfCartesianChart(
          primaryXAxis:  NumericAxis(
            //scall of vertical reading
            interval: 1,
            //If the reading increased the old reads will shifted
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(
              
                text: 'Time(days)',
                textStyle: Theme.of(context).textTheme.headlineSmall),
            isVisible: true,
          ),
          primaryYAxis:  NumericAxis(
            //scall of herozintal reading
            interval: 5,
            //If the reading increased the old reads will shifted
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(
                text: 'Consumption(M^3)',
                textStyle: Theme.of(context).textTheme.headlineSmall)  ,
            isVisible: true,
          ),
          series: [
            LineSeries<ConsumptionData, double>(
              color: Colors.green,
              xValueMapper: (ConsumptionData salse, _) => salse.x,
              yValueMapper: (ConsumptionData salse, _) => salse.y,
              dataSource: consumptionValue,
            )
          ],
        ),
      ),
    );
  }
}
