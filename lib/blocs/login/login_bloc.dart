import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_flow/repositories/shared_preferences.dart';

import '../../repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  @override
  String toString() => 'LoginBloc';

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is DoLoginEvent) {
      yield* _mapDoLoginToState(event);
    } else if (event is DoLogoutEvent) {
      yield* _mapDoLogoutToState();
    } else if (event is CheckLoginEvent) {
      yield* _mapCheckLoginEventToState(event);
    }
  }

  Stream<LoginState> _mapDoLoginToState(DoLoginEvent event) async* {
    yield LoadLoginState();

    //Hacer el login
    try {
      final strategy = event.loginStrategy;
      await strategy.login();
      yield LoggedInState(strategy);
    } on LoginException catch (e) {
      yield LoginErrorState('${e.message}');
    }
  }

  Stream<LoginState> _mapDoLogoutToState() async* {
    //Obtenemos el estado actual para sacar la estrategia usada
    final strategy = (state as LoggedInState).loginStrategy;
    strategy.logout();
    yield LogoutState();
  }

  Stream<LoginState> _mapCheckLoginEventToState(CheckLoginEvent event) async* {
    bool isLogged = event.loginStrategy.isLoggedIn();
    if (isLogged) {
      print('logueado');
      yield LoggedInState(event.loginStrategy);
    } else {
      print('No Logueado');
      yield LogoutState();
    }
  }
}
