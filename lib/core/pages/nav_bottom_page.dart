import 'package:flutter/material.dart';
import 'package:smart_home/core/pages/drawer_page.dart';
import 'package:smart_home/features/control_room/control_room.dart';
import 'package:smart_home/features/home/home.dart';

class NavBottomPage extends StatefulWidget {
  const NavBottomPage({super.key});

  @override
  State<NavBottomPage> createState() => _NavBottomPageState();
}

class _NavBottomPageState extends State<NavBottomPage> {
  int _index = 0;
  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  List<Widget> bodyOptions = const [
    Home(),
    Center(child: Text('Consumption')),
    Center(child: Text('Alerts')),
    ControlRoom(),
    Center(child: Text('Settings'))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerPage(),
      body: bodyOptions[_index],
      bottomNavigationBar: BottomNavigationBar(
          // items is a list of BottomNavigationBarItem objects where each item represents a tab
          // and specifies the icon and label for each tab
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.water), label: 'Consumption'),
            BottomNavigationBarItem(
              icon: Icon(Icons.alarm),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.control_point_sharp),
              label: 'Control',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _index,
          onTap: _onItemTapped),
    );
  }
}
