import 'dart:io';
import 'package:edit_epub/services/service.dart';

class StorageService extends Service {
  StorageService();

  Future<List<File>> getTextFiles(String path) async {
    final dir = Directory(path);
    if (await dir.exists()) {
      final List<File> files = [];

      await for (final entity in dir.list()) {
        if (entity is File && entity.path.toLowerCase().endsWith('.txt')) {
          files.add(entity);
        }
      }

      return files;
    } else {
      throw Exception('Folder $dir does not exist.');
    }
  }
}
