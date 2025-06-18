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
    return LayoutBuilder(
        builder: (context, constraints) => Card(
              margin: EdgeInsets.all(constraints.maxWidth * 0.025),
              elevation: 3,
              color: Colors.transparent,
              shape: ContinuousRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(constraints.maxWidth * 0.4)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(constraints.maxWidth * 0.06),
                    child: Image.asset(
                      scale: .2,
                      deviceImage,
                      width: constraints.maxWidth * 0.4,
                      height: constraints.maxWidth * 0.4,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                    child: Column(
                      children: [
                        Text(deviceName,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                )),
                        Text('$stringValue',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
