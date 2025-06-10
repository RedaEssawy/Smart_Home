import 'package:flutter/material.dart';
import 'package:smart_home/features/control_room/control_room.dart';
import 'package:smart_home/features/tank_room/tank_room.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("User Name"),
            accountEmail: Text("user@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("U", style: TextStyle(fontSize: 24)),
            ),
          ),
          ListTile(
            leading:
                Icon(Icons.water_damage, color: Theme.of(context).primaryColor),
            title: Text("Tank Status"),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TankRoom()),
              );
            },
          ),
          ListTile(
              leading: Icon(
                Icons.control_point,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Control "),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ControlRoom()));
              }),
          ListTile(
            leading:
                Icon(Icons.assignment, color: Theme.of(context).primaryColor),
            title: Text("Quality Report"),
            onTap: () => Navigator.pushNamed(context, '/quality'),
          ),
          ListTile(
            leading:
                Icon(Icons.person_pin, color: Theme.of(context).primaryColor),
            title: Text("Presence Logs"),
            onTap: () => Navigator.pushNamed(context, '/presence'),
          ),
          Divider(),
          ListTile(
            leading:
                Icon(Icons.settings, color: Theme.of(context).primaryColor),
            title: Text("Settings"),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          ListTile(
            leading: Icon(Icons.help, color: Theme.of(context).primaryColor),
            title: Text("Help"),
            onTap: () => Navigator.pushNamed(context, '/help'),
          ),
        ],
      ),
    );
  }
}
