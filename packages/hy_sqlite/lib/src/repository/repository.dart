import 'package:sqflite/sqflite.dart';

import '../db_context.dart';
import '../event/db_event.dart';
import '../types/db_operation_type.dart';
import 'i_repository.dart';

abstract class Repository<TModel> implements IRepository<TModel> {

  final IDbContext _dbContext;
  Repository(this._dbContext);

  @override
  IDbContext get dbContext => _dbContext;

  @override
  String get table => (TModel).toString().toLowerCase();

  @override
  Future<TModel?> getFirstOrDefault({bool? distinct, List<String>? columns, String? where,
    List<Object?>? whereArgs, String? groupBy, String? having, String? orderBy}) async {

    final db = await _dbContext.database;
    if (db == null) {
      return null;
    }

    final maps = await db.query(table,
        distinct: distinct, columns: columns, where: where, whereArgs: whereArgs, groupBy: groupBy, having: having, orderBy: orderBy, limit: 1);

    if (maps.length == 0) {
      return null;
    }

    return fromMap(maps[0]);
  }

  @override
  Future<List<TModel>?> query({bool? distinct, List<String>? columns, String? where, List<Object?>? whereArgs, String? groupBy, String? having, String? orderBy, int? limit, int? offset}) async {
    final db = await _dbContext.database;
    if (db == null) {
      return null;
    }

    final maps = await db.query(table,
        distinct: distinct, columns: columns, where: where, whereArgs: whereArgs, groupBy: groupBy, having: having, orderBy: orderBy, limit: limit, offset: offset);

    return List.generate(maps.length, (i) {
      return fromMap(maps[i]);
    }).toList();
  }

  @override
  Future<int?> insert(TModel model, {String? nullColumnHack, ConflictAlgorithm? conflictAlgorithm}) async {
    final db = await _dbContext.database;
    if (db == null) {
      return null;
    }

    var result = await db.insert(table, toMap(model), nullColumnHack: nullColumnHack, conflictAlgorithm: conflictAlgorithm);
    final id = getId(model);
    _dbContext.sendEvent(DbEvent(DbOperationType.insert, TModel, id == null ? null : [id]));
    return result;
  }
  @override
  Future<List<Object?>?> batchInsert(Iterable<TModel> models, {String? nullColumnHack, ConflictAlgorithm? conflictAlgorithm,
        bool? exclusive, bool? noResult, bool? continueOnError}) async {
    final db = await _dbContext.database;
    if (db == null) {
      return null;
    }

    final batch = db.batch();
    models.forEach((model) {
      batch.insert(table, toMap(model), nullColumnHack: nullColumnHack, conflictAlgorithm: conflictAlgorithm);
    });
    var result =  await batch.commit(exclusive: exclusive, noResult: noResult, continueOnError: continueOnError);
    final ids = models.map((e) => getId(e)).where((element) => element != null).toList();
    _dbContext.sendEvent(DbEvent(DbOperationType.insert, TModel, ids.length == 0 ? null : ids));
    return result;
  }

  @override
  Future<int?> update(TModel model, {String? where, List<Object?>? whereArgs, ConflictAlgorithm? conflictAlgorithm}) async {
    final db = await _dbContext.database;
    if (db == null) {
      return null;
    }

    var result = await db.update(table, toMap(model), where: where, whereArgs: whereArgs, conflictAlgorithm: conflictAlgorithm);
    final id = getId(model);
    _dbContext.sendEvent(DbEvent(DbOperationType.update, TModel, id == null ? null : [id]));
    return result;
  }
  @override
  Future<List<Object?>?> batchUpdate(Iterable<TModel> models, {String where(TModel model)?, List<Object?> whereArgs(TModel model)?, ConflictAlgorithm? conflictAlgorithm,
        bool? exclusive, bool? noResult, bool? continueOnError}) async {
    final db = await _dbContext.database;
    if (db == null) {
      return null;
    }

    final batch = db.batch();
    models.forEach((model) {
      batch.update(table, toMap(model), where: where == null ? null : where(model), whereArgs: whereArgs == null ? null : whereArgs(model), conflictAlgorithm: conflictAlgorithm);
    });
    var result =  await batch.commit(exclusive: exclusive, noResult: noResult, continueOnError: continueOnError);
    final ids = models.map((e) => getId(e)).where((element) => element != null).toList();
    _dbContext.sendEvent(DbEvent(DbOperationType.update, TModel, ids.length == 0 ? null : ids));
    return result;
  }
  @override
  Future<int?> updateValues(Map<String, Object?> values,
      {String? where, List<Object?>? whereArgs, ConflictAlgorithm? conflictAlgorithm}) async {
    final db = await _dbContext.database;
    if (db == null) {
      return null;
    }

    var result = await db.update(table, values, where: where, whereArgs: whereArgs, conflictAlgorithm: conflictAlgorithm);
    _dbContext.sendEvent(DbEvent(DbOperationType.update, TModel, null));
    return result;
  }

  @override
  Future<int?> delete({String? where, List<Object?>? whereArgs}) async {
    final db = await _dbContext.database;
    if (db == null) {
      return null;
    }

    var result = db.delete(table, where: where, whereArgs: whereArgs);
    _dbContext.sendEvent(DbEvent(DbOperationType.delete, TModel, null));
    return result;
  }
  @override
  Future<List<Object?>?> batchDelete<T>(Iterable<T> list, {String where(T item)?, List<Object?> whereArgs(T item)?,
    bool? exclusive, bool? noResult, bool? continueOnError}) async {
    final db = await _dbContext.database;
    if (db == null) {
      return null;
    }

    final batch = db.batch();
    list.forEach((item) {
      batch.delete(table, where: where == null ? null : where(item), whereArgs: whereArgs == null ? null : whereArgs(item));
    });
    var result =  await batch.commit(exclusive: exclusive, noResult: noResult, continueOnError: continueOnError);
    _dbContext.sendEvent(DbEvent(DbOperationType.delete, TModel, result));
    return result;
  }
}