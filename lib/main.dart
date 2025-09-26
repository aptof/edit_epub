import 'package:edit_epub/utils/dependency.dart';
import 'package:edit_epub/utils/routes.dart';
import 'package:edit_epub/utils/theme.dart';
import 'package:edit_epub/views/editor/editor_view.dart';
import 'package:edit_epub/views/editor/editor_view_model.dart';
import 'package:edit_epub/views/home/home_view.dart';
import 'package:edit_epub/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) =>
          HomeView(viewModel: HomeViewModel(context.read())),
      routes: [
        GoRoute(
          path: Routes.editor,
          builder: (context, state) => EditorView(
            viewModel: EditorViewModel(context.read(), context.read()),
          ),
        ),
      ],
    ),
  ],
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: dependencies, child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}
