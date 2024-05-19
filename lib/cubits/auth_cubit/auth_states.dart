import 'package:promina_task/models/login_model/login_model.dart';

abstract class AuthStates {}

class LoginStateInitialState extends AuthStates {}

class LoginStateLoadingState extends AuthStates {}

class LoginStateSuccessState extends AuthStates {
  final LoginModel loginmodel;

  LoginStateSuccessState(this.loginmodel);
}

class LoginStateErrorState extends AuthStates {
  final String error;
  LoginStateErrorState(this.error);
}
