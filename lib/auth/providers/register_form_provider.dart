import 'package:flutter/material.dart';


class RegisterFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email    = '';
  String password = '';
  DateTime birthdate = DateTime.now();
  String lastname = '';
  String name = '';
  String phone = '';
  String region = '';
  String username = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  
  bool isValidForm() {

    //print(formKey.currentState?.validate());

    //print('$email - $password');

    return formKey.currentState?.validate() ?? false;
  }

}