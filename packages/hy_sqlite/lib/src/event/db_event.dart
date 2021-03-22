import '../types/db_operation_type.dart';

class DbEvent {
  final DbOperationType operationType;
  final Type table;
  final List<dynamic>? ids;

  DbEvent(this.operationType, this.table, this.ids);

  @override
  String toString() {
    return 'DbEvent{operationType: $operationType, table: $table, ids: $ids}';
  }
}