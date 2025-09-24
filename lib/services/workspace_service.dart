import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkspaceService extends ChangeNotifier {
  WorkspaceService() {
    _loadRecent();
  }

  final _recentDirectory = 'directory';

  String _selectedFolder = '';
  String get selectedFolder => _selectedFolder;

  Future<String> _getRecentDirectory() async {
    final preferences = await SharedPreferences.getInstance();
    final lastFolder = preferences.getString(_recentDirectory);
    return lastFolder ?? '';
  }

  Future<void> _saveRecentDirectory(String path) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_recentDirectory, path);
  }

  Future<void> _loadRecent() async {
    final recent = await _getRecentDirectory();
    if (recent.isNotEmpty && recent != selectedFolder) {
      _selectedFolder = recent;
      notifyListeners();
    }
  }

  Future<void> setFolder(String folder) async {
    if (selectedFolder != folder && folder.isNotEmpty) {
      await _saveRecentDirectory(folder);
      _selectedFolder = folder;
      notifyListeners();
    }
  }
}
