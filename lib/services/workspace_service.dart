import 'dart:collection';
import 'dart:io';
import 'package:edit_epub/services/preference_service.dart';
import 'package:edit_epub/services/service.dart';
import 'package:edit_epub/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:path/path.dart' as p;

class WorkspaceService extends Service with ChangeNotifier {
  WorkspaceService(this._storageService, this._preferenceService) {
    _loadRecent();
  }

  final StorageService _storageService;
  final PreferenceService _preferenceService;

  String _selectedFolder = '';
  String get selectedFolder => _selectedFolder;
  String get selectedFolderName => p.basename(_selectedFolder);

  List<File> _textFiles = [];
  List<File> get textFiles => UnmodifiableListView(_textFiles);

  AsyncResult<Unit> selectFolder() async {
    return safeExecute(() async => Success(await _selectFolder()));
  }

  Future<Unit> _selectFolder() async {
    String? result = await FilePicker.platform.getDirectoryPath();
    if (result == null) {
      throw Exception('No folder selected');
    }
    _setFolder(result);
    return unit;
  }

  Future<void> _loadRecent() async {
    final recent = await _preferenceService.getRecentDirectory();
    if (recent.isNotEmpty && recent != selectedFolder) {
      _selectedFolder = recent;
      notifyListeners();
    }
  }

  Future<void> _setFolder(String folder) async {
    if (selectedFolder != folder && folder.isNotEmpty) {
      await _preferenceService.saveRecentDirectory(folder);
      _selectedFolder = folder;
      notifyListeners();
    }
  }

  AsyncResult<List<File>> loadFiles() async {
    return safeExecute(() async => Success(await _loadFiles()));
  }

  Future<List<File>> _loadFiles() async {
    if (_selectedFolder.isNotEmpty) {
      _textFiles = await _storageService.getTextFiles(selectedFolder);
      return UnmodifiableListView(_textFiles);
    } else {
      throw Exception('Please select a folder first');
    }
  }
}
