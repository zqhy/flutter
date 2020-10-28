import 'package:hy/hy.dart';
import 'package:logger/logger.dart' as logger;

class Logger implements ILogger {

  final _logger = logger.Logger();

  @override
  void v(message, [dynamic error, StackTrace stackTrace]) {
    _logger.v(message, error, stackTrace);
  }

  @override
  void d(message, [dynamic error, StackTrace stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  @override
  void i(message, [dynamic error, StackTrace stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  @override
  void w(message, [dynamic error, StackTrace stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  @override
  void e(message, [dynamic error, StackTrace stackTrace]) {
    _logger.e(message, error, stackTrace);
  }
}