import 'dart:io';

import 'package:edit_epub/models/tab_data.dart';
import 'package:edit_epub/views/editor/editor_view_model.dart';
import 'package:edit_epub/widgets/command_widget.dart';
import 'package:edit_epub/widgets/error_text.dart';
import 'package:edit_epub/widgets/tab_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;

class EditorView extends HookWidget {
  EditorView({super.key, required this.viewModel});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final EditorViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final openedTabs = useState(<TabData>[]);
    final selectedTab = useState<TabData?>(null);

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
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(viewModel.folder),
                        );
                      },
                    ),
                    Expanded(child: const SizedBox.shrink()),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  ],
                ),
              ),
              CommandWidget(
                command: viewModel.loadTextFilesCommand,
                successBuilder: (files) {
                  if (files.isEmpty) {
                    return ErrorText('No files in the folder');
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          final file = files[index];
                          final label = p.basenameWithoutExtension(file.path);
                          return ListTile(
                            onTap: () async {
                              // Check if already opened.
                              final isOpened = openedTabs.value.where(
                                (x) => x.label == label,
                              );
                              if (isOpened.isNotEmpty) {
                                selectedTab.value = isOpened.first;
                              } else {
                                final tabData = TabData(file);
                                await viewModel.readContent(tabData);
                                openedTabs.value = [
                                  ...openedTabs.value,
                                  tabData,
                                ];
                                selectedTab.value = tabData;
                              }
                              if (context.mounted) {
                                context.pop();
                              }
                            },
                            leading: const Icon(Icons.description),
                            title: Text(p.basenameWithoutExtension(file.path)),
                          );
                        },
                      ),
                    );
                  }
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
                    ...openedTabs.value.map((tab) {
                      return TabButton(
                        label: tab.label,
                        selected:
                            selectedTab.value != null &&
                            selectedTab.value!.label == tab.label,
                        onTap: () => selectedTab.value = tab,
                        onClose: () {
                          final remaining = openedTabs.value.where(
                            (x) => x.label != tab.label,
                          );
                          if (selectedTab.value != null &&
                              selectedTab.value!.label == tab.label) {
                            if (remaining.isNotEmpty) {
                              selectedTab.value = remaining.first;
                            } else {
                              selectedTab.value = null;
                            }
                          }
                          openedTabs.value = remaining.toList();
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Builder(
                  builder: (context) {
                    if (selectedTab.value != null) {
                      return SingleChildScrollView(
                        child: Text(selectedTab.value!.content),
                      );
                    } else {
                      return ErrorText('No File or tab is selected.');
                    }
                  },
                ),
              ),
            ),
            Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.format_bold),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.format_align_center),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.format_align_justify),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.format_align_right),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.format_align_left),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.title)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.subtitles),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
