import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluxo_caixa/app/modules/login/login_controller.dart';

class LoginPageBody {

  String email;
  String password;

  titleForm() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.black,
            fontSize: 42.0,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  textFormFieldEmail() {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,

        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),

        decoration: InputDecoration(
          hintText: "Usuário",

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

        validator: (value) => value.isEmpty ?
          'Por favor, informe seu usuário.' :
          null,

        onChanged: (text) {
          email = text;
        },
      ),
    );
  }

  textFormFieldPassword() {
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

        validator: (value) => value.isEmpty ?
          'Por favor, informe sua senha' :
          null,

        onChanged: (text) {
          password = text;
        },
      ),
    );
  }

  containerButton(BuildContext context, LoginController controller) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        height: 48.0,
        child: RaisedButton(
          child: Text(
            "ENTRAR",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            )
          ),

          color: Colors.blue[600],

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
          ),

          onPressed: () async {
            loginWithFirebase(email, password, controller, context);
          },
        ),
      ),
    );
  }

  redirectCreateUser() {
    return Container(
      child: InkWell(
        child: Text(
          'Não tenho uma conta. Cadastrar',
          style: TextStyle(
            color: Colors.blue[600],
            fontSize: 16.0,
          )
        ),
        onTap: () => Modular.to.pushReplacementNamed('/createUser'),
      ),
    );
  }

  Future loginWithFirebase(email, password, controller, BuildContext context) async {
    try {
      await controller.auth.loginEmailPassword(email, password);
      Modular.to.pushReplacementNamed('/home');
    }
    on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
        _showDialog(
          context,
          'Usuário não encontrado',
          'Não encontramos este usuário, por favor verifique se o usuário está correto e tente novamente.',
        );
      }
      else if (e.code == 'wrong-password') {
        _showDialog(
          context,
          'Senha incorreta',
          'Sua senha está incorreta, por favor verifique se a senha está correta e tente novamente.',
        );
      }
      else {
        _showDialog(
          context,
          'Ops',
          'Estamos com alguns problemas tecnicos, tente novamente mais tarde.',
        );
      }
      print("[LOGIN][FIREBASE AUTH EXCEPTION]" + e.code);
    }
    catch(e) {
      _showDialog(
        context,
        'Ops',
        'Estamos com alguns problemas tecnicos, tente novamente mais tarde.',
      );
      print("[LOGIN][EXCEPTION]" + e.code);
    }
  }

  _showDialog(BuildContext context, String title, String message) {
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

}
