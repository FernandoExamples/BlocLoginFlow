part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

//El usuario hace login
class DoLoginEvent extends LoginEvent {
  final LoginRepository loginStrategy;

  DoLoginEvent(this.loginStrategy);

  @override
  List<Object> get props => [loginStrategy];
}

//El usuario hace logout
class DoLogoutEvent extends LoginEvent {}

//Se revisa al iniciar la aplicacion si el usuario esta logueado
class CheckLoginEvent extends LoginEvent {
  final LoginRepository loginStrategy;

  CheckLoginEvent(this.loginStrategy);

  @override
  List<Object> get props => [loginStrategy];
}
