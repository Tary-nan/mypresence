import 'package:flutter/material.dart';
import 'package:mypresence/Manager/DataManage.dart';
import 'package:mypresence/Models/UserModel.dart';
import 'package:mypresence/Models/dataRessource.dart';
import 'package:mypresence/helpers/Style/style.dart';
import 'package:mypresence/pages/AuthLocalPage.dart';
import 'package:mypresence/widgets/pageRoute.dart';
import 'package:mypresence/pages/ProfilePage.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class HomePage extends StatelessWidget {

  static const routeName = "/home";

  final List<CardModel> dataCard = DataCard.getdata();

  @override
  Widget build(BuildContext context) {

    DataManager manager = context.fetch<DataManager>();
    manager.restoreSession();


    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        decoration: Style.decorationHome,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Expanded(child: _buildHeader(),),
            Expanded(
                child: Row(
                  children: dataCard.map((elementCard) => Flexible(fit: FlexFit.loose,child: _buildCard(context, data: elementCard)),).toList(),
                )),
          ],
        ),
      ),
    );
  }
}


Widget _buildHeader() {
  return Column(
    children: <Widget>[

      Expanded(child: Column(
        children: <Widget>[

          Text('Welcome back!',
              textAlign: TextAlign.center,
              style:
              TextStyle(color: Color(0xFFffffff), fontSize: 32, height: 1.2)),
          SizedBox(height: 20),
          Text('good moring ding dong ..',
              textAlign: TextAlign.center,
              style:
              TextStyle(color: Color(0xFFffffff), fontSize: 15, height: 1.2)),

        ],
      ),),
      Expanded(
        flex: 2,
        child: Container(
        child: Image.asset("images/scanqr.png"),
      ),)

    ],
  );
}

Widget _buildCard(
    context, {
      CardModel data,
    }) {
  return Center(
    child: GestureDetector(
        onTap: () => Navigator.push(
            context,WhitePageRoute(enterPage: AuthentificateLocal(data: data,))),
        child: Hero(
          tag: data.tagHero,
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height / 4,
            child: Scenery(
              data: data,
            ),
          ),
        )),
  );
}

Widget _buildAppBar(BuildContext ctx) {

  DataManager manager = ctx.fetch<DataManager>();
  return AppBar(
    elevation: 0.0,
    backgroundColor: Color(0xff2d9de5),
    brightness: Brightness.light,
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
            onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (context)=> ProfilePage())),
            child: Observer<User>(
              stream: manager.userr,
              onWaiting: (ctx)=> Container(),
              onSuccess: (context, User data) {
                return Container(
                  child: (data.image != null)?  Image.asset("images/${Style.urlImageFaceId}") : CircleAvatar(backgroundColor: Colors.white60,),
                );
              }
            )),
      )
    ],
  );
}