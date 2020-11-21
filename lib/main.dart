import 'package:cbtest_app/HomeScreenListing.dart';
import 'package:cbtest_app/PopulateDB.dart';
import 'package:cbtest_app/SearchFunction.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "CeleBreak Test App",
        theme: ThemeData(
            primaryColor: Colors.black,
            accentColor: Colors.grey,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey, onPrimary: Colors.black))),
        home: HomePage());
  }
}


// Main Screen with scrollable list of users.
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Celebreak Test App"),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () =>
                    showSearch(context: context, delegate: SearchFunction()))
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add Entry"),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PopulateDB()), //Insert()
            ),
        ),
        body: HomeScreen()); //ListPage()
  }
}
