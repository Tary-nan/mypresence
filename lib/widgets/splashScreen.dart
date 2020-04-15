import 'package:mypresence/Manager/DataManage.dart';

import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:mypresence/pages/HomePage.dart';
import 'package:mypresence/pages/LoginPage.dart';
import 'package:sprinkle/SprinkleExtension.dart';
import 'package:flutter/material.dart';

class SpashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataManager manager = context.fetch<DataManager>();
    return Scaffold(
      body: SplashScreen.callback(
        name: 'images/splash_background.flr',
        startAnimation: 'splash',
        fit: BoxFit.cover,
        onSuccess: (res) {
          print(res);
          if (res == true) {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          } else {
            Navigator.pushReplacementNamed(context, LoginPage.routeName);
          }
        },
        onError: (res1, res2) {
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        },
        until: () => manager.restoreSession(),
      ),
    );
  }
}
