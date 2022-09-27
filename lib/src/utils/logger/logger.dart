import 'package:logger/logger.dart';

class Log {

  Log._loggerType({loggerType = 'simple'}) {
    switch (loggerType) {
      case 'simple':
        _logger =
            Logger(printer: SimplePrinter(printTime: true, colors: false));
        break;
      case 'pretty':
        _logger = Logger(
          printer: PrettyPrinter(
            methodCount: 2,
            // number of method calls to be displayed
            errorMethodCount: 8,
            // number of method calls if stacktrace is provided
            lineLength: 120,
            // width of the output
            colors: true,
            // Colorful log messages
            printEmojis: true,
            // Print an emoji for each log message
            printTime: false
            // Should each log print contain a timestamp
            ,
          ),
        );
        break;
      case 'fmt':
        _logger = Logger(printer: LogfmtPrinter());
        break;
      case 'prefix':
        _logger =
            Logger(printer: PrefixPrinter(SimplePrinter(printTime: true)));
        break;
      default:
        throw ArgumentError('config for logger $loggerType not exists');
    }
  }
  late Logger _logger;

  static final Log _singleton = Log._loggerType();

  static void verbose(String message) => _singleton._logger.v(message);

  static void debug(String message) => _singleton._logger.d(message);

  static void info(String message) => _singleton._logger.i(message);

  static void error(String? message, {StackTrace? stackTrace}) {
    _singleton._logger.e(message);
    if (stackTrace == null) {
      _singleton._logger.e(stackTrace.toString());
    }
  }

  static void warning(String message) => _singleton._logger.w(message);
}
