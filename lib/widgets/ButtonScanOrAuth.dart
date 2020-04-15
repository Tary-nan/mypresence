import 'package:flutter/material.dart';

class ButtonScanOrAuth extends StatelessWidget {
  ButtonScanOrAuth({this.titre, this.color, this.border});

  final String titre;
  final Color color;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 50,
        width: MediaQuery.of(context).size.width / 1.3,
        child: Text(
          titre,
          style: TextStyle(color: Colors.white70),
        ),
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: border),
            borderRadius: BorderRadius.all(Radius.circular(20))));
  }
}
