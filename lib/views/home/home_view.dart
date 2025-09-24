import 'package:edit_epub/utils/routes.dart';
import 'package:edit_epub/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Last Folder'),
                const SizedBox(height: 24),
                ListenableBuilder(
                  listenable: viewModel,
                  builder: (context, _) {
                    if (viewModel.selectedFolderPath.isEmpty) {
                      return Text(
                        'No folder is selected',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () => context.go(Routes.editor),
                      child: Card(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        child: ListTile(
                          title: Text(viewModel.selectedFolder),
                          subtitle: Text(viewModel.selectedFolderPath),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => viewModel.selectFolderCommand.execute(),
                  child: const Text('Select Folder'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
