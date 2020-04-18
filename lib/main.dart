import 'package:mypresence/Manager/DataManage.dart';
import 'package:mypresence/Manager/UserFormManager.dart';
import 'package:mypresence/pages/AuthLocalPage.dart';
import 'package:mypresence/pages/HomePage.dart';
import 'package:mypresence/pages/LoginPage.dart';
import 'package:mypresence/pages/ProfilePage.dart';
import 'package:mypresence/widgets/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Overseer.dart';
import 'package:sprinkle/Provider.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Provider(
      data: Overseer()
          .register<DataManager>(()=> DataManager())
          .register<UserFormManager>(()=> UserFormManager()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (BuildContext context) => SpashScreen(),
          HomePage.routeName : (BuildContext context)=> HomePage(),
          AuthentificateLocal.routeName : (BuildContext context)=> AuthentificateLocal(),
          ProfilePage.routeName : (BuildContext context)=> ProfilePage(),
          LoginPage.routeName : (BuildContext context)=> LoginPage(),
        },
      ),
    );
  }
}