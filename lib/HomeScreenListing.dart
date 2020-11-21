import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'UserDetails.dart';

class HomeScreen extends StatefulWidget {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: list(),
    );
  }

  //List widget that creates the list with a StreamBuilder
  Widget list() {
    return StreamBuilder<QuerySnapshot>(
        stream: widget._fireStore.collection('players').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading.....');
          } else {
            return Container(
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Center(
                            child: ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserDetail(post: snapshot.data.docs[index]))), ///Redirects to UserDetail.dart
                      leading: Icon(Icons.person, size: 45),
                      title: Text(snapshot.data.docs[index]["Name"]),
                      subtitle: Text(snapshot.data.docs[index]["Email"]),
                    )));
                  }),
            );
          }
        });
  }
}
