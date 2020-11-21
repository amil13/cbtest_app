import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PopulateDB extends StatefulWidget {
  @override
  _PopulateDBState createState() => _PopulateDBState();
}

class _PopulateDBState extends State<PopulateDB> {
  String name, email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CollectionReference players =
      FirebaseFirestore.instance.collection('players');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Insert New Entries")),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: formUI(),
        ));
  }

  /// Form user interface in another widget
  Widget formUI() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          TextFormField(
              onSaved: (val) => name = val,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Incorrect Input';
                }
                return null;
              },
              decoration:
                  InputDecoration(icon: Icon(Icons.person), hintText: "Name")),
          TextFormField(
              onSaved: (val) => email = val,
              validator: (val) {
                if (!EmailValidator.validate(val)) {
                  return 'Incorrect Input';
                }
                return null;
              },
              decoration:
                  InputDecoration(icon: Icon(Icons.mail), hintText: "Email")),
          ElevatedButton(onPressed: _upload, child: Text("Inserts"))
        ],
      ),
    );
  }

  /// Form data upload to DB
  _upload() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      players
          .add({
            "Name": name,
            "Email": email,
            "timestamp": FieldValue.serverTimestamp()
          })
          .then((value) => print("User Added")) /// to print in the console
          .catchError((error) => print(error));
      Navigator.pop(context);
    }
  }
}
