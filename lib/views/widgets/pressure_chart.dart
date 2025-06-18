import 'package:flutter/material.dart';
import 'package:smart_home/controler/home_cubit/home_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PressureChart extends StatelessWidget {
  const PressureChart({super.key, required this.pressureValues});

  final List<SaleData> pressureValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: SfCartesianChart(
          primaryXAxis: const NumericAxis(
            //scall of vertical reading
            interval: 1,
            //If the reading increased the old reads will shifted
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(
                text: 'Time',
                textStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            isVisible: true,
          ),
          primaryYAxis: const NumericAxis(
            //scall of herozintal reading
            interval: 5,
            //If the reading increased the old reads will shifted
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            title: AxisTitle(
                text: 'Pressure',
                textStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            isVisible: true,
          ),
          series: [
            LineSeries<SaleData, double>(
              color: Colors.green,
              xValueMapper: (SaleData salse, _) => salse.x,
              yValueMapper: (SaleData salse, _) => salse.y,
              dataSource: pressureValues,
            )
          ],
        ),
      ),
    );
  }
}
