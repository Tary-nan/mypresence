import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';


class FingerPrint extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<FingerPrint> {
  @override
  Widget build(BuildContext context) {
    return Container(child: new FlareActor("images/Fingerprint.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"process"));
  }
}

