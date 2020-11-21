import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchFunction extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text('Under Construction ... ... ... =)'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('players').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            Text("Loading");
          }
          final results = snapshot.data.docs.where((DocumentSnapshot a) =>
              a.data()["Name"].toString().contains(query));
          return ListView(
            children: results
                .map<Widget>((a) => Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ListTile(
                        title: Text(a.data()["Name"].toString(),
                            style: TextStyle(fontSize: 24)),
                        onTap: () {
                          showResults(context);
                        },
                      ),
                    ))
                .toList(),
          );
        });
  }
}
