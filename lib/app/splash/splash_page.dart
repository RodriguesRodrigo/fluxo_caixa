import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/shared/auth/auth_controller.dart';
import 'package:mobx/mobx.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();
    disposer = autorun((_) => _autoRedirect());
  }

  @override
  void dispose() {
    super.dispose();
    disposer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 60.0)),
            Icon(
              Icons.attach_money,
              color: Colors.white,
              size: 120.0,
              semanticLabel: 'Icone com o formato de cifrão'
            ),
            Padding(padding: EdgeInsets.only(bottom: 60.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            )
          ],
        ),
      )
    );
  }

  _autoRedirect() {
    final auth = Modular.get<AuthController>();
    if (auth.status == AuthStatus.login) {
      new Future.delayed(const Duration(seconds: 2), () {
        Modular.to.pushReplacementNamed('/home');
      });
    }
    else if (auth.status == AuthStatus.logoff) {
      new Future.delayed(const Duration(seconds: 2), () {
        Modular.to.pushReplacementNamed('/login');
      });
    }
  }
}
