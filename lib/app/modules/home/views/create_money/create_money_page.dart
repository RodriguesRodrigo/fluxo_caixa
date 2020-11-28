import 'package:flutter/material.dart';

class CreateMoneyPage extends StatefulWidget {
  final String title;
  const CreateMoneyPage({Key key, this.title = "CreateMoney"})
      : super(key: key);

  @override
  _CreateMoneyPageState createState() => _CreateMoneyPageState();
}

class _CreateMoneyPageState extends State<CreateMoneyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
