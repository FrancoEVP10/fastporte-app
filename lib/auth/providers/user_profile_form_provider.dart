import 'package:flutter/material.dart';


class UserProfileFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String userUID = '';
  String firstName = '';
  String lastName = '';
  String region = '';
  DateTime birthdate = DateTime.now();
  String phoneNumber = '';
  String dni = '';
  String userType = '';


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