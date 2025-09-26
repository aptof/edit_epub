import 'dart:io';
import 'package:path/path.dart' as p;

class TabData {
  final File file;

  String get label => p.basenameWithoutExtension(file.path);

  String content = '';

  TabData(this.file);
}
