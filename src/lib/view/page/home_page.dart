import 'package:flutter/material.dart';

import 'package:src/view/component/component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;

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
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              // リポジトリ検索キーワード入力用フォーム
              SearchForm(),
              SizedBox(
                height: 16,
              ),
              // リポジトリ一覧
              Expanded(child: RepoList())
            ],
          ),
        ),
      ),
    );
  }
}
