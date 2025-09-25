import 'package:edit_epub/services/workspace_service.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:result_command/result_command.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._workspaceService) {
    _workspaceService.addListener(notifyListeners);
    selectFolderCommand = Command0(_selectFolder);
  }

  final WorkspaceService _workspaceService;

  String get selectedFolder => _workspaceService.selectedFolderName;
  String get selectedFolderPath => _workspaceService.selectedFolder;

  late final Command0<Unit> selectFolderCommand;

  AsyncResult<Unit> _selectFolder() {
    return _workspaceService.selectFolder();
  }

  @override
  void dispose() {
    _workspaceService.removeListener(notifyListeners);
    super.dispose();
  }
}
