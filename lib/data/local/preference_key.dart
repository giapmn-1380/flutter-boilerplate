import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceKey {
  hasLogin,
}

extension PreferenceKeyEx on PreferenceKey {
  String get keyString {
    switch (this) {
      case PreferenceKey.hasLogin:
        return "has_login";
      default:
        return "";
    }
  }

  void setStringList(value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setStringList(keyString, value);
  }

  Future<List<String>> getStringList([List<String>? defaultValue]) async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey(keyString)) {
      return defaultValue ?? List.empty();
    }
    return pref.getStringList(keyString) ?? List.empty();
  }

  Future<void> setString(value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(keyString, value);
  }

  Future<String> getString([String? defaultValue]) async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey(keyString)) {
      return defaultValue ?? "";
    }
    return pref.getString(keyString) ?? "";
  }

  Future<void> setBool(value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(keyString, value);
  }

  Future<bool> getBool([bool? defaultValue]) async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey(keyString)) {
      return defaultValue ?? false;
    }
    return pref.getBool(keyString) ?? false;
  }

  Future<void> setInt(value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt(keyString, value);
  }

  Future<int> getInt([int? defaultValue]) async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey(keyString)) {
      return defaultValue ?? 0;
    }
    return pref.getInt(keyString) ?? 0;
  }

  Future<bool> isExists() async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey(keyString);
  }

  Future<bool> remove() async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(keyString);
  }

  Future<void> reload() async {
    final pref = await SharedPreferences.getInstance();
    return pref.reload();
  }
}
