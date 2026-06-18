import 'package:flutter/material.dart';

import '../screens/mobile/login_mobile.dart';
// import '../screens/mobile/mobile_home.dart';
import '../screens/web/login_web.dart';
// import '../screens/web/web_home.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        if (constraints.maxWidth > 900) {
          return const LoginWeb();
          //return const WebHome();
        } else {
          return const LoginMobile();
          //return const MobileHome();
        }

      },
    );
  }
}