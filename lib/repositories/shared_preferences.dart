import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static final MySharedPreferences _instancia = new MySharedPreferences._();

  factory MySharedPreferences() {
    return _instancia;
  }

  MySharedPreferences._();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  void clear() {
    _prefs.clear();
  }

  // GET y SET del login
  bool get isLogged {
    return _prefs.getBool('isLogged') ?? false;
  }

  set isLogged(bool value) {
    _prefs.setBool('isLogged', value);
  }

  //SET y GET de la forma de loguearse
  int get authForm {
    return _prefs.getInt('authForm') ?? 0;
  }

  set authForm(int value) {
    _prefs.setInt('authForm', value);
  }
}
