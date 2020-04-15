import 'dart:async';
import 'package:mypresence/Models/Validation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sprinkle/Manager.dart';

class UserFormManager with Validation implements Manager {


  /// ************************
  /// *****  USERNAME
  ///
  BehaviorSubject<String> _username = BehaviorSubject<String>();
  void setUsername(String value) => _username.sink.add(value);
  Stream<String> get username$ => _username.stream.transform(validateUsername);

  /// ************************
  /// ***** PASSWORD
  ///
  BehaviorSubject<String> _password = BehaviorSubject<String>();
  void setPassword(String value) => _password.sink.add(value);
  Stream<String> get password$ => _password.stream.transform(validateUsername);


  /// ************************
  /// *****  Make Submit

  Stream<bool> get isFormValide$ => Rx.combineLatest([username$, password$], (value)=> true);



  Future<Map<String, dynamic>> submit() async {
    return {
      "username": _username.value,
      "password": _password.value,
    };
  }

  @override
  void dispose() {
    _username.close();
    _password.close();

  }
}
