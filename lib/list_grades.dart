import 'package:flutter/material.dart';
import 'package:flutter_application_3/add.dart';
import 'package:flutter_application_3/gradle.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class ListGrades extends StatefulWidget {
  const ListGrades({super.key});

  @override
  _ListGradesState createState() => _ListGradesState();
}

class _ListGradesState extends State<ListGrades> {
  List<Gradle> gradleList = <Gradle>[];

  @override
  void initState() {
    super.initState();
    getDatabase();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notas"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Future<dynamic> future = Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddGradle(),
                  ));
              future.then((gradle) {
                setState(() {
                  gradleList.add(gradle);
                });
                //insertGradle(gradle);
              });
            },
          )
        ],
      ),
      body: ListView.separated(
        itemCount: gradleList.length,
        itemBuilder: (context, index) => buildListItem(index),
        separatorBuilder: (context, index) => const Divider(
          height: 1,
        ),
      ),
    );
  }

  Widget buildListItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          leading: Text("${gradleList[index].id}"),
          trailing: Text("${gradleList[index].value}"),
          title: Text(gradleList[index].subject),
          subtitle: Text(gradleList[index].phase.toString()),
          onLongPress: () {
            gradleList.removeAt(index);
          },
        ),
      ),
    );
  }
}

void getDatabase() {}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'gradle.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE gradle(
        id INTEGER PRIMARY KEY,
        subject TEXT,
        phase INT,
        value INT
      )
      ''');
  }

  insertGradle(Gradle gradle) async {
    final Database db = await database;
    await db.insert(
      'gradle',
      gradle.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  readAll() async {
    final db = await database;
    var res = await db.query("Gradle");
    List list =
        res.isNotEmpty ? res.map((c) => Gradle.fromMap(c)).toList() : [];
    return list;
  }

  deleteGradle(int index) async {
    final Database db = await database;
    await db.delete(
      'gradle',
      where: 'id = ?',
      whereArgs: [index],
    );
  }

  getDatabase() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('gradle');
    return List.generate(maps.length, (index) {
      return Gradle(
        id: maps[index]['id'],
        subject: maps[index]['subject'],
        phase: maps[index]['phase'],
        value: maps[index]['value'],
      );
    });
  }

  updateGrades(Gradle gradle) async {
    final Database db = await database;
    var res = await db.update('gradle', gradle.toMap(),
        where: 'id = ?', whereArgs: [gradle.id]);
    return res;
  }
}
