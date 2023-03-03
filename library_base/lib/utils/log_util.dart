/**
 * @Author: Sky24n
 * @GitHub: https://github.com/Sky24n
 * @Description: Widget Util.
 * @Date: 2018/9/29
 */

/// Log Util.
class LogUtil {
  static const String tagDef = "LogUtil";

  static bool debuggable = true; //是否是debug模式,true: log v 不输出.
  static String tagLog = tagDef;

  static void init({bool isDebug = false, String tag = tagDef}) {
    debuggable = isDebug;
    tagLog = tag;
  }

  static void e(Object object, {String? tag}) {
    _printLog(tag, ' e ', object);
  }

  static void v(Object object, {String? tag}) {
    if (debuggable) {
      _printLog(tag, ' v ', object);
    }
  }

  static void _printLog(String? tag, String stag, Object object) {
    String da = object.toString();
    String tagS = (tag == null || tag.isEmpty) ? tagLog : tag;
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("$tagS $stag ${da.substring(0, 512)}");
        da = da.substring(512, da.length);
      } else {
        print("$tagS $stag $da");
        da = "";
      }
    }
  }
}
