import 'package:flutter/material.dart';

// import 'package:smart_home/core/util/assets.dart';

class WaterBox extends StatelessWidget {
  const WaterBox({
    super.key,
    required this.pageImage,
    required this.pageName,
    required this.activeDevice,
    required this.deviceName,
    required this.destinationPage,
  });
  final String pageImage;
  final String pageName;
  final String activeDevice;
  final String deviceName;
  final Widget destinationPage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: size.width * 0.4,
        height: size.height * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
                image: AssetImage(pageImage), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              pageName,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            Text('$deviceName = $activeDevice',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ))
          ],
        ),
      ),
    );
  }
}
