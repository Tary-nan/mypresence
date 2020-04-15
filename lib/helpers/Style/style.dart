import 'package:flutter/material.dart';

class Style {
  static const urlImageFaceId = "icons8-reconnaissance-faciale-100.png";
  static const urlImageTouchId = "icons8-empreinte-digitale-100.png";
  static BoxDecoration decorationHeaderProfile = BoxDecoration(
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff2d9de5), Color(0xffffffff)]));

  static BoxDecoration decorationHome = BoxDecoration(
      boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1)],
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff2d9de5), Colors.blue.shade100]));

  static BoxDecoration decorationDashBoardPresence = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white70.withOpacity(.1));
}
