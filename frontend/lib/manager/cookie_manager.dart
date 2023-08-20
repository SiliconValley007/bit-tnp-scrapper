import 'package:tnp_scanner/manager/local_storage_manager.dart';

abstract class CookieManager {
  static String? getCookie() {
    return LocalStorage.getCookie();
  }
}
