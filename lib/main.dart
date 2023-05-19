import 'package:flutter/material.dart';
import 'package:flutter_application_3/list_grades.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Home(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/sqlite': (context) => const ListGrades(),
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Flutter - Persistência"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: const Text("SQLite"),
              subtitle: const Text("Lista de Notas"),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Navigator.pushNamed(context, "/sqlite");
              },
            ),
          ],
        ),
      );
}
