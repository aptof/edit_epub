import 'package:edit_epub/views/editor/editor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EditorView extends StatelessWidget {
  EditorView({super.key, required this.viewModel});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final EditorViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Card(
                child: Row(
                  children: [
                    ListenableBuilder(
                      listenable: viewModel,
                      builder: (context, child) {
                        return Text(viewModel.folder);
                      },
                    ),
                    Expanded(child: const SizedBox.shrink()),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                  ],
                ),
              ),
            ),
            Text('EDitor'),
          ],
        ),
      ),
    );
  }
}
