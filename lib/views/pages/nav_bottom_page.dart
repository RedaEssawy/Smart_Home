import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/core/api/dio_consumer.dart';
import 'package:smart_home/core/util/app_colors.dart';
import 'package:smart_home/views/pages/control_room.dart';
import 'package:smart_home/views/pages/flowrate_room.dart';
import 'package:smart_home/views/pages/home.dart';
import 'package:smart_home/views/pages/lekage_room.dart';
import 'package:smart_home/views/pages/profile_page.dart';
import 'package:smart_home/views/pages/tank_room.dart';

class NavBottomPage extends StatefulWidget {
  const NavBottomPage({super.key});

  @override
  State<NavBottomPage> createState() => _NavBottomPageState();
}

class _NavBottomPageState extends State<NavBottomPage> {
  final PageController _pageController = PageController();
  int _index = 0;
  void _onItemTapped(int index) {
    setState(() {
      _index = index;
      _pageController.animateToPage
      (index, duration:
       const Duration(milliseconds: 500 ), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> bodyOptions =  [
    Home(),
    ControlRoom(),
    TankRoom(),
    FlowrateRoom(),
    LekageRoom(),
    ProfilePage(api: DioConsumer(dio: Dio()),),


  
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Center(
        //     child: Text(
        //       'Water Tracking',
        //       style: Theme.of(context).textTheme.headlineLarge!.copyWith(
        //             color: Theme.of(context).primaryColor,
        //           ),
        //     ),
        //   ),
        //   leading: BackButton(onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) =>
        //               NavBottomPage()), // Replace with your page
        //     );
        //   }),
        // ),
        // drawer: DrawerPage(),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _index = index;
            });
          },
      
          
          children: bodyOptions),
        bottomNavigationBar: BottomNavigationBar(
            // items is a list of BottomNavigationBarItem objects where each item represents a tab
            // and specifies the icon and label for each tab
            selectedItemColor: AppColors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.control_point), label: 'control'),
              BottomNavigationBarItem(
                icon: Icon(Icons.warning),
                label: 'Tank',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.water_drop),
                label: 'Flowrate',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.alarm_add),
                label: 'Leakage',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,),
                label: 'Profile',
              ),
              
            ],
            showUnselectedLabels: true,
            currentIndex: _index,
            onTap: _onItemTapped),
      ),
    );
  }
}
