import 'package:fastporte_app/comments/model/comment.dart';
import 'package:flutter/material.dart';

class CommentFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Comment comment;

  CommentFormProvider(this.comment);

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
