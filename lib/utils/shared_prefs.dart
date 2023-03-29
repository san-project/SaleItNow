import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences prefs;
  SharedPrefs._();
  static final _instance = SharedPrefs._();
  factory SharedPrefs.instance() => _instance;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void setToken(String token) => prefs.setString('token', token);
  String? get token => prefs.getString('token');
  void setUserId(String userId) => prefs.setString('userId', userId);
  String? get userId => prefs.getString('userId');
  void set(bool isAdmin) => prefs.setBool('isAdmin', isAdmin);
  bool get isAdmin => prefs.getBool('token') ?? false;

  Future<bool> clear() async => await prefs.clear();
}
