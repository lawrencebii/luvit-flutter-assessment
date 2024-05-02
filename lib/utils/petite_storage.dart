import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static StorageUtil? _storageUtil;
  static SharedPreferences? _preferences;
  static Future<StorageUtil> getInstance() async {
    if (_storageUtil == null) {
      // keep local instance till it is fully initialized.
      var secureStorage = StorageUtil._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil!;
  }

  StorageUtil._();
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // get string
  static String getString(
      {required String key, String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences?.getString(key) ?? defValue;
  }

  // put string
  static Future<bool>? putString(
      {required String key, required String value}) {
    if (_preferences == null) return null;
    return _preferences?.setString(key, value);
  }

  static Future<bool>? resetpreferencedata(
      {required String key}) {
    if (_preferences == null) return null;
    return _preferences?.remove(key);
  }

  static Future<void> logout() async {
    if (_preferences == null) return;
    await _preferences?.clear(); // Clears all stored values
  }
}
