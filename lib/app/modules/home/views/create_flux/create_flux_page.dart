import 'package:flutter/material.dart';

class CreateFluxPage extends StatefulWidget {
  final String title;
  const CreateFluxPage({Key key, this.title = "CreateFlux"}) : super(key: key);

  @override
  _CreateFluxPageState createState() => _CreateFluxPageState();
}

class _CreateFluxPageState extends State<CreateFluxPage> {
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
