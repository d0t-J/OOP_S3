import "package:logger/logger.dart";

class LoggerUtil {
  static final PrettyPrinter _printer = PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 3,
    lineLength: 50,
    colors: true,
    printEmojis: true,
  );

  static Logger createLogger() {
    return Logger(
      printer: _printer,
      filter: ProductionFilter(),
    );
  }
}
