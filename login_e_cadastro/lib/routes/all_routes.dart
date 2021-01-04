
import 'package:me_compre/routes/app_routes.dart';
import 'package:me_compre/routes/auth_routes.dart';
import 'package:me_compre/views/pages/cadastro/index.dart';
import 'package:me_compre/views/pages/home/index.dart';
import 'package:me_compre/views/pages/login/index.dart';

abstract class AllRoutes {
  static final routes = {
    AuthRoutes.CADASTRO: (context) => CadastroPage(),
    AuthRoutes.LOGIN: (context) => LoginPage(),
    AppRoutes.HOME: (context) => HomePage()
  };
}
