import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'event/db_event.dart';

abstract class IDbContext {
  void setConnectionString(String? connectionString);
  String? get connectionString;
  Future<Database?> get database;
  Stream<DbEvent> get event;
  void sendEvent(DbEvent event);
  void dispose();
}

abstract class DbContext implements IDbContext {
  String? _connectionString;
  Database? _database;

  DbContext(this._connectionString);

  StreamController<DbEvent> _eventController = StreamController.broadcast();
  @override
  Stream<DbEvent> get event => _eventController.stream;

  Future<Database> createDatabase(String connectionString);

  @override
  void setConnectionString(String? connectionString) {
    _connectionString = connectionString;
  }

  @override
  String? get connectionString => _connectionString;

  @override
  Future<Database?> get database async {
    final connectionString = _connectionString;
    if (connectionString == null) {
      return null;
    }
    final database = _database;
    if (database != null && !database.path.contains(connectionString)) {
      await _database?.close();
      _database = null;
    }
    if (_database == null) {
      _database = await createDatabase(connectionString);
    }
    return _database;
  }

  @override
  void sendEvent(DbEvent event) {
    _eventController.sink.add(event);
  }

  @override
  void dispose() {
    _eventController.close();
  }
}