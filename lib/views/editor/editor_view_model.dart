import 'dart:io';
import 'package:edit_epub/models/tab_data.dart';
import 'package:edit_epub/services/storage_service.dart';
import 'package:edit_epub/services/workspace_service.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class EditorViewModel extends ChangeNotifier {
  EditorViewModel(this._workspaceService, this._storageService) {
    _workspaceService.addListener(notifyListeners);
    loadTextFilesCommand = Command0(_load)..execute();
  }

  final WorkspaceService _workspaceService;
  final StorageService _storageService;

  String get folder => _workspaceService.selectedFolderName;

  late final Command0<List<File>> loadTextFilesCommand;

  @override
  void dispose() {
    _workspaceService.removeListener(notifyListeners);
    super.dispose();
  }

  AsyncResult<List<File>> _load() {
    return _workspaceService.loadFiles();
  }

  Future<void> readContent(TabData tabData) async {
    tabData.content = await _storageService.readText(tabData.file);
  }
}
