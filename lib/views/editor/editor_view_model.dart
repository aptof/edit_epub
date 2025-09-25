import 'dart:collection';
import 'dart:io';
import 'package:edit_epub/services/workspace_service.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/src/types.dart';

class EditorViewModel extends ChangeNotifier {
  EditorViewModel(this._workspaceService) {
    _workspaceService.addListener(notifyListeners);
    loadTextFilesCommand = Command0(_load);
  }

  final WorkspaceService _workspaceService;

  String get folder => _workspaceService.selectedFolderName;
  List<File> _textFiles = [];
  List<File> get textFiles => UnmodifiableListView(_textFiles);

  late final Command0<List<File>> loadTextFilesCommand;

  @override
  void dispose() {
    _workspaceService.removeListener(notifyListeners);
    super.dispose();
  }

  AsyncResult<List<File>> _load() async {
    final result = await _workspaceService.loadFiles();
    result.fold((files) {
      _textFiles = files;
    }, (e) => _textFiles = []);
    notifyListeners();
    return result;
  }
}
