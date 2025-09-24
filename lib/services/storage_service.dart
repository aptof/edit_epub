import 'package:edit_epub/services/service.dart';
import 'package:edit_epub/services/workspace_service.dart';
import 'package:result_dart/result_dart.dart';
import 'package:file_picker/file_picker.dart';

class StorageService extends Service {
  StorageService(this._workspaceService);

  final WorkspaceService _workspaceService;

  AsyncResult<Unit> selectFolder() async {
    return safeExecute(() async => Success(await _selectFolder()));
  }

  Future<Unit> _selectFolder() async {
    String? result = await FilePicker.platform.getDirectoryPath();
    if (result == null) {
      throw Exception('No folder selected');
    }
    _workspaceService.setFolder(result);
    return unit;
  }
}
