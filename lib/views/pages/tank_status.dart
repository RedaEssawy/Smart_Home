import 'package:flutter/material.dart';

class TankStatusPage extends StatefulWidget {
  @override
  _TankStatusPageState createState() => _TankStatusPageState();
}

class _TankStatusPageState extends State<TankStatusPage> {
  double waterLevel = 90.0; // Example value - replace with your MQTT data
  bool isLowLevelAlert = false;

  @override
  void initState() {
    super.initState();
    _checkWaterLevel();
  }

// to check the water level
  void _checkWaterLevel() {
    setState(() {
      isLowLevelAlert = waterLevel < 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tank Status'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Water Level Gauge
            _buildWaterLevelGauge(),
            SizedBox(height: 30),
            // Percentage Text
            _buildPercentageText(),
            SizedBox(height: 30),
            // Additional Info
            _buildAdditionalInfo(),
            // Low Level Alert
            if (isLowLevelAlert) _buildLowLevelAlert(),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterLevelGauge() {
    return Container(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Circle
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue[100]!,
                width: 10,
              ),
            ),
          ),
          // Water Fill
          ClipOval(
            clipper: _CircleClipper(waterLevel / 100),
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.blue[800]!, Colors.blue[400]!],
                ),
              ),
            ),
          ),
          // Center Text
          Text(
            '${waterLevel.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPercentageText() {
    return Text(
      'Current Water Level: ${waterLevel.toStringAsFixed(1)}%',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildInfoItem(Icons.access_time, 'Last Updated', 'Just now'),
            _buildInfoItem(Icons.storage, 'Tank Capacity', '1000 L'),
          ],
        ),
      ],
    );
  }

// Function to build individual info items with icon, title, and value
/*************  ✨ Windsurf Command ⭐  *************/
  /// Builds a widget displaying an information item with an icon, title, and value.
  ///
  /// The widget is structured as a column containing an icon, a title, and a value.
  /// The icon is displayed at the top with a size of 30 and blue color.
  /// The title is a text widget with a font size of 14.
  /// The value is a bold text widget with a font size of 16.
  ///
  /// Parameters:
  /// - [icon]: The icon to display at the top of the info item.
  /// - [title]: The title text to display below the icon.
  /// - [value]: The value text to display below the title.

/*******  e19704ed-66b7-4f4f-bfe0-e160a4be7709  *******/ Widget _buildInfoItem(
      IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        SizedBox(height: 5),
        Text(title, style: TextStyle(fontSize: 14)),
        Text(value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

// Function to build the low level alert
  Widget _buildLowLevelAlert() {
    return Container(
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
    );
  }
}

// Custom clipper for the water fill effect
class _CircleClipper extends CustomClipper<Rect> {
  final double percentage;

  _CircleClipper(this.percentage);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      0,
      size.height * (1 - percentage),
      size.width,
      size.height,
    );
  }

// Returns true to indicate that the clipper should be re-clipped when the old clipper is not equal to the new clipper
  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
