import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHelper {
  static late FlutterSecureStorage storage;

  static init() async {
    storage = const FlutterSecureStorage();
  }

  static Future<void> setData({
    required String key,
    required String value,
  }) async {
    return await storage.write(key:key, value:value);
  }

  static Future<String?> getData({required String key}) {
    return storage.read(key:key);
  }

  static Future<void> removeData({
    required String key,
  }) async {
    return await storage.delete(key: key);
  }

}
