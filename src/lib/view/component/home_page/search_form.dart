import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/provider/provider.dart';
import 'package:src/view/helper/helper.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final TextEditingController _controller = TextEditingController();

  void _onEditingComplete() async {
    // searchをタップしたらキーボードを閉じる
    FocusManager.instance.primaryFocus?.unfocus();

    // 表示するリストを更新
    context.read<RepositoryProvider>().startSearchRepositories();

    // キーワードでリポジトリを検索
    final searchResult = await context
        .read<RepositoryProvider>()
        .searchRepositoryByKeyword(keyword: _controller.text);

    // ignore: use_build_context_synchronously
    if (!context.mounted) return;

    // 検索結果を用いてproviderで保持しているリポジトリ一覧を更新
    context.read<RepositoryProvider>().updateRepositories(searchResult);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      controller: _controller,
      textInputAction: TextInputAction.search,
      onEditingComplete: _onEditingComplete,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
    );
  }
}
