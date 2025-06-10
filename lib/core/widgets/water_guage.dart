import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class TankGuage extends StatelessWidget {
  final bool flowrateState;
  final double tankLevel;

  const TankGuage(
      {super.key, required this.tankLevel, required this.flowrateState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: AnimatedRadialGauge(
        duration: Duration(seconds: 1),
        value: tankLevel,
        radius: 120,
        axis: GaugeAxis(
            max: 100,
            min: 10,
            degrees: 180,
            progressBar: GaugeProgressBar.rounded(color: getColor(tankLevel)),
            style: GaugeAxisStyle(background: Colors.transparent),
            segments: [
              GaugeSegment(
                  from: 0,
                  to: 25,
                  color: Colors.transparent,
                  border: GaugeBorder(color: getColor(tankLevel))),
              GaugeSegment(
                  from: 26,
                  to: 50,
                  color: Colors.transparent,
                  border: GaugeBorder(color: getColor(tankLevel))),
              GaugeSegment(
                  from: 51,
                  to: 75,
                  color: Colors.transparent,
                  border: GaugeBorder(color: getColor(tankLevel))),
              GaugeSegment(
                  from: 76,
                  to: 100,
                  color: Colors.transparent,
                  border: GaugeBorder(color: getColor(tankLevel)))
            ]),
        //the part that inside the simi cericle
        builder: (context, child, value) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(123, 233, 239, 241)),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$flowrateState',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'water level $tankLevel%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(double value) {
    if (value <= 25) {
      return Colors.red;
    } else if (value <= 50 && value > 25) {
      return const Color.fromARGB(255, 228, 147, 141);
    } else if (value <= 75 && value > 50) {
      return Colors.lightGreen;
    } else {
      return Colors.green;
    }
  }
}
