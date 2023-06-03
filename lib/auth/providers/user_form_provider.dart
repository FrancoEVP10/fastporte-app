import 'package:fastporte_app/auth/model/user.dart';
import 'package:flutter/material.dart';

class UserFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  User user;

  UserFormProvider(this.user);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    //print(formKey.currentState?.validate());

    //print('$email - $password');

    return formKey.currentState?.validate() ?? false;
  }
}
