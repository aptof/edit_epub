import 'package:edit_epub/services/storage_service.dart';
import 'package:edit_epub/services/workspace_service.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:result_command/result_command.dart';
import 'package:path/path.dart' as p;

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._storageService, this._workspaceService) {
    _workspaceService.addListener(notifyListeners);
    selectFolderCommand = Command0(_selectFolder);
  }

  final WorkspaceService _workspaceService;
  final StorageService _storageService;

  String get selectedFolder => p.basename(_workspaceService.selectedFolder);
  String get selectedFolderPath => _workspaceService.selectedFolder;

  late final Command0<Unit> selectFolderCommand;

  AsyncResult<Unit> _selectFolder() {
    return _storageService.selectFolder();
  }

  @override
  void dispose() {
    _workspaceService.removeListener(notifyListeners);
    super.dispose();
  }
}
