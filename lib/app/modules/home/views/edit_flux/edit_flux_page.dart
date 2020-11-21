import 'package:flutter/material.dart';

class EditFluxPage extends StatefulWidget {
  final String title;
  const EditFluxPage({Key key, this.title = "Edit"}) : super(key: key);

  @override
  _EditFluxPageState createState() => _EditFluxPageState();
}

class _EditFluxPageState extends State<EditFluxPage> {
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
