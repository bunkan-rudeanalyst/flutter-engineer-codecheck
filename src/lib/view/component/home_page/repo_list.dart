import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:src/provider/repository_provider.dart';
import 'package:src/view/component/home_page/repo_list_tile.dart';

class RepoList extends StatefulWidget {
  const RepoList({super.key});

  @override
  State<RepoList> createState() => _RepoListState();
}

class _RepoListState extends State<RepoList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0.0) {
        // 遅延ロードで1ページ追加
        context.read<RepositoryProvider>().loadNewPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

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
          controller: _scrollController,
          separatorBuilder: (context, index) => const Divider(),
          itemCount: context.read<RepositoryProvider>().repositories.length,
          itemBuilder: (context, index) {
            return RepoListTile(
                repository:
                    context.read<RepositoryProvider>().repositories[index]);
          },
        );
      case RepoListStatus.lazyLoading:
        final readProvider = context.read<RepositoryProvider>();
        return ListView.separated(
          controller: _scrollController,
          separatorBuilder: (context, index) {
            // 最後のseparaterは表示しない
            if (index == readProvider.repositories.length) {
              return const SizedBox(height: 0);
            }

            return const Divider();
          },
          // 最後にロードアニメを表示するので表示item数を1追加
          itemCount: readProvider.repositories.length + 1,
          itemBuilder: (context, index) {
            // 最後のアイテムはロードアニメ
            if (index == readProvider.repositories.length) {
              return const SizedBox(
                  height: 50,
                  child: Center(
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator())));
            }
            return RepoListTile(repository: readProvider.repositories[index]);
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
