import 'package:sqflite/sqflite.dart';

import '../db_context.dart';

abstract class IRepository<TModel>{
  IDbContext get dbContext;
  String get table;
  dynamic getId(TModel model);
  Map<String, dynamic> toMap(TModel model);
  TModel fromMap(Map<String, dynamic> map);

  Future<TModel> getFirstOrDefault({bool distinct,
    List<String> columns,
    String where,
    List<dynamic> whereArgs,
    String groupBy,
    String having,
    String orderBy});

  Future<List<TModel>> query({bool distinct,
    List<String> columns,
    String where,
    List<dynamic> whereArgs,
    String groupBy,
    String having,
    String orderBy,
    int limit,
    int offset});

  Future<int> insert(TModel model,
      {String nullColumnHack, ConflictAlgorithm conflictAlgorithm});
  Future<List<dynamic>> batchInsert(Iterable<TModel> models,
      {String nullColumnHack, ConflictAlgorithm conflictAlgorithm,
        bool exclusive, bool noResult, bool continueOnError});

  Future<int> update(TModel model,
      {String where, List<dynamic> whereArgs, ConflictAlgorithm conflictAlgorithm});
  Future<List<dynamic>> batchUpdate(Iterable<TModel> models,
      {String where(TModel model), List<dynamic> whereArgs(TModel model), ConflictAlgorithm conflictAlgorithm,
        bool exclusive, bool noResult, bool continueOnError});
  Future<int> updateValues(Map<String, dynamic> values,
      {String where, List<dynamic> whereArgs, ConflictAlgorithm conflictAlgorithm});

  Future<int> delete({String where, List<dynamic> whereArgs});
  Future<List<dynamic>> batchDelete<T>(Iterable<T> list, {String where(T item), List<dynamic> whereArgs(T item),
    bool exclusive, bool noResult, bool continueOnError});
}