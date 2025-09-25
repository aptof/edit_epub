import 'package:edit_epub/services/preference_service.dart';
import 'package:edit_epub/services/workspace_service.dart';
import 'package:edit_epub/services/storage_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get dependencies => [
  Provider(create: (_) => StorageService()),
  Provider(create: (_) => PreferenceService()),
  ChangeNotifierProvider(
    create: (context) => WorkspaceService(context.read(), context.read()),
  ),
];
