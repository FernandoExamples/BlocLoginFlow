import 'package:login_flow/repositories/shared_preferences.dart';

enum AuthForm { FACEBOOk, GOOGLE, EMAIL }

Map<AuthForm, LoginRepository> repositories = {
  AuthForm.EMAIL: EmailLogin(null, null),
  AuthForm.FACEBOOk: FacebookLogin(),
  AuthForm.GOOGLE: GoogleLogin(),
};

abstract class LoginRepository {
  Future<void> login();
  Future<void> logout();
  MySharedPreferences prefs = MySharedPreferences();
  bool isLoggedIn() {
    return prefs.isLogged;
  }
}

class LoginException implements Exception {
  final String message;

  LoginException([this.message]);
}

class EmailLogin extends LoginRepository {
  final String email;
  final String password;

  EmailLogin(this.email, this.password);

  @override
  Future<void> login() async {
    await Future.delayed(Duration(seconds: 2));
    if (email != 'demo@demo.com' || password != '123456') {
      throw LoginException("Usuario o Contraseña incorrectos");
    }
    prefs.isLogged = true;
    prefs.authForm = AuthForm.EMAIL.index;
  }

  @override
  Future<void> logout() async {
    print("Cerrando sesion email y password...");
    prefs.isLogged = false;
  }
}

class FacebookLogin extends LoginRepository {
  @override
  Future<void> login() async {
    try {
      await Future.delayed(Duration(seconds: 3));
    } catch (e) {
      throw LoginException('Se ha rechazado el login');
    }
    prefs.isLogged = true;
    prefs.authForm = AuthForm.FACEBOOk.index;
  }

  @override
  Future<void> logout() async {
    print("Cerrando sesion facebook...");
    prefs.isLogged = false;
  }
}

class GoogleLogin extends LoginRepository {
  @override
  Future<void> login() async {
    try {
      await Future.delayed(Duration(seconds: 3));
    } catch (e) {
      throw LoginException('Se ha rechazado el login google');
    }
    prefs.isLogged = true;
    prefs.authForm = AuthForm.GOOGLE.index;
  }

  @override
  Future<void> logout() async {
    print("Cerrando sesion google...");
    prefs.isLogged = false;
  }
}
