import 'package:flutter/material.dart';

import 'package:src/model/model.dart';

/// リポジトリ一覧状態
enum RepoListStatus {
  /// 検索前の場合
  beforeSearch,

  /// 検索中の場合
  searching,

  /// 検索した結果リポジトリが見つからなかった場合
  noRepositoryFound,

  /// 検索した結果リポジトリが見つかった場合
  repositoriesFound,

  /// 検索した結果が不正だった場合
  invalidSearchResultError
}

/// 取得したリポジトリを管理するprovider
class RepositoryProvider extends ChangeNotifier {
  /// 取得済みリポジトリ一覧
  List<Repository> repositories = [];

  RepoListStatus status = RepoListStatus.beforeSearch;

  /// 検索開始
  Future<void> startSearchRepositories() async {
    status = RepoListStatus.searching;
    notifyListeners();
  }

  /// リポジトリ一覧を更新
  Future<void> updateRepositories(List<dynamic> foundRepositoris) async {
    if (foundRepositoris.isEmpty) {
      repositories = [];
      status = RepoListStatus.noRepositoryFound;
    } else if (foundRepositoris[0] is! Map) {
      repositories = [];
      status = RepoListStatus.invalidSearchResultError;
    } else {
      for (int i = 0; i < foundRepositoris.length; i++) {
        final repo = Repository.fromJson(foundRepositoris[i], []);
        repositories.add(repo);
      }
      status = RepoListStatus.repositoriesFound;
    }

    notifyListeners();
  }

  /// リポジトリ一覧を空にする
  void clearRepositories() {
    repositories.clear();
    status = RepoListStatus.beforeSearch;
    notifyListeners();
  }

  /// idでリポジトリを指定して取得する
  Repository? getRepositoryById(int id) {
    if (repositories.isEmpty) return null;

    for (int i = 0; i < repositories.length; i++) {
      if (id == repositories[i].id) return repositories[i];
    }

    return null;
  }
}
