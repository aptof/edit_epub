import 'package:edit_epub/services/workspace_service.dart';
import 'package:edit_epub/services/storage_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get dependencies => [
  ChangeNotifierProvider(create: (context) => WorkspaceService()),
  Provider(create: (context) => StorageService(context.read())),
];
