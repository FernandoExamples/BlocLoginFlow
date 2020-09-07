import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_flow/blocs/bloc_observer.dart';
import 'package:login_flow/blocs/login/login_bloc.dart';
import 'package:login_flow/repositories/login_repository.dart';
import 'package:login_flow/repositories/shared_preferences.dart';
import 'package:login_flow/routes/routes.dart';

import 'pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new MySharedPreferences();
  await prefs.initPrefs();

  Bloc.observer = MyBlocObserver();
  final loginBloc = LoginBloc();

  loginBloc.firstWhere((state) => state is LoggedInState || state is LogoutState).then(
        (_) => runApp(MyApp(
          loginBloc: loginBloc,
        )),
      );

  //Revisamos si ya esta logueado el usuario
  final repo = repositories[AuthForm.values[prefs.authForm]];
  loginBloc.add(CheckLoginEvent(repo));
}

class MyApp extends StatelessWidget {
  final LoginBloc loginBloc;

  const MyApp({@required this.loginBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: loginBloc,
        ),
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'Login Flow',
          initialRoute: state is LoggedInState ? Routes.home : Routes.login,
          routes: Routes.routes,
          builder: (context, child) {
            return BlocListener<LoginBloc, LoginState>(
              listener: (BuildContext context, LoginState state) {
                if (state is LoggedInState) {
                  _navigator.pushNamedAndRemoveUntil(Routes.home, (route) => false);
                } else if (state is LogoutState) {
                  _navigator.pushNamedAndRemoveUntil<void>(Routes.login, (route) => false);
                }
              },
              listenWhen: (previous, current) {
                return current is LoggedInState || current is LogoutState;
              },
              child: child,
            );
          },
        );
      },
      buildWhen: (previous, current) {
        return current is LoggedInState || current is LogoutState;
      },
    );
  }
}
