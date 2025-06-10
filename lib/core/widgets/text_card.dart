import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  // final TextEditingController _nmberController = TextEditingController();
  final String deviceName;
  final String deviceImage;
  final double stringValue;

  const TextCard(
      {super.key,
      required this.deviceName,
      required this.deviceImage,
      required this.stringValue});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(25),
      elevation: 2,
      color: Colors.transparent,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              scale: .2,
              deviceImage,
              width: double.infinity,
              height: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  deviceName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  '$stringValue',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
