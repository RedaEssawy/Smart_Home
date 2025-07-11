import 'package:flutter/material.dart';
import 'package:smart_home/views/pages/control_room.dart';
import 'package:smart_home/views/pages/login_page.dart';
import 'package:smart_home/views/pages/nav_bottom_page.dart';
import 'package:smart_home/core/util/app_routes.dart';
import 'package:smart_home/views/pages/home.dart';
import 'package:smart_home/views/pages/setting_page.dart';
import 'package:smart_home/views/pages/tank_room.dart';

import '../../views/pages/register_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.registerRoute:
        return MaterialPageRoute(builder:(_)=>const RegisterPage());
      case AppRoutes.dashboardRoute:
        return MaterialPageRoute(builder: (_)=> const NavBottomPage());
      case AppRoutes.controlRoomRoute:
        return MaterialPageRoute(builder: (_)=> const ControlRoom());
      case AppRoutes.tankRoomRoute:
        return MaterialPageRoute(builder: (_)=> const TankRoom());  
      case AppRoutes.settingRoute:
        return MaterialPageRoute(builder: (_)=> const SettingPage());
      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
  }
}
