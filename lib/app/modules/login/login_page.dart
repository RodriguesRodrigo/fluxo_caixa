import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/modules/login/components/login_page_body.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _formWidget(context),
    );
  }

  _formWidget(BuildContext context) {
    final LoginPageBody _body = LoginPageBody();

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _body.titleForm(),
            new Padding(padding: const EdgeInsets.only(top: 16.0)),
            _body.textFormFieldEmail(),
            new Padding(padding: const EdgeInsets.only(top: 16.0)),
            _body.textFormFieldPassword(),
            new Padding(padding: const EdgeInsets.only(top: 16.0)),
            _body.containerButton(context, controller),
          ],
        ),
      ),
    );
  }

}
