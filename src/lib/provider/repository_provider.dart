import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:src/model/model.dart';

/// リポジトリ一覧状態
enum RepoListStatus {
  /// 検索前の場合
  beforeSearch,

  /// 検索中の場合
  searching,

  /// 遅延ロード中
  lazyLoading,

  /// 検索した結果リポジトリが見つからなかった場合
  noRepositoryFound,

  /// 検索した結果リポジトリが見つかった場合
  repositoriesFound,

  /// 検索した結果が不正だった場合
  invalidSearchResultError,

  /// 検索結果の全itemを取得した場合
  allItemFetched
}

/// 取得したリポジトリを管理するprovider
class RepositoryProvider extends ChangeNotifier {
  /// 取得済みリポジトリ一覧
  List<Repository> repositories = [];

  /// リポジトリ情報取得の状態
  RepoListStatus status = RepoListStatus.beforeSearch;

  /// repositoriesに含まれる最大page番号
  int currentPage = 1;

  /// 検索中のキーワード
  String currentKeyword = "";

  /// キーワードに該当した全item数
  /// jsonのtotal_countが該当
  int totalCount = 0;

  /// 検索開始
  void startSearchRepositories() {
    status = RepoListStatus.searching;
    notifyListeners();
  }

  /// 全てのitemを取得したので、これ以上のfetchを行わない
  void terminateSearching() {
    status = RepoListStatus.allItemFetched;
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

  /// Formでのキーワード検索
  Future<List<dynamic>> searchRepositoryByKeyword(
      {required String keyword}) async {
    // キーワードを更新
    currentKeyword = keyword;
    // ページ番号を初期化
    currentPage = 1;
    // リポジトリ一覧を初期化
    repositories.clear();

    // Form入力のキーワード検索なので、pageは1で固定
    final searchedItems =
        await fetchRepositories(keyword: currentKeyword, page: 1);

    return searchedItems;
  }

  /// リポジトリを追加で1ページ分ロード
  Future<void> loadNewPage() async {
    if (currentKeyword.isEmpty) return;

    // 遅延ロード状態に変更
    status = RepoListStatus.lazyLoading;
    notifyListeners();

    // ページをインクリメント
    currentPage++;
    if ((currentPage - 1) * 10 >= totalCount) {
      status = RepoListStatus.repositoriesFound;
      notifyListeners();
    } else {
      final loadedItems =
          await fetchRepositories(keyword: currentKeyword, page: currentPage);

      await updateRepositories(loadedItems);
    }
  }

  /// GitHub API search method
  Future<List<dynamic>> fetchRepositories(
      {required String keyword, required int page}) async {
    // apiキーを環境変数から取得
    const apiKey = String.fromEnvironment("GITHUB_API_KEY");

    // リクエストの設定値
    const String authority = "api.github.com";
    const String unencodedPath = "/search/repositories";
    var url = Uri.https(authority, unencodedPath,
        {"q": keyword, "per_page": "10", "page": page.toString()});
    final Map<String, String> headers = {
      "Accept": "application/vnd.github+json",
      "Authorization": "Bearer $apiKey",
      "X-GitHub-Api-Version": "2022-11-28"
    };

    // リクエストを出す
    var res = await http.get(url, headers: headers);

    // エラーの場合空リストを返す
    if (res.statusCode != 200) return [];

    // Mapにデコード
    final jsonMap = jsonDecode(res.body);

    totalCount = jsonMap["total_count"];
    final List<dynamic> foundItems = jsonMap["items"];

    return foundItems;
  }
}
