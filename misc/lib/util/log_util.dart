import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log extends LogFilter {
  static const bool DEBUG = !kReleaseMode;
  static Level showLevelOnly = Level.verbose;
  static Logger logger = Logger(filter: Log(), level: showLevelOnly);
  static v(dynamic message, {bool debug = true}) =>
      debug ? logger.v(message) : "";
  static d(dynamic message, {bool debug = true}) =>
      debug ? logger.d(message) : "";
  static i(dynamic message, {bool debug = true}) =>
      debug ? logger.i(message) : "";
  static w(dynamic message, {bool debug = true}) =>
      debug ? logger.w(message) : "";
  static e(dynamic message, {bool debug = true}) =>
      debug ? logger.e(message) : "";
  static wtf(dynamic message, {bool debug = true}) =>
      debug ? logger.wtf(message) : "";

  @override
  bool shouldLog(LogEvent event) {
    return DEBUG;
  }
}
