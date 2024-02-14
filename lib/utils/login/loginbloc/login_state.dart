abstract class LoginState {}

class IntialState extends LoginState {}

class UserLoginState extends LoginState {}

class UsernotLoginState extends LoginState {}

class LoadingState extends LoginState {}

class SigninState extends LoginState {}

class ErrorState extends LoginState {
  final String errormessage;
  ErrorState({required this.errormessage});
}
