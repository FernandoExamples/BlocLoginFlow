import 'package:login_flow/pages/home_page.dart';
import 'package:login_flow/pages/login_page.dart';

class Routes {
  static final home = 'home';
  static final login = 'login';

  static get routes {
    return {
      home: (context) => HomePage(),
      login: (context) => LoginPage(),
    };
  }
}
