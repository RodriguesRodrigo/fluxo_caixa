import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/modules/create_user/models/user_model.dart';
import 'create_user_controller.dart';

class CreateUserPage extends StatefulWidget {
  final String title;
  const CreateUserPage({Key key, this.title = "CreateUser"}) : super(key: key);

  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState
    extends ModularState<CreateUserPage, CreateUserController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _formWidget(context),
    );
  }

  _formWidget(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    UserModel _model = UserModel();

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            titleForm(),
            Padding(padding: const EdgeInsets.only(top: 16.0)),
            textFormFieldEmail(_model),
            Padding(padding: const EdgeInsets.only(top: 16.0)),
            textFormFieldPassword(_model),
            Padding(padding: const EdgeInsets.only(top: 16.0)),
            saveUserButton(context, _model),
            Padding(padding: const EdgeInsets.only(top: 16.0)),
            redirectToLogin(),
            Padding(padding: const EdgeInsets.only(top: 16.0)),
          ],
        ),
      ),
    );
  }

  titleForm() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        child: Text(
          'REGISTRAR',
          style: TextStyle(
            color: Colors.black,
            fontSize: 42.0,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  textFormFieldEmail(UserModel model) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,

        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),

        decoration: InputDecoration(
          hintText: "E-mail",

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: Colors.grey[300],
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: Colors.grey[300],
            ),
          ),

          fillColor: Colors.grey[300],
          filled: true,

          contentPadding: const EdgeInsets.only(
            left: 20.0,
            top: 14.0,
            right: 20.0,
            bottom: 14.0,
          ),
        ),

        validator: (String value) {
          if (value.isEmpty) {
            return 'Por favor, informe seu usuário';
          }
          return null;
        },

        onChanged: (value) => model.email = value,
      ),
    );
  }

  textFormFieldPassword(UserModel model) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,

        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),

        decoration: InputDecoration(
          hintText: "Senha",

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: Colors.grey[300],
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: Colors.grey[300],
            ),
          ),

          fillColor: Colors.grey[300],
          filled: true,

          contentPadding: const EdgeInsets.only(
            left: 20.0,
            top: 14.0,
            right: 20.0,
            bottom: 14.0,
          ),
        ),

        validator: (String value) {
          if (value.isEmpty) {
            return 'Por favor, informe sua senha.';
          }
          return null;
        },

        onChanged: (password) => model.password = password,
      ),
    );
  }

  saveUserButton(BuildContext context, UserModel model) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        height: 48.0,
        child: RaisedButton(
          child: Text(
            "CADASTRAR",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            )
          ),

          color: Colors.blue[600],

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
          ),

          onPressed: () => _validateModel(model),
        ),
      ),
    );
  }

  redirectToLogin() {
    return Container(
      child: InkWell(
        child: Text(
          'Já tenho uma conta. Entrar',
          style: TextStyle(
            color: Colors.blue[600],
            fontSize: 16.0,
          )
        ),
        onTap: () => Modular.to.pushReplacementNamed('/login'),
      ),
    );
  }

  _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Modular.to.pop(),
              child: Text('Fechar'),
            ),
          ],
        );
      }
    );
  }

  _validateModel(UserModel model) {
    CircularProgressIndicator();
    if (model.email == '') {
      _showDialog(
        'Campo email obrigatório',
        'Por favor, preencha o campo de e-mail'
      );
    }
    else if (model.password == '') {
      _showDialog(
        'Campo senha obrigatório',
        'Por favor, preencha o campo senha'
      );
    }
    else {
      model.create().then((result) {
        if (result == 'email-already-in-use') {
          _showDialog(
            'Falha ao criar usuário',
            'Esta conta de e-mail já existe, por favor tente novamente.'
          );
        }
        else if (result == 'weak-password') {
          _showDialog(
            'Falha ao criar usuário',
            'Senha informada é muito fraca, por favor tente novamente.'
          );
        }
        else {
          Modular.to.pushReplacementNamed('/login');
        }
      });
    }
  }

}
