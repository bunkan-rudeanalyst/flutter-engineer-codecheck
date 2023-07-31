import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:src/provider/repository_provider.dart';
import 'package:src/view/component/component.dart';
import 'package:src/view/helper/github_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // test list
  List<String> testList = [];

  // TextFormField入力値取得用cotroller
  final TextEditingController _controller = TextEditingController();

  void _onEditingComplete() async {
    // searchをタップしたらキーボードを閉じる
    FocusManager.instance.primaryFocus?.unfocus();

    // 表示するリストを更新
    context.read<RepositoryProvider>().startSearchRepositories();

    // キーワードでリポジトリを検索
    final searchResult =
        await searchRepositoryByKeyword(keyword: _controller.text);

    // ignore: use_build_context_synchronously
    if (!context.mounted) return;

    // 検索結果を用いてproviderで保持しているリポジトリ一覧を更新
    context.read<RepositoryProvider>().updateRepositories(searchResult);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // キーボード外タップにてキーボードを閉じる
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("GitHub Repo Search App"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              // リポジトリ検索キーワード入力用フォーム
              TextField(
                textAlignVertical: TextAlignVertical.center,
                controller: _controller,
                textInputAction: TextInputAction.search,
                onEditingComplete: _onEditingComplete,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 16,
              ),
              // リポジトリ一覧
              const Expanded(child: RepoList())
            ],
          ),
        ),
      ),
    );
  }
}
