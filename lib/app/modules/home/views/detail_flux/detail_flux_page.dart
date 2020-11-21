import 'package:flutter/material.dart';

class DetailFluxPage extends StatefulWidget {
  final String title;
  const DetailFluxPage({Key key, this.title = "Detail"}) : super(key: key);

  @override
  _DetailFluxPageState createState() => _DetailFluxPageState();
}

class _DetailFluxPageState extends State<DetailFluxPage> {
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
