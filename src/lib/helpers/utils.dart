import 'dart:math';

//import 'package:logger/web.dart';
import 'package:jiffy/jiffy.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:path/path.dart' as p;
// import 'package:var_dump/var_dump.dart';

class Utils {
  static final logger = SimpleLogger();

  static void dump(dynamic o) {
    err("+++");
    log("> $o");
    if (o is List) {
      for (var v in o) {
        log("> $v");
      }
    } else if (o is Map) {
      o.forEach((k, v) => log("> $k => $v"));
    } else {
      log("> $o");
    }
    err("---");
  }

  static void log(dynamic o) {
    //logger.d(o);
    //logger.setLevel(Level.INFO, includeCallerInfo: false);
    logger.formatter = (info) => '👻: ${info.message}';
    logger.info(o);
  }

  static void err(dynamic o) {
    logger.formatter = (info) => '👻😡😡😡: ${info.message}';
    logger.shout(o);
  }

  static void wtf(dynamic o) {
    logger.formatter = (info) => '👻👹👹👹: ${info.message}';
    logger.shout(o);
  }

  static String generateRandomString(int len) {
    var r = Random.secure();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  static String nth(int number) {
    return number > 0 ? ["th", "st", "nd", "rd"][(number > 3 && number < 21) || number % 10 > 3 ? 0 : number % 10] : "";
  }

  static String formatDate(String? s) {
    final str = s != null ? Jiffy.parse(s).format(pattern: "do MMM yyyy") : "-";

    return str;
  }

  static bool checkFileExtension(String path, String ext) {
    final e = p.extension(path);
    final s = e.split("?");

    //Utils.log("checkFileExtension $e ${s[0]}");
    if (s[0] == ".$ext") {
      return true;
    }
    return false;
  }
}
