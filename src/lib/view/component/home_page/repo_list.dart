import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:src/provider/repository_provider.dart';
import 'package:src/view/component/home_page/repo_list_tile.dart';

class RepoList extends StatelessWidget {
  const RepoList({super.key});

  @override
  Widget build(BuildContext context) {
    switch (context.watch<RepositoryProvider>().status) {
      case RepoListStatus.beforeSearch:
        return const Center(
          child: Text("Let's search repositories!"),
        );
      case RepoListStatus.searching:
        return const Center(
          child: Text("searching..."),
        );
      case RepoListStatus.noRepositoryFound:
        return const Center(
          child: Text("No repository found"),
        );
      case RepoListStatus.repositoriesFound:
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: context.read<RepositoryProvider>().repositories.length,
          itemBuilder: (context, index) {
            return RepoListTile(
                repository:
                    context.read<RepositoryProvider>().repositories[index]);
          },
        );
      case RepoListStatus.invalidSearchResultError:
      default:
        return const Center(
          child: Text("Error happened"),
        );
    }
  }
}
