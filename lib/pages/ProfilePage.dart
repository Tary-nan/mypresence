import 'package:mypresence/Manager/DataManage.dart';
import 'package:mypresence/Models/UserModel.dart';
import 'package:mypresence/helpers/Style/style.dart';
import 'package:mypresence/Widgets/ListileInfo.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class ProfilePage extends StatelessWidget {


  static const routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    double _hauteur = MediaQuery.of(context).size.height;
    double _largeur = MediaQuery.of(context).size.width;

    DataManager manager = context.fetch<DataManager>();

    Widget _headerButtonBack() {
      return Flexible(
        child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(20),
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop())),
      );
    }

    Widget _imageAndname() {
      return Flexible(
        flex: 2,
        child: Container(
          child: Column(children: <Widget>[
            Flexible(
                flex: 2,
                child: Container(
                  height: _hauteur,
                  width: _largeur,
                  child: Observer<User>(
                    stream: manager.userr,
                    onSuccess: (context, User data) {
                      return (data.image != null )?  Image.asset('images/icons8-reconnaissance-faciale-100.png',) : Image.asset('images/icons8-reconnaissance-faciale-100.png',);
                    }
                  ),
                )),
            Flexible(
                child: Observer<User>(
                  stream: manager.userr,
                  onSuccess: (context, User data) {
                    return Container(
                        alignment: Alignment.center,
                        height: _hauteur,
                        width: _largeur,
                        child: Text(
                          data.userLastName + " "+ data.userFirstName,
                          style: TextStyle(color: Colors.white70, fontSize: 21),
                        ));
                  }
                )),
          ]),
        ),
      );
    }

    Widget _dashBoardPresence() {
      return Flexible(
        child: Container(
          decoration: Style.decorationDashBoardPresence,
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
              Widget>[
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("21",
                      style: TextStyle(color: Colors.white70, fontSize: 25)),
                  Text("presence",
                      style: TextStyle(color: Colors.white70, fontSize: 15)),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("2",
                      style: TextStyle(color: Colors.white70, fontSize: 25)),
                  Text("abscence",
                      style: TextStyle(color: Colors.white70, fontSize: 15)),
                ],
              ),
            ),
          ]),
        ),
      );
    }

    Widget _anOtherifofromUser() {
      return Flexible(
        fit: FlexFit.loose,
        child: Observer<User>(
          stream: manager.userr,
          onSuccess: (context, User data) {
            return Container(
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              width: _largeur,
              height: _hauteur / 2.5,
              child: Column(children: <Widget>[
                SizedBox(height: 30),
                ListTileInfo(titre: "Prenom : ${data.userUsername}", couleur: Colors.deepPurple),
                ListTileInfo(titre: "Email : ${data.userEmail}", couleur: Colors.red),
                ListTileInfo(titre: "Genre : ${data.genre}", couleur: Colors.green),
                ListTileInfo(titre: "Contact : ${data.contacts}", couleur: Colors.blue),
              ]),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Colors.white70.withOpacity(.9),
              ),
            );
          }
        ),
      );
    }

    return Scaffold(
      body: Container(
          decoration: Style.decorationHeaderProfile,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                child: Container(
                  child: Column(children: <Widget>[
                    _headerButtonBack(),
                    _imageAndname(),
                    _dashBoardPresence(),
                  ]),
                ),
              ),
              _anOtherifofromUser(),
            ],
          )),
    );
  }
}
