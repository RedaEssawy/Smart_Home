import 'package:flutter/material.dart';
import 'package:smart_home/core/util/app_colors.dart';

class DevicesCard extends StatelessWidget {
  // final TextEditingController _nmberController = TextEditingController();
  final String deviceName;
  final String deviceImage;
  final bool deviceState;
  final Function(bool?) onChange;
  const DevicesCard({
    super.key,
    required this.deviceName,
    required this.deviceImage,
    required this.deviceState,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (context, constraints) => Card(
              margin: EdgeInsets.all(constraints.maxWidth * 0.025),
              // elevation: isLandscap ? 4 : 2,
              color: Colors.transparent,
              shape: ContinuousRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(constraints.maxWidth * 0.5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                      child: Image.asset(
                        deviceImage,
                        width: size.width * 0.3,
                        height: size.height * 0.1,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02   ,),
                    Padding(
                      padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            deviceName,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: constraints.maxWidth * 0.1),
                          SizedBox(
                            width: constraints.maxWidth * 0.1,
                            height: constraints.maxWidth * 0.1,
                            child: Switch(
                              value: deviceState,
                              onChanged: onChange,
                              activeColor: const Color.fromRGBO(7, 223, 14, 1),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
