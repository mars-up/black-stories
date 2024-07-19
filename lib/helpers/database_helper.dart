import 'dart:async';
import 'dart:io';

import 'package:black_stories/models/collection.dart';
import 'package:black_stories/models/story.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note_model.dart';
import '../models/stored.dart';
import '../models/user.dart';
import 'datacontent_helper.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  late Database _database;

  static const _dbName = "bs.db";
  static const _dbVersion = 1;
  static const _tableUser = "user";
  static const _tableCollection = "collection";
  static const _tableStory = "story";
  static const _tableStored = "stored";

  Future<Database> get database async {
    _database = await initiateDatabase();
    return _database;
  }

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableUser(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        dateTimeEdited TEXT NOT NULL,
        dateTimeCreated TEXT NOT NULL,
        isFavorite INTEGER NOT NULL DEFAULT 0
      )
      ''');
    await db.execute('''
      CREATE TABLE $_tableUser(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username VARCHAR(128) NOT NULL,
        password VARCHAR(128) NOT NULL
      )
      ''');
    await db.execute('''
      CREATE TABLE $_tableCollection(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(16) NOT NULL,
        img VARCHAR(32) NOT NULL,
        active INTEGER NOT NULL DEFAULT 1
      )
      ''');
    await db.execute('''
      CREATE TABLE $_tableStory(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        collection INTEGER NOT NULL,
        title VARCHAR(64) NOT NULL,
        logo VARCHAR(255) NOT NULL,
        hint VARCHAR(128) NOT NULL,
        image VARCHAR(32) NOT NULL,
        solution TEXT,
        result VARCHAR(32) NOT NULL,
        active INTEGER NOT NULL DEFAULT 1
      )
      ''');
    await db.execute('''
      CREATE TABLE $_tableStored(
        id INTEGER PRIMARY KEY,
        user_id INTEGER NOT NULL,
        collection_id INTEGER NOT NULL,
        story_id INTEGER NOT NULL,
        dateTimeCompleted TEXT NOT NULL
      )
      ''');
    //_onCreateDataA(db);
    _onCreateCollectionsData(db, "all");
    _onCreateStoriesData(db, "first");
    //_onCreateDataC(db);
  }

  // -----------------------------------------------
  void _onCreateCollectionsData(Database db, ref) async {
    DatacontentHelper content;
    content = DatacontentHelper();
    List<Collection> main = content.getCollectionsContent(ref);
    //
    await db.transaction((txn)async {
      var batch = txn.batch();
      for (var m in main) {
        batch.insert(_tableCollection, m.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit();
    });
  }
  // -----------------------------------------------

  void _onCreateStoriesData(Database db, ref) async {
    DatacontentHelper content;
    content = DatacontentHelper();
    List<Story> first = content.getStoriesContent(ref);
    //
    await db.transaction((txn)async {
      var batch = txn.batch();
      for (var n in first) {
        batch.insert(_tableUser, n.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit();
    });
  }

  void _onCreateData(Database db) async {
    await db.execute('''
          INSERT INTO $_tableUser ('id', 'title', 'content', 'dateTimeEdited', 'dateTimeCreated', 'isFavorite') VALUES
              ('1', 'test', 'truc', '0000', '1212', '1'),
              ('2', 'testB', 'truc', '0000', '1212', '0');
      ''');
  }

  // ------------------------------ User--------------------------------------

  // Add User
  Future<int> addUser(User user) async {
    Database db = await instance.database;
    return await db.insert(_tableUser, user.toJson());
  }

  // Delete User
  Future<int> deleteUser(User user) async {
    Database db = await instance.database;
    return await db.delete(
      _tableUser,
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  // Update User
  Future<int> updateUser(User user) async {
    Database db = await instance.database;
    return await db.update(
      _tableUser,
      user.toJson(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  Future<List<User>> getUserList() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableUser, orderBy: 'dateTimeCreated DESC');
    return List.generate(
      maps.length,
      (index) {
        return User(
          id: maps[index]["id"],
          username: maps[index]["username"],
          password: maps[index]["password"],
          rights: maps[index]["rights"],
        );
      },
    );
  }

  Future<User?> getUser(int id) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(_tableStored,
        columns: ['id', 'username', 'password', 'rights'],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return null;
  }


  // ------------------------------ Collection--------------------------------------

  Future<List<Collection>> getCollections() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableCollection);
    return List.generate(
      maps.length,
          (index) {
        return Collection(
          id: maps[index]['id'],
          name: maps[index]['name'],
          img: maps[index]['img'],
          active: maps[index]['active'] == 1 ? true : false,
        );
      },
    );
  }

  // ------------------------------ Story--------------------------------------

  Future<List<Story>> getStories() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableStory);
    return List.generate(
      maps.length,
          (index) {
        return Story(
          id: maps[index]['id'],
          collection: maps[index]['collection'],
          title: maps[index]['title'],
          logo: maps[index]['logo'],
          hint: maps[index]['hint'],
          image: maps[index]['image'],
          solution: maps[index]['solution'],
          result: maps[index]['result'],
          active: maps[index]['active'] == 1 ? true : false,
        );
      },
    );
  }

  // ------------------------------ Stored--------------------------------------
  Future<int> addStored(Stored stored) async {
    Database db = await instance.database;
    return await db.insert(_tableStored, stored.toJson());
  }

  Future<int> updateStored(Stored stored) async {
    Database db = await instance.database;
    return await db.update(
      _tableStored,
      stored.toJson(),
      where: "id = ?",
      whereArgs: [stored.id],
    );
  }

  Future<int> deleteStored(Stored stored) async {
    Database db = await instance.database;
    return await db.delete(
      _tableStored,
      where: "id = ?",
      whereArgs: [stored.id],
    );
  }

  Future<Stored?> getStored(int id) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(_tableStored,
        columns: ['id', 'user_id', 'collection_id', 'story_id', 'dateTimeCompleted'],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Stored.fromMap(maps.first);
    }
    return null;
  }


  Future<int> deleteAllStored() async {
    Database db = await instance.database;
    return await db.delete(_tableStored);
  }

  Future<List<Stored>> getStoredList() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableStored, orderBy: 'dateTimeCompleted DESC');
    return List.generate(
      maps.length,
          (index) {
        return Stored(
          id: maps[index]["id"],
          user_id: maps[index]['user_id'],
          collection_id: maps[index]['collection_id'],
          story_id: maps[index]['story_id'],
          dateTimeCompleted: maps[index]['dateTimeCompleted'],
        );
      },
    );
  }

}
