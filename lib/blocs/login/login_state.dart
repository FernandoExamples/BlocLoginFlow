part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class LoginInitialState extends LoginState {}

//Cuando se esta haciendo la autenticacion con el backend
class LoadLoginState extends LoginState {}

//Cuando ya se autentico
class LoggedInState extends LoginState {
  final LoginRepository loginStrategy;

  LoggedInState(this.loginStrategy);

  @override
  List<Object> get props => [loginStrategy];
}

//Logout al backend
class LogoutState extends LoginState {}

//Error de autenticacion
class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);

  @override
  List<Object> get props => [message];
}
