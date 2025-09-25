import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  final _recentDirectory = 'directory';

  Future<String> getRecentDirectory() async {
    final preferences = await SharedPreferences.getInstance();
    final lastFolder = preferences.getString(_recentDirectory);
    return lastFolder ?? '';
  }

  Future<void> saveRecentDirectory(String path) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_recentDirectory, path);
  }
}
