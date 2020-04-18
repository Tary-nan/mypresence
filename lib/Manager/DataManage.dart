import 'dart:io';

import 'package:mypresence/Exceptions/InvalidQrCodeException.dart';
import 'package:mypresence/Exceptions/NoNetworkException.dart';
import 'package:mypresence/Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprinkle/Manager.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:local_auth/local_auth.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataManager implements Manager {

  static const baseUrl = 'https://presence.nan.ci/mpr';
  static const timeout = Duration(seconds: 20);
  static const KEY_USER = 'KEY_USER';



  BehaviorSubject<User> _userr = BehaviorSubject<User>();
  PublishSubject<String> _message = PublishSubject<String>();

  PublishSubject<bool> _authenticated = PublishSubject<bool>();
  BehaviorSubject<bool> _canCheckBiometrics = BehaviorSubject<bool>();
  BehaviorSubject<List<BiometricType>> _availableBiometrics = BehaviorSubject<List<BiometricType>>();

  User _user;
  User get user => _user;
  final LocalAuthentication auth = LocalAuthentication();



  Stream<User> get userr => _userr.stream;
  Stream<String> get message => _message.stream;

  Stream<bool> get authenticated => _authenticated.stream;
  Stream<bool> get checkedBiometric => _canCheckBiometrics.stream;
  Stream<List<BiometricType>> get availableBiometric => _availableBiometrics.stream;


  Future<void> checkBiometrics() async {
      bool canCheckBiometrics;
      try {
        canCheckBiometrics = await auth.canCheckBiometrics;
      } on PlatformException catch (e) {
        print(e);
        throw e;
      }
      (canCheckBiometrics)? _canCheckBiometrics.add(true) : _canCheckBiometrics.addError(false)  ;
    }

  Future<void> getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    (availableBiometrics.isEmpty) ? print("List valid biometrics vide") :_availableBiometrics.add(availableBiometrics);
    
    if(Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.face)) {
        print("Face iD ");
          // Face ID.
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        print("Touch ID ");
          // Touch ID.
      }
    }else if(Platform.isAndroid){
      if (availableBiometrics.contains(BiometricType.face)) {
          print("Face iD ");
            // Face ID.
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          print("Touch ID ");
            // Touch ID.
        }
    }
  }

  Future<void> fingerauthenticate() async {
    checkBiometrics();
    getAvailableBiometrics();
    bool authenticate = false;
    try {

      authenticate = await auth.authenticateWithBiometrics(
          localizedReason:
          'scanner votre emprunte digital pour vous authentifier',
          useErrorDialogs: true,
          stickyAuth: true);

    } on PlatformException catch (e) {
      _authenticated.addError(false);
      _message.addError("$e");
    }

    if(authenticate){
        _authenticated.add(true);
        _message.add("super nous avons recuperer votre emprunte vous pouvez scaner");

    }else{
        _authenticated.addError(false);
        _message.addError("tu utilise quel doigt même, ressayer svp ...");
    }
  }

  Future<void> launch({String url,Map<String, dynamic> data,int success: 200,Function callback}) async {
    try {
      http.Response response = await http.post('$baseUrl/$url', body: data).timeout(timeout, onTimeout: () {
        _message.addError("verifier votre connection internet");
        throw NoNetworkException();
      });
      Map<String, dynamic> res;

      if (response.body.isNotEmpty)
        res = json.decode(response.body);
      else
        res = {};
      if (response.statusCode == success) {
        if (res["status"] == true) {

          _message.add("user logger");
          await callback(data: res["user"]);
        } else if (res['status'] == false) {
          _message.addError(res['message']);
          throw InvalidQrCodeException();
        }
      }
    } catch (e) {
      _message.addError("$e");
      throw e;
    }
  }


  Future<int> login({Map<String, dynamic> receiveDataOnFormLogin}) async {
    _message.add("loadding ...");
    await launch(url: 'mobilelogin/', data: receiveDataOnFormLogin,callback: ({Map<String, dynamic> data}) async {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      _user = User.fromJson(data);
      _userr.add(_user);
      prefs.setString(KEY_USER, json.encode(_user.toJson()));

      print("///////////  USER LOGGER  ////////////");
      await Future.delayed(Duration(milliseconds: 3000));

    });

    return 1;
  }



  Future<void> scanQR() async {

    try {

      String barcodeScanRes;
      String barcode = await BarcodeScanner.scan();
      barcodeScanRes = barcode = barcode;

      fetchScan(scan:barcodeScanRes);

    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        _message.addError('La Permission à la camera n est pas donner');
      } else {
        String warn = 'soit tu scan où arrête.. ça !';
        _message.add(warn);
      }
    } on FormatException{
      _message.addError("Pourquoi tu sort sans scanner");
    } catch (e) {
      _message.addError('error inconnu: $e');
    }
  }


  void fetchScan({String scan}) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    String user = pref.getString(KEY_USER);

    (user == null)? print("vous n exister pas"): _user = User.fromJson(json.decode(user));


    _userr.add(_user);
    await launch(url: 'scanner/',data: {'username': '${_user.userUsername}','qrcode': '$scan'},callback: ({Map<String, dynamic> data}) async {
          _message.add(data["message"]);
          print("barcodeScan : ${data["message"]}");
        });
  }

  Future<bool> restoreSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String res = prefs.getString(KEY_USER);
    print(res);
    if (res != null) {
      _user = User.fromJson(json.decode(res));
      _userr.add(_user);
      return true;
    } else {
      return false;
    }
  }

  void closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool data = await prefs.remove(KEY_USER);
    print(data);
  }
  @override
  void dispose() {
    _authenticated.close();
    _userr.close();
    _canCheckBiometrics.close();
    _availableBiometrics.close();
  }
}
