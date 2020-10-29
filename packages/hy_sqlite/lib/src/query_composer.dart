class QueryComposer {
  static String whereIn(String field, int inLength) {
    var buffer = StringBuffer();
    for(var i = 0; i < inLength; i++) {
      if (buffer.length > 0) {
        buffer.write(", ");
      }
      buffer.write("?");
    }
    return "$field IN (${buffer.toString()})";
  }

  static String whereNotIn(String field, int inLength) {
    var buffer = StringBuffer();
    for(var i = 0; i < inLength; i++) {
      if (buffer.length > 0) {
        buffer.write(", ");
      }
      buffer.write("?");
    }
    return "$field NOT IN (${buffer.toString()})";
  }

  static Map<String, List<dynamic>> whereAnd(Map<String, dynamic> wheres) {
    final where = StringBuffer();
    final whereArgs = List<dynamic>();
    wheres.forEach((filed, value) {
      if (value != null) {
        if (where.length > 0) {
          where.write(" AND ");
        }
        where.write("$filed = ?");
        whereArgs.add(value);
      }
    });
    return whereArgs.length == 0 ? null : { where.toString() : whereArgs };
  }
}