import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dialogShow(BuildContext context){
  return showDialog(
    context: context,
    builder: (_)=>(
      Platform.isIOS)        
      ?
      CupertinoAlertDialog(
          title: Text("Tous les champs doivent êtes remplir ?"),
          actions: <Widget>[
            FlatButton(onPressed:()=>Navigator.pop(context), child: Text("retour ",style: TextStyle(color: Colors.blue)))
          ],
    ):
    AlertDialog(
      title: Text("Tous les champs doivent êtes remplir ?"),
      actions: <Widget>[         
        FlatButton(onPressed:()=>Navigator.pop(context), child: Text("retour",style: TextStyle(color: Colors.blue)))
      ],
    )
  );
}

dialogShowAvailableBiometric(BuildContext context){
  return showDialog(
    context: context,
    builder: (_)=>(
      Platform.isIOS)        
      ?
      CupertinoAlertDialog(
          title: Text("L'autentification de Type Touche ID et Face ID n'est pas disponible sur ce telephone", style: TextStyle(fontSize:13),),
          actions: <Widget>[
            FlatButton(onPressed:()=>Navigator.pop(context), child: Text("retour ",style: TextStyle(color: Colors.blue)))
          ],
    ):
    AlertDialog(
      title: Text("L'autentification de Type Touche ID et Face ID n'est pas disponible sur ce telephone", style: TextStyle(fontSize:13)),
      actions: <Widget>[         
        FlatButton(onPressed:()=>Navigator.pop(context), child: Text("retour",style: TextStyle(color: Colors.blue)))
      ],
    )
  );
}