import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetail extends StatefulWidget {
  final DocumentSnapshot post;

  UserDetail({this.post});

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("User Details")),
        body: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(child: Icon(Icons.person, size: 100)),
                  Container(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name : " + widget.post.data()["Name"]),
                          Text("Email: " + widget.post.data()["Email"]),
                          Text("Created On: " +
                              widget.post
                                  .data()["timestamp"]
                                  .toDate()
                                  .toString())
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
