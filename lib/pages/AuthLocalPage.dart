import 'package:flutter/material.dart';
import 'package:mypresence/Manager/DataManage.dart';
import 'package:mypresence/Models/dataRessource.dart';
import 'package:mypresence/widgets/ButtonScanOrAuth.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';



class AuthentificateLocal extends StatelessWidget {

  static const routeName = "/auth";
  final CardModel data;
  AuthentificateLocal({this.data});

  @override
  Widget build(BuildContext context) {

    DataManager manager = context.fetch<DataManager>();
    manager.checkBiometrics();
    manager.getAvailableBiometrics();
    
    return Scaffold(
      backgroundColor: Color(0xff2d9de5),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Hero(
                tag: data.tagHero,
                flightShuttleBuilder: _buildFlightWidget,
                child: Container(
                  height: MediaQuery.of(context).size.height * .45,
                  width: double.infinity,
                  child: Scenery(
                    data: data,
                    animationValue: 1,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Observer<String>(
                      stream: manager.message,
                      onSuccess: (context, String data) => _resultScan(context, manager: manager, status: "Success", message: data, icon: Icons.access_alarm, color: Colors.green.shade600),
                      onWaiting: (context) => Container(child: Column(
                        children: <Widget>[
                          SizedBox(height:33),
                          Container( child: Container(padding: EdgeInsets.only(left: 10, right:10) ,alignment: Alignment.center, child: Text(
                             data.desc,softWrap: true,style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)))),
                          SizedBox(height:53),
                          Observer<bool>(
                              stream: manager.authenticated,
                              onWaiting: (context)=> InkWell(
                                onTap: ()=> manager.fingerauthenticate(),
                                child: ButtonScanOrAuth(titre: data.titre, color: Color(0xff2d9de5), border: Colors.white60,),
                              ),
                              onError: (context, error)=> InkWell(
                                onTap: ()=> manager.fingerauthenticate(),
                                child: ButtonScanOrAuth(titre: "RESSSAYER", color: Colors.pink.shade50, border: Colors.red,),
                              ),
                              onSuccess: (context, bool isAuth) {
                                return InkWell(
                                  onTap: ()=> manager.scanQR(),
                                  child: ButtonScanOrAuth(titre: "SCANER", color: Colors.green.shade500, border: Colors.white60,),
                                );
                              }
                            ),
                        ],
                      )), 
                      onError: (context, String error) => _resultScan(context, manager: manager, status: "Error", message: error, icon: Icons.access_alarm, color: Colors.red.shade600),
                    ),

                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop()),
          )
        ],
      ),
    );
  }

  Widget _resultScan(BuildContext context, { DataManager manager, String status, String message, IconData icon, Color color}){

    return Container(

        child: Column(
          children: <Widget>[

                Container(
                  margin: EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height/3.5,
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white70.withOpacity(.1),
                    ),
                  
                  child: Column(
                    children: <Widget>[
                        Expanded(child: Container(alignment: Alignment.center, child: Text( status ,style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)))),
                        Expanded(child: Container(alignment: Alignment.center, child: Icon(icon, size: 52, color: color,))),
                        Expanded(flex:2,child: Container(padding: EdgeInsets.only(left: 10, right:10) ,alignment: Alignment.center, child: Text( message ,softWrap: true,style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)))),

                    ]
                  ),
                ),
                SizedBox(height:33),
                Observer<bool>(
                  stream: manager.authenticated,
                  onWaiting: (context)=> InkWell(
                    onTap: ()=> manager.fingerauthenticate(),
                    child: ButtonScanOrAuth(titre: data.titre, color: Color(0xff2d9de5), border: Colors.white60,),
                  ),
                  onError: (context, error)=> InkWell(
                    onTap: ()=> manager.fingerauthenticate(),
                    child: ButtonScanOrAuth(titre: "RESSSAYER", color: Colors.pink.shade400, border: Colors.white,),
                  ),
                  onSuccess: (context, bool isAuth) {
                    return InkWell(
                      onTap: ()=> manager.scanQR(),
                      child: ButtonScanOrAuth(titre: "SCANER", color: Colors.green.shade400, border: Colors.white60,),
                    );
                  }
                ),
          ],
          ));
  }

  Widget _buildFlightWidget(
      BuildContext flightContext,
      Animation<double> heroAnimation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext) {
    return AnimatedBuilder(
      animation: heroAnimation,
      builder: (context, child) {
        return DefaultTextStyle(
          style: DefaultTextStyle.of(toHeroContext).style,
          child: Scenery(
            data: data,
            animationValue: heroAnimation.value,
          ),
        );
      },
    );
  }
}

class Scenery extends StatelessWidget {
  final double animationValue;
  final CardModel data;

  const Scenery({Key key, this.animationValue = 0, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var animation = AlwaysStoppedAnimation(animationValue);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _buildBackgroundTransition(animation),
        _buildCardInfo(animation, screenSize),
        _buildCityAndTreesTransition(animation, screenSize),
      ],
    );
  }

  Widget _buildCardInfo(Animation animation, Size screenSize) {
    return FadeTransition(
      opacity: Tween<double>(begin: 1.0, end: 0)
          .animate(CurvedAnimation(curve: Interval(0, .22), parent: animation)),
      child: Container(
        padding: EdgeInsets.only(right: 35.0, left: 35.0, bottom: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // Sized box gives the space of the city image in the stack
            SizedBox(height: screenSize.height * .02),
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Column(
                children: <Widget>[
                  Text(
                    data.titre,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundTransition(Animation animation) {
    var gradientStart = ColorTween(
        begin: Color(0xff2d9de5), end: Color(0xffffffff).withOpacity(.5))
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: animation));
    var gradientEnd = ColorTween(
        begin: Color(0xffffffff).withOpacity(.5), end: Color(0xff2d9de5))
        .evaluate(animation);
    var borderRadiusAnimation =
    Tween<double>(begin: 10, end: 0).transform(animationValue);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusAnimation),
          //boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gradientStart.value, gradientEnd],
          )),
    );
  }

  Widget _buildCityAndTreesTransition(Animation animation, Size screenSize) {
    // City Image Animation
    var sizeStart = Size(screenSize.width * .55, screenSize.height * .24);
    var sizeEnd = Size(screenSize.width, screenSize.height * .35);
    var sizeTransition = Tween(begin: sizeStart, end: sizeEnd).animate(
        CurvedAnimation(
            curve: Interval(.25, 1, curve: Curves.easeIn), parent: animation));

    var cityPositionTransition =
    Tween(begin: Offset(0, -screenSize.height * .112), end: Offset.zero)
        .animate(CurvedAnimation(
        curve: Interval(0.5, 1, curve: Curves.easeIn),
        parent: animation));
    //Trees Animations
    //var treesOpacityTransition = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(curve: Interval(.75, 1, curve: Curves.easeIn), parent: animation));

    return Transform.translate(
      offset: cityPositionTransition.value,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _Image(
            size: sizeTransition.value,
            image: data.image,
          ),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final Size size;
  final String image;

  const _Image({Key key, this.size, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                width: size.width,
                height: size.height ,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Image.asset(image),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
