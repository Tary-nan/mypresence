import 'package:flutter/material.dart';

class ListTileInfo extends StatelessWidget {
  ListTileInfo({this.titre, this.couleur});
  final String titre;
  final Color couleur;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(children: <Widget>[
        Container(
          child: Icon(
            Icons.blur_circular,
            color: couleur,
          ),
        ),
        SizedBox(width: 30),
        Text(
          titre,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ]),
    );
  }
}
