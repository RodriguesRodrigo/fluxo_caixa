import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final dummySnapshot = [
  {"name": "Abacate", "votes": 15},
  {"name": "Banana", "votes": 14},
  {"name": "Bergamota", "votes": 11},
  {"name": "Maçã", "votes": 10},
  {"name": "Abacaxi", "votes": 1},
];


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return _buildList(context, dummySnapshot);
}

Widget _buildList(BuildContext context, List<Map> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, Map data) {
  final record = Record.fromMap(data);

  return Padding(
    key: ValueKey(record.name),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical:8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey,
      ),
      child: ListTile(
        title: Text(
          record.name,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Text(record.votes.toString()),
        onTap: () => print(record),
      ),
    ),
  );
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['name'] != null),
      assert(map['votes'] != null),
      name = map['name'],
      votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString () => 'Record<$name:$votes>';
}
