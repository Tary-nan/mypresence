import 'package:mypresence/Manager/DataManage.dart';
import 'package:mypresence/Manager/UserFormManager.dart';
import 'package:mypresence/helpers/ensure_visible.dart';
import 'package:mypresence/pages/HomePage.dart';
import 'package:mypresence/widgets/CurvePaintBottom.dart';
import 'package:mypresence/widgets/showDialogger.dart';
import 'package:flutter/material.dart';
import 'package:rxform/rxform.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "/login";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    UserFormManager managerForm = context.fetch<UserFormManager>();
    DataManager manager = context.fetch<DataManager>();

    void _submitForm() async {
      Map<String, dynamic> user = await managerForm.submit();
      manager.login(receiveDataOnFormLogin: user).then((response) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.routeName, (route) => false);
      });
    }

    Widget _buildNameTextFiled() {
      return EnsureVisibleWhenFocused(
        focusNode: _usernameFocus,
        child: RxTextField<String>(
          subscribe: managerForm.username$,
          dispatch: managerForm.setUsername,
          enableInteractiveSelection: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              labelText: "Username",
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
      );
    }

    Widget _buildFamilyNameTextFiled() {
      return EnsureVisibleWhenFocused(
        focusNode: _passwordFocus,
        child: RxTextField<String>(
          subscribe: managerForm.password$,
          dispatch: managerForm.setPassword,
          enableInteractiveSelection: true,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
      );
    }

    Widget _headerBuildWidget() {
      return Flexible(
          child: Container(
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Se Connecter",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.normal),
                      ),
                    ))
              ],
            ),
          ));
    }

    Widget _formBuildWidget() {
      return Flexible(
        flex: 3,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                ListTile(title: _buildNameTextFiled()),
                ListTile(title: _buildFamilyNameTextFiled()),
              ],
            ),
          ),
        ),
      );
    }

    Widget _curvePaint() {
      return Flexible(
        child: Container(
          child: CustomPaint(
            child: Container(),
            painter: CurvePainterBottom(color: Color(0xff24b0ff)),
          ),
        ),
      );
    }

    Widget _imageHeader(){
      return Flexible(flex:2,child: Container(
      ));
    }

    Widget _footerReactiveBuild() {
      return Flexible(
          child: Container(
        alignment: Alignment.center,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
            Widget>[
          Observer<String>(
            stream: manager.message,
            onWaiting: (context) => Text("login",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            onSuccess: (context, data) => CircularProgressIndicator(),
            onError: (context, error) => Container(
                width: MediaQuery.of(context).size.width / 1.7,
                alignment: Alignment.center,
                child: Text(
                  error,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Observer<bool>(
              stream: managerForm.isFormValide$,
              onError: (context, error) => InkWell(
                    onTap: () => dialogShow(context),
                    child: Container(
                      width: 70,
                      height: 70,
                      alignment: Alignment.center,
                      child: Icon(Icons.arrow_forward_ios),
                      decoration: BoxDecoration(
                          color: Color(0xff24b0ff).withOpacity(.5),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
              onWaiting: (context) {
                return InkWell(
                  onTap: () => dialogShow(context),
                  child: Container(
                    width: 70,
                    height: 70,
                    alignment: Alignment.center,
                    child: Icon(Icons.arrow_forward_ios),
                    decoration: BoxDecoration(
                        color: Color(0xff24b0ff).withOpacity(.5),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                );
              },
              onSuccess: (context, data) => InkWell(
                    onTap: () => _submitForm(),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 2),
                      width: 70,
                      height: 70,
                      alignment: Alignment.center,
                      child: Icon(Icons.arrow_forward_ios),
                      decoration: BoxDecoration(
                          color: Color(0xff24b0ff),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ))
        ]),
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (BuildContext context) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _imageHeader(),
                _headerBuildWidget(),
                _formBuildWidget(),
                _footerReactiveBuild(),
                _curvePaint(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
